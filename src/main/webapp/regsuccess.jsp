<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Success</title>
    <style>
       
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f0f8ff;
        }

        .success-box {
            text-align: center;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
        }

        .success-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 15px;
        }

        .success-message {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        .login-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #1E3264;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .login-link:hover {
            background-color: #1A2B57;
        }
    </style>
</head>
<body>
    <div class="success-box">
        <!-- Success Icon -->
       

        <!-- Dynamic Success Message -->
        <div class="success-message">
            <c:out value="${message}" />
        </div>

        <!-- Login Link as Button -->
        <a href="rlogin" class="login-link">Login Here</a>
    </div>
</body>
</html>
