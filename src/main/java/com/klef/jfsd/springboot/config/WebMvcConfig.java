package com.klef.jfsd.springboot.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private SessionInterceptor sessionInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(sessionInterceptor)
                .addPathPatterns("/recruiter/**")
                .excludePathPatterns(
                        "/recruiter",
                        "/recruiter/",
                        "/recruiter/rlogin",
                        "/recruiter/checkreclogin",
                        "/recruiter/rreg",
                        "/recruiter/insertrec",
                        "/recruiter/rsessionexpiry",
                        "/recruiter/rpending",
                        "/recruiter/rblocked",
                        "/recruiter/css/**",
                        "/recruiter/js/**",
                        "/recruiter/images/**"
                );
    }
}
