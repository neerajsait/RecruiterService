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
    <title>Task List - Recruiter Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<style>
.main-content {
    margin-left: 270px;
    padding: 30px;
    width: calc(100% - 270px);
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #ccc;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

header h1 {
    font-size: 28px;
    color: #1E3264;
}

.user-info {
    display: flex;
    align-items: center;
}

.user-info span {
    font-size: 18px;
    font-weight: bold;
    color: #1E3264;
}

.logout-btn {
    background-color: #dc3545;
    color: #fff;
    border: none;
    padding: 8px 12px;
    margin-left: 15px;
    border-radius: 5px;
    cursor: pointer;
}

.logout-btn:hover {
    background-color: #c82333;
}

/* Task Section Styling */
.task-section {
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

.task-section h2 {
    color: #1E3264;
    font-size: 24px;
    margin-bottom: 15px;
}

.task-section p {
    font-size: 16px;
    color: #666;
    margin-bottom: 25px;
}

/* Task List Styling */
.task-list {
    margin-bottom: 30px;
}

.task-list h3 {
    color: #1E3264;
    font-size: 20px;
    margin-bottom: 15px;
}

.task-list ul {
    list-style-type: none;
}

.task-list li {
    display: flex;
    align-items: center;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 10px;
    background-color: #f9f9f9;
}

.task-list span {
    flex: 1;
    font-size: 16px;
}

.task-date {
    margin-left: 15px;
    padding: 5px;
    border-radius: 4px;
    border: 1px solid #ccc;
    background-color: #ffffff;
}

button {
    background-color: #1E3264;
    color: white;
    padding: 5px 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px;
}

button:hover {
    background-color: #16274f;
}

/* Add Task Section */
.add-task h3 {
    color: #1E3264;
    font-size: 20px;
    margin-bottom: 15px;
}

.add-task form {
    display: flex;
    flex-direction: column;
}

.add-task label {
    margin-bottom: 5px;
    font-weight: bold;
}

.add-task input[type="text"],
.add-task input[type="date"] {
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-bottom: 15px;
}

.add-task button {
    width: 100%;
    padding: 10px;
    font-size: 16px;
}
</style>
<body>

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
                    <li><a href="redit_job_posting"><i class="fas fa-user-edit"></i> Edit Job Posting</a></li>
                    <li><a href="radd_job_posting"><i class="fas fa-plus"></i> Add New Posting</a></li>
                </ul>
            </li>
            <li><a href="rapplications"><i class="fas fa-file-alt"></i> View Applications</a></li>
            <li><a href="rsettings"><i class="fas fa-cogs"></i> Settings</a></li>
        </ul>
    </div>
</div>

    <div class="main-content" id="mainContent">
        <header>
            <h1>Task List</h1>
            <div class="user-info">
               <span><%=r.getName() %></span>
                <a href="rlogin"><button class="logout-btn" >Logout</button></a>
            </div>
        </header>

        <section class="task-section">
            <h2>Manage Your Tasks</h2>
            <p>View, add, edit, and manage tasks with deadlines related to recruitment activities.</p>
            
            <!-- Task List -->
            <div class="task-list">
                <h3>Current Tasks</h3>
                <ul id="taskList">
                    <li>
                        <span>Post new job opening for Developer</span>
                        <input type="date" class="task-date" value="2024-11-10">
                        <button onclick="editTask(this)">Edit</button>
                        <button onclick="completeTask(this)">Mark as Complete</button>
                    </li>
                    <li>
                        <span>Follow up with shortlisted candidates</span>
                        <input type="date" class="task-date" value="2024-11-12">
                        <button onclick="editTask(this)">Edit</button>
                        <button onclick="completeTask(this)">Mark as Complete</button>
                    </li>
                    <li>
                        <span>Review applications for Manager position</span>
                        <input type="date" class="task-date" value="2024-11-15">
                        <button onclick="editTask(this)">Edit</button>
                        <button onclick="completeTask(this)">Mark as Complete</button>
                    </li>
                </ul>
            </div>

           
            <div class="add-task">
                <h3>Add New Task</h3>
                <form action="addtask" method="POST">
                    <label for="taskDescription">Task Description:</label>
                    <input type="text" id="taskDescription" name="taskDescription" placeholder="Enter task description" required>
                    <label for="taskDeadline">Deadline:</label>
                    <input type="date" id="taskDeadline" name="taskDeadline" required>
                    <button type="submit">Add Task</button>
                </form>
            </div>
        </section>
    </div>

    <script src="${pageContext.request.contextPath}/dashboard.js"></script>
</body>
</html>
