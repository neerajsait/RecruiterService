<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	return;
}
else if(r.getStatus().equals("PENDING"))
{
	response.sendRedirect("rpending");
	return;
}

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Keep existing sidebar styles */
        .sidebar-container { /* ... existing sidebar styles ... */ }

        /* New Professional Styles */
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --success-color: #059669;
            --warning-color: #d97706;
            --text-primary: #1f2937;
            --text-secondary: #4b5563;
            --background-light: #f3f4f6;
        }

        body {
            margin: 0;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--background-light);
        }

        .main-content {
            padding: 2rem;
            margin-left: 290px;
        }

        header {
            background-color: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info span {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .logout-btn {
            background-color: #ef4444;
            color: white;
            border: none;
            padding: 0.5rem 1.25rem;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .logout-btn:hover {
            background-color: #dc2626;
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-icon i {
            font-size: 1.5rem;
            color: white;
        }

        .stat-info h3 {
            margin: 0;
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 500;
        }

        .stat-info p {
            margin: 0.25rem 0 0 0;
            color: var(--text-primary);
            font-size: 1.5rem;
            font-weight: 600;
        }

        .blue-bg { background-color: var(--primary-color); }
        .green-bg { background-color: var(--success-color); }
        .orange-bg { background-color: var(--warning-color); }

        .content-section {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .content-section h2 {
            color: var(--text-primary);
            font-size: 1.25rem;
            margin: 0 0 1rem 0;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .job-status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .status-item {
            padding: 1rem;
            background: var(--background-light);
            border-radius: 8px;
            text-align: center;
        }

        .status-item div {
            color: var(--text-primary);
            font-weight: 500;
        }

        .task-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .task-list li {
            padding: 0.75rem 0;
            border-bottom: 1px solid #e5e7eb;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .task-list li:last-child {
            border-bottom: none;
        }

        .task-list li::before {
            content: '•';
            color: var(--primary-color);
        }

        .add-task-link {
            display: inline-block;
            margin-bottom: 1rem;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .add-task-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }
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
            <h2>Welcome <%= r.getName() %></h2>
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

    <div class="main-content">
        <header>
            <h1>CareerStream</h1>
            <div class="user-info">
                <span><%=r.getName()%></span>
                <a href="rlogout"><button class="logout-btn">Logout</button></a>
            </div>
        </header>

        <section class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-icon blue-bg">
                    <i class="fas fa-briefcase"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Job Postings</h3>
                    <p>${jobscnt}</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green-bg">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Candidates</h3>
                    <p>${scnt}</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange-bg">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-info">
                    <h3>Interviews Scheduled</h3>
                    <p>${icnt}</p>
                </div>
            </div>
        </section>

        <section class="content-section">
            <h2>Job Status Overview</h2>
            <div class="job-status-grid">
                <div class="status-item">
                    <div>Open Jobs</div>
                    <strong>${acnt }</strong>
                </div>
                <div class="status-item">
                    <div>Closed Jobs</div>
                    <strong>${pcnt }</strong>
                </div>
                <div class="status-item">
                    <div>Deleted Job Postings</div>
                    <strong>${bcnt }</strong>
                </div>
            </div>
        </section>

        <section class="content-section">
            <h2>Task List</h2>
            <a href="rtask" class="add-task-link">
                <i class="fas fa-plus"></i> Add New Task
            </a>
            <ul class="task-list">
                <li>Post new job opening for Developer</li>
                <li>Follow up with shortlisted candidates</li>
                <li>Review applications for Manager position</li>
            </ul>
        </section>
    </div>

    <script src="${pageContext.request.contextPath}/dashboard.js"></script>
</body>
</html>