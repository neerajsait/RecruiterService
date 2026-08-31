package com.klef.jfsd.springboot.config;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

public class SecurityFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 1. Set Content-Type with UTF-8 character encoding and generic security headers
        // Ensure character encoding mismatch (Header Versus Meta Charset) is resolved
        httpResponse.setCharacterEncoding("UTF-8");

        // 2. Generate a secure random nonce for CSP (fixes inline scripts/styles rules)
        byte[] nonceBytes = new byte[16];
        new SecureRandom().nextBytes(nonceBytes);
        String cspNonce = Base64.getEncoder().encodeToString(nonceBytes);
        httpRequest.setAttribute("cspNonce", cspNonce);

        // 3. Content Security Policy (CSP) Header with nonces and strict fallback-less directives
        String cspPolicy = "default-src 'self'; " +
                "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdnjs.cloudflare.com https://cdn.jsdelivr.net; " +
                "style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://cdn.jsdelivr.net https://stackpath.bootstrapcdn.com https://fonts.googleapis.com; " +
                "font-src 'self' https://cdnjs.cloudflare.com https://fonts.gstatic.com; " +
                "img-src 'self' data: https://img.icons8.com; " +
                "connect-src 'self'; " +
                "frame-ancestors 'self'; " +
                "form-action 'self'; " +
                "base-uri 'self';";
        httpResponse.setHeader("Content-Security-Policy", cspPolicy);

        // 4. Missing Anti-clickjacking Header
        httpResponse.setHeader("X-Frame-Options", "SAMEORIGIN");

        // 5. X-Content-Type-Options Header Missing
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");

        // 6. CSRF Token Logic
        HttpSession session = httpRequest.getSession(true);
        String sessionToken = (String) session.getAttribute("csrfToken");
        if (sessionToken == null) {
            byte[] randomBytes = new byte[32];
            new SecureRandom().nextBytes(randomBytes);
            sessionToken = Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
            session.setAttribute("csrfToken", sessionToken);
        }

        // Set token in request attribute for JSP access
        httpRequest.setAttribute("csrfToken", sessionToken);

        // 7. CSRF validation on state-changing requests
        String method = httpRequest.getMethod();
        if ("POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method) || "DELETE".equalsIgnoreCase(method)) {
            String requestToken = httpRequest.getParameter("_csrf");
            if (requestToken == null) {
                requestToken = httpRequest.getHeader("X-CSRF-TOKEN");
            }

            if (requestToken == null || !requestToken.equals(sessionToken)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or missing CSRF token");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
