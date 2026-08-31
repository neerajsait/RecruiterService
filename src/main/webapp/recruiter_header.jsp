<%@ page import="com.klef.jfsd.springboot.model.Recruiter" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%
Recruiter recruiterLayout = (Recruiter)session.getAttribute("recruiter");
if (recruiterLayout == null) {
    response.sendRedirect("rsessionexpiry");
    return;
}
else if(recruiterLayout.getStatus().equals("Blocked"))
{
	response.sendRedirect("rblocked");
    return;
}
else if(recruiterLayout.getStatus().equals("PENDING"))
{
	response.sendRedirect("rpending");
    return;
}
Recruiter r = recruiterLayout;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script nonce="<%= request.getAttribute("cspNonce") %>">
        window.addEventListener('pageshow', function (event) {
            if (event.persisted) {
                window.location.reload();
            }
        });
    </script>
</head>
<body>
    <div class="dashboard-layout">
        
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
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
                <li><a href="rtask"><i class="fas fa-tasks"></i> Tasks</a></li>
            </ul>
        </div>
        
        
        <div class="main-content-wrapper" id="mainContent">
            
            <header class="top-navbar">
                <div class="logo-section">
                    <div class="menu-icon">
                        <i class="fas fa-bars" onclick="toggleSidebar()"></i>
                    </div>
                    <h1>CareerStream</h1>
                </div>
                <div class="user-info">
                    <span><%= recruiterLayout.getName() %></span>
                    <a href="rlogout"><button class="logout-btn">Logout</button></a>
                </div>
            </header>

            
            <div class="page-content">
