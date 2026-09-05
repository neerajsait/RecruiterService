<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>System Error - Recruiter Service</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        color: #333;
        text-align: center;
        padding: 50px;
    }
    .error-container {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        padding: 40px;
        max-width: 600px;
        margin: 0 auto;
    }
    h1 {
        color: #dc3545;
    }
    p {
        font-size: 18px;
        margin: 20px 0;
    }
    .btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        margin-top: 20px;
    }
    .btn:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <div class="error-container">
        <h1>Internal Server Error (500)</h1>
        <p>Data must come from the student and admin as this is recruiter service.</p>
        <a href="/recruiter/rhome" class="btn">Back to Home</a>
    </div>
</body>
</html>
