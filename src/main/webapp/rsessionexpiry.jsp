<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Expiry</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@400;700&display=swap">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
/* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'poppins', sans-serif;
}
        body {
            font-family: 'poppins', sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 600px;
            position: relative;
        }
        .video {
            width: 100%;
            max-width: 300px;
            margin-bottom: 20px;
            border-radius: 10px;
        }
        .message {
            font-size: 1.5em;
            color: #ff6f61;
        }
        .button {
            margin-top: 20px;
        }
        .button a {
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 700;
            transition: background-color 0.3s;
        }
        .button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <img alt="image" src="${pageContext.request.contextPath}/images/sessionexpired.gif">
        <div class="message">
            Oops! Your session has expired.
        </div>
        <p>Please log in again to continue.</p>
        <div class="button">
            <a href="rlogin">Login</a>
        </div>
    </div>
</body>
</html>
