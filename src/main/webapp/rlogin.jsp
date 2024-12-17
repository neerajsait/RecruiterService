<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Login - CareerStream</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            margin: 0;
            background-image: linear-gradient(135deg, var(--background-color) 0%, #e6e9f0 100%);
        }

        .login-container {
            display: flex;
            width: 900px;
            height: 600px;
            background-color: var(--white);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .login-image {
            flex: 1;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 810" preserveAspectRatio="xMinYMin slice"><path fill="%230112AC" d="M0 0h1440v810H0z"/><defs><linearGradient id="a" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="%230112AC"/><stop offset="100%" stop-color="%234A90E2"/></linearGradient></defs><path fill="url(%23a)" d="M0 386l80-37.3C160 312 320 238 480 202.7c160-35.4 320 2.6 480 37.3 160 34.7 320 64 480 55.7 160-8.4 320-54.4 400-77.4l80-23V810H0Z" opacity=".5"/></svg>');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: var(--white);
            padding: 30px;
            text-align: center;
        }

        .login-image h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .login-image p {
            font-size: 1rem;
            max-width: 350px;
            line-height: 1.6;
        }

        .login-form {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 50px;
            background-color: var(--white);
        }

        .login-form h1 {
            color: var(--primary-color);
            margin-bottom: 30px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .login-form h1 i {
            color: var(--secondary-color);
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
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(1, 18, 172, 0.1);
        }

        .form-group .icon {
            position: absolute;
            right: 15px;
            top: 45px;
            color: #a0a0a0;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
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
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .additional-links a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                width: 95%;
                height: auto;
            }

            .login-image {
                display: none;
            }

            .login-form {
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-image">
            <h2>Welcome Back, Recruiter!</h2>
            <p>Discover top talent and streamline your recruitment process with CareerStream's intuitive platform.</p>
        </div>
        <div class="login-form">
            <h1><i class="fas fa-user-tie"></i>Recruiter Login</h1>
            <form action="checkreclogin" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="remail" required placeholder="Enter your email">
                    <i class="fas fa-envelope icon"></i>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="rpwd" required placeholder="Enter your password">
                    <i class="fas fa-lock icon"></i>
                </div>
                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i>Login
                </button>
                <div class="additional-links">
                    
                    <a href="/recruiter/rreg">Register as New Recruiter</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
        