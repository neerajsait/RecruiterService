<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Portal - Registration Pending</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
        body {
            font-family: poppins, sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
            align-items: center;
            justify-content: center;
            background-color: #f4f4f9;
        }
        .image-section {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        .image-section img {
            width: 400px; /* Adjust the width */
            height: 400px; /* Maintain aspect ratio */
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .text-section {
            text-align: center;
            max-width: 600px;
        }
        h1 {
            font-size: 28px;
            color: red;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            color: #2d0374;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <div class="image-section">
        <img src="${pageContext.request.contextPath}/images/blocked.png" alt="Pending Approval">
    </div>
    <div class="text-section">
        <h1 >You are Blocked!!!!</h1>
        <p>Your Account has been blocked by the Admin. contact admin for more details</p>
    </div>
</body>
</html>
