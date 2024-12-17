<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Registration</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #f0f2f5;
        }

        .navbar {
            background-color: #1E3264;
            padding: 15px;
            text-align: left;
        }

        .navbar h1 {
            color: white;
            font-size: 24px;
            font-weight: bold;
            margin-left: 20px;
        }

        .container {
            height: calc(150vh - 20px);
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f2f5;
            margin-top: 20px;
        }

        .registration-box {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px;
        }

        .registration-box h2 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .input-group label {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input,
        .input-group select,
        .input-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
        }

        .button-container {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .button-container input[type="submit"] {
            width: 48%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-container input[type="submit"]:hover {
            background-color: #218838;
        }

        .button-container input[type="reset"] {
            width: 48%;
            padding: 10px;
            background-color: #dc3545;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-container input[type="reset"]:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    
    <div class="navbar">
        <h1>Career Stream</h1>
    </div>

    <div class="container">
        <div class="registration-box">
            <h2>Recruiter Registration</h2>
            <form method="post" action="insertrec">
                <div class="input-group">
                    <label for="rname">Enter Name</label>
                    <input type="text" id="rname" name="rname" required/>
                </div>
                <div class="input-group">
                    <label>Select Gender</label>
                    <input type="radio" id="male" name="rgender" value="MALE" required/>
                    <label for="male">Male</label>
                    <input type="radio" id="female" name="rgender" value="FEMALE" required/>
                    <label for="female">Female</label>
                    <input type="radio" id="others" name="rgender" value="OTHERS" required/>
                    <label for="others">Others</label>
                </div>
                <div class="input-group">
                    <label for="rdob">Enter Date of Birth</label>
                    <input type="date" id="rdob" name="rdob" required/>
                </div>
                <div class="input-group">
                    <label for="rlocation">Enter Location</label>
                    <input type="text" id="rlocation" name="rlocation" required/>
                </div>
                <div class="input-group">
                    <label for="remail">Enter Email ID</label>
                    <input type="email" id="remail" name="remail" required/>
                </div>
                <div class="input-group">
                    <label for="rpwd">Enter Password</label>
                    <input type="password" id="rpwd" name="rpwd" required/>
                </div>
                <div class="input-group">
                    <label for="rcontact">Enter Contact</label>
                    <input type="tel" id="rcontact" name="rcontact" required/>
                </div> 
                <div class="input-group">
                    <label for="aboutMe">About Me</label>
                    <textarea id="aboutMe" name="aboutMe" maxlength="250" rows="3" required></textarea>
                </div>
                <div class="input-group">
                    <label for="education">Education</label>
                    <input type="text" id="education" name="education" maxlength="150" required/>
                </div>
                <div class="input-group">
                    <label for="certifications">Certifications</label>
                    <input type="text" id="certifications" name="certifications" maxlength="150" required/>
                </div>
                <div class="input-group">
                    <label for="skills">Skills</label>
                    <input type="text" id="skills" name="skills" maxlength="50" required/>
                </div>
                <div class="input-group">
                    <label for="links">Links</label>
                    <textarea id="links" name="links" maxlength="10000" rows="4" required></textarea>
                </div>
                <div class="button-container">
                    <input type="submit" value="Register"/>
                    <input type="reset" value="Clear"/>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
