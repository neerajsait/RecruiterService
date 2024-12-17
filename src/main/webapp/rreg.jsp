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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(90deg, #1a237e 0%, #283593 100%);
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar h1 {
            color: white;
            font-size: 1.8rem;
            font-weight: 600;
            margin-left: 2rem;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .registration-box {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 1400px;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .registration-box h2 {
            color: #1a237e;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            text-align: center;
            font-weight: 600;
        }

        .error-message {
            background-color: #fff3f3;
            color: #dc3545;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid #dc3545;
        }

        .error-message a {
            color: #0056b3;
            text-decoration: none;
            font-weight: 500;
        }

        .error-message a:hover {
            text-decoration: underline;
        }

        .input-group {
            margin-bottom: 1.5rem;
        }

        .input-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #374151;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .input-group input[type="text"],
        .input-group input[type="email"],
        .input-group input[type="password"],
        .input-group input[type="tel"],
        .input-group input[type="date"] {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            outline: none;
            border-color: #1a237e;
            box-shadow: 0 0 0 3px rgba(26, 35, 126, 0.1);
        }

        .gender-group {
            display: flex;
            gap: 1.5rem;
            margin-top: 0.5rem;
        }

        .gender-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .gender-option input[type="radio"] {
            width: 1.2rem;
            height: 1.2rem;
            accent-color: #1a237e;
        }

        .button-container {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .button-container input {
            flex: 1;
            padding: 0.75rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .button-container input[type="submit"] {
            background: linear-gradient(135deg, #1a237e 0%, #283593 100%);
            color: white;
        }

        .button-container input[type="reset"] {
            background: #dc3545;
            color: white;
        }

        .button-container input[type="submit"]:hover {
            background: linear-gradient(135deg, #283593 0%, #1a237e 100%);
            transform: translateY(-2px);
        }

        .button-container input[type="reset"]:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .registration-box {
                padding: 1.5rem;
            }

            .button-container {
                flex-direction: column;
            }

            .gender-group {
                flex-direction: column;
                gap: 0.5rem;
            }
        }

        /* Form Validation Styles */
        .input-group input:invalid {
            border-color: #dc3545;
        }

        .input-group input:invalid:focus {
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }

        /* Input Placeholder Styling */
        ::placeholder {
            color: #9ca3af;
            opacity: 1;
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
            
            <% String errorMessage = (String) request.getAttribute("errorMessage");
               if (errorMessage != null) { %>
                <div class="error-message">
                    <%= errorMessage %> <a href="login.jsp">Login Here</a>
                </div>
            <% } %>
            
            <form method="post" action="insertrec" autocomplete="off">
                <div class="input-group">
                    <label for="rname">Full Name</label>
                    <input 
                        type="text" 
                        id="rname" 
                        name="rname" 
                        placeholder="Enter your full name"
                        required 
                    />
                </div>

                <div class="input-group">
                    <label>Gender</label>
                    <div class="gender-group">
                        <label class="gender-option">
                            <input type="radio" name="rgender" value="MALE" required/>
                            Male
                        </label>
                        <label class="gender-option">
                            <input type="radio" name="rgender" value="FEMALE" required/>
                            Female
                        </label>
                        <label class="gender-option">
                            <input type="radio" name="rgender" value="OTHERS" required/>
                            Others
                        </label>
                    </div>
                </div>

                <div class="input-group">
                    <label for="rdob">Date of Birth</label>
                    <input 
                        type="date" 
                        id="rdob" 
                        name="rdob" 
                        required
                    />
                </div>

                <div class="input-group">
                    <label for="elocation">Location</label>
                    <input 
                        type="text" 
                        id="elocation" 
                        name="rlocation" 
                        placeholder="Enter your location"
                        required 
                    />
                </div>
                
                <div class="input-group">
                    <label for="elocation">Company</label>
                    <input 
                        type="text" 
                        id="ecompany" 
                        name="rcompany" 
                        placeholder="Enter your location"
                        required 
                    />
                </div>

                <div class="input-group">
                    <label for="remail">Email Address</label>
                    <input 
                        type="email" 
                        id="remail" 
                        name="remail" 
                        placeholder="Enter your email address"
                        required 
                    />
                </div>

                <div class="input-group">
                    <label for="rpwd">Password</label>
                    <input 
                        type="password" 
                        id="rpwd" 
                        name="rpwd" 
                        placeholder="Enter your password"
                        required 
                    />
                </div>

                <div class="input-group">
                    <label for="rcontact">Contact Number</label>
                    <input 
                        type="tel" 
                        id="rcontact" 
                        name="rcontact" 
                        placeholder="Enter your contact number"
                        pattern="^[0-9]{10}$"
                        title="Please enter a valid 10-digit mobile number starting with 7, 8, or 9"
                        required 
                    />
                </div>

                <div class="button-container">
                    <input type="submit" value="Register" />
                    <input type="reset" value="Clear" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>