<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
Recruiter r = (Recruiter)session.getAttribute("recruiter");
if (r == null) {
    response.sendRedirect("rsessionexpiry");
    return;
}
else if(r.getStatus().equals("Blocked"))
{
	response.sendRedirect("rblocked");
}
else if(r.getStatus().equals("PENDING"))
{
	response.sendRedirect("rpending");
}

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Job Posting</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Keep original sidebar styles */
        
        /* New Professional Form Styles */
        .main-content {
            margin-left: 250px;
            padding: 2rem;
            background-color: #f5f7fa;
        }

        .add-job-posting {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            max-width: 800px;
            margin: 20px auto;
            padding: 32px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .form-full-width {
            grid-column: 1 / -1;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #374151;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px 16px;
            border: 1.5px solid #e5e7eb;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f9fafb;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #3b82f6;
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-group select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23666' viewBox='0 0 16 16'%3E%3Cpath d='M8 10.5l-4-4h8l-4 4z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 40px;
        }

        .submit-btn {
            background-color: #2563eb;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
        }

        .form-section-title {
            font-size: 1.1rem;
            color: #1f2937;
            font-weight: 600;
            margin: 24px 0 16px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e5e7eb;
            grid-column: 1 / -1;
        }

        /* Header styles */
        header {
            background: white;
            padding: 20px 32px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info span {
            font-weight: 500;
            color: #374151;
        }

        .logout-btn {
            background-color: #ef4444;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #1d4ed8;
        }
         .edit-profile-container {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        padding: 32px;
        max-width: 800px;
        margin: 20px auto;
    }

    .edit-profile-title {
        font-size: 1.5rem;
        color: #1f2937;
        font-weight: 600;
        margin-bottom: 24px;
        padding-bottom: 12px;
        border-bottom: 2px solid #e5e7eb;
    }

    .edit-profile-form {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group label {
        margin-bottom: 8px;
        color: #374151;
        font-weight: 500;
        font-size: 0.95rem;
    }

    .form-group input {
        padding: 10px 16px;
        border: 1.5px solid #e5e7eb;
        border-radius: 8px;
        font-size: 0.95rem;
        background-color: #f9fafb;
        transition: all 0.3s ease;
    }

    .form-group input:focus {
        outline: none;
        border-color: #3b82f6;
        background-color: #fff;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
    }

    .form-group input:read-only {
        background-color: #f3f4f6;
        cursor: not-allowed;
    }

    .form-full-width {
        grid-column: 1 / -1;
    }

    .submit-btn {
        background-color: #2563eb;
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-weight: 500;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        margin-top: 20px;
    }

    .submit-btn:hover {
        background-color: #1d4ed8;
        transform: translateY(-1px);
    }

    .password-hint {
        color: darkred;
        font-size: 0.8rem;
        margin-top: 8px;
    }
        /* Keep original sidebar styles unchanged */
    </style>
</head>
<body>
     <div class="sidebar-container">
    <!-- Menu Icon (Hamburger) -->
    <div class="menu-icon">
        <i class="fas fa-bars" onclick="toggleSidebar()"></i>
    </div>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header"><br><br>
            <h2>Welcome Recruiter</h2>
        </div>
        <ul>
            <li><a href="rhome"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li class="dropdown">
                <a href="#" class="dropdown-btn" onclick="toggleDropdown('jobPostings')">
                    <i class="fas fa-briefcase"></i> Manage Job Postings
                    <span class="arrow">&#9662;</span>
                </a>
                <ul class="dropdown-content" id="jobPostings-dropdown">
                    <li><a href="rview_job_postings"><i class="fas fa-eye"></i> View Job Postings</a></li>
                    
                    <li><a href="radd_job_posting"><i class="fas fa-plus"></i> Add New Posting</a></li>
                </ul>
            </li>
            <li><a href="jobapplications"><i class="fas fa-file-alt"></i> View Applications</a></li>
            <li><a href="rsettings"><i class="fas fa-cogs"></i> Profile</a></li>
        </ul>
    </div>
</div>

    <div class="main-content" id="mainContent">
        <header>
            <h1>CareerStream</h1>
            <div class="user-info">
                <span><%=r.getName() %></span>
                <a href="rlogin"><button class="logout-btn">Logout</button></a>
            </div>
        </header>
        
        <div class="edit-profile-container">
            <div class="edit-profile-title">Edit Profile</div>
            <form action="rprofileupdate" method="post" class="edit-profile-form">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="rname" value="<%=r.getName() %>" required>
                </div>
                <div class="form-group">
                    <label>Gender</label>
                    <select name="rgender" required>
                        <option value="Male" <%= r.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= r.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= r.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Date of Birth</label>
                    <input type="date" name="rdob" value="<%=r.getDateofbirth() %>" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="remail" value="<%=r.getEmail() %>" readonly>
                </div>
                <div class="form-group">
                    <label>Company</label>
                    <input type="text" name="rcompany" value="<%=r.getCompany() %>" readonly>
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <input type="text" name="rlocation" value="<%=r.getLocation() %>" required>
                </div>
                <div class="form-group">
                    <label>Contact Number</label>
                    <input type="tel" name="rcontact" value="<%=r.getContact() %>" required>
                </div>
                <div class="form-group form-full-width">
                    <label>Password</label>
                    <input type="password" name="rpwd"  pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" placeholder="Enter new password" minlength="8">
                    <div class="password-hint">Leave blank if you don't want to change your password</div>
                    
                     <div class="password-hint">Password must contain at least 8 characters, including an uppercase letter, a lowercase letter, a number, and a special character.</div>
                </div>
                <div class="form-group form-full-width">
                    <button type="submit" class="submit-btn">Update Profile</button>
                </div>
            </form>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/dashboard.js"></script>
</body>
</html>