<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CareerStream Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.header {
    width: 100%;
    padding: 15px 0;
    background-color: #1a1f60;
    text-align: center;
    color: white;
}

.header h1 {
    font-size: 24px;
    font-weight: bold;
}

.container {
    text-align: center;
    padding: 20px;
    max-width: 800px;
    margin-top: 40px;
}

.container h2 {
    margin-bottom: 20px;
    font-size: 18px;
    color: #000;
}

.roles {
    display: flex;
    justify-content: space-around;
    gap: 30px;
}

.role {
    text-align: center;
    width: 150px;
}

.role img {
    width: 80px;
    height: 80px;
    margin-bottom: 10px;
}

button {
    background-color: #1a1f60;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
}

button:hover {
    background-color: #333e92;
}

</style>
    <div class="header">
        <h1>CareerStream</h1>
    </div>
    <div class="container">
        <h2>Select Your Role To Login</h2>
        <div class="roles">
            <div class="role">
                <img src="https://img.icons8.com/ios-filled/100/000000/admin-settings-male.png" alt="Admin Icon">
                <button>Admin</button>
            </div>
            <div class="role">
                <img src="https://img.icons8.com/ios-filled/100/000000/student-male.png" alt="Student Icon">
                <button>Student</button>
            </div>
            <div class="role">
                <img src="https://img.icons8.com/ios-filled/100/000000/organization.png" alt="Recruiter Icon">
                <button onclick="location.href='rlogin'">Recruiter</button>
            </div>
        </div>
    </div>
</body>
</html>
