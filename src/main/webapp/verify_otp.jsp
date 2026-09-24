<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - CareerStream</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" />
    <style>
        :root {
            --primary-color: #0112AC;
            --secondary-color: #4A90E2;
            --background-color: #f4f6f9;
            --text-color: #2c3e50;
            --white: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', 'Segoe UI', Roboto, sans-serif;
        }

        body {
            background-color: var(--background-color);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, var(--background-color) 0%, #e6e9f0 100%);
        }

        .login-container {
            display: flex;
            width: 450px;
            background-color: var(--white);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            flex-direction: column;
            padding: 50px;
        }

        .login-form h1 {
            color: var(--primary-color);
            margin-bottom: 20px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-color);
            font-weight: 600;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            text-align: center;
            letter-spacing: 5px;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(1, 18, 172, 0.1);
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(1, 18, 172, 0.3);
        }

        .additional-links {
            margin-top: 20px;
            text-align: center;
        }

        .additional-links a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .error-msg {
            background-color: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
            border: 1px solid #ef9a9a;
        }

        .success-msg {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
            border: 1px solid #c8e6c9;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h1><i class="fas fa-shield-alt"></i>Verify OTP</h1>
            <p style="text-align:center; margin-bottom: 20px; color: #7f8c8d;">Enter the 6-digit OTP sent to your email.</p>
            
            <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println("<div class='success-msg'>" + message + "</div>");
            }
            
            String error = (String) request.getAttribute("error");
            if (error != null) {
                out.println("<div class='error-msg'>" + error + "</div>");
            }
            %>
            
            <form action="verify_otp" method="post">
                <div class="form-group">
                    <label for="otp">One-Time Password (OTP)</label>
                    <input type="text" id="otp" name="otp" required placeholder="XXXXXX" maxlength="6">
                </div>
                <button type="submit" class="login-btn">
                    Verify Identity
                </button>
                <div class="additional-links">
                    <a href="/recruiter/forgot_password">Didn't receive it? Try again.</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
