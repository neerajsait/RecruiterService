<%@ page import="com.klef.jfsd.springboot.model.Recruiter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>View Job Postings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Styling for the job postings table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 1rem;
            text-align: left;
        }

        table thead {
            background-color: #f4f4f4;
            color: #333;
        }

        table thead th {
            padding: 15px;
            font-weight: 600;
            text-transform: uppercase;
            border-bottom: 2px solid #ddd;
        }

        table tbody tr {
            border-bottom: 1px solid #ddd;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }

        table tbody td {
            padding: 12px 15px;
        }

        .actions a {
            margin-right: 10px;
            text-decoration: none;
            color: #0056b3;
            font-weight: 500;
        }

        .actions a:hover {
            color: #00376b;
        }

        .user-info {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
        }

        .logout-btn {
            padding: 8px 12px;
            background-color: #0056b3;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .logout-btn:hover {
            background-color: #004494;
        }

        .job-postings h2 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 10px;
        }

        /* Modal Styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            float: right;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #ffffff;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    border-radius: 10px;
}
 .no-jobs-section {
            text-align: center;
            padding: 50px 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            margin: 20px 0;
        }

        .no-jobs-icon {
            font-size: 5rem;
            color: #6c757d;
            margin-bottom: 20px;
        }

        .no-jobs-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
        }

        .no-jobs-description {
            color: #6c757d;
            margin-bottom: 20px;
        }

        .add-job-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #0056b3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .add-job-btn:hover {
            background-color: #004494;
        }
.applicants-link {
            color: #0056b3;
            cursor: pointer;
        }
        .applicants-link:hover {
            color: #00376b;
        }
        .filter-container {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
}

.filter-input {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 0.9rem;
}

.filter-button, .reset-button {
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9rem;
    transition: background-color 0.3s ease;
}

.filter-button {
    background-color: #0056b3;
    color: white;
}

.reset-button {
    background-color: #6c757d;
    color: white;
}

.filter-button:hover {
    background-color: #004494;
}

.reset-button:hover {
    background-color: #545b62;
}
.status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #ffc107;
            color: #212529;
        }
        
        .status-interview {
            background-color: #262dc3;
            color: white;
        }

        .status-accepted {
            background-color: #28a745;
            color: white;
        }

        .status-rejected {
            background-color: #dc3545;
            color: white;
        }
        
    </style>
</head>
<body>
    <div class="sidebar-container">
        <div class="menu-icon">
            <i class="fas fa-bars" onclick="toggleSidebar()"></i>
        </div>
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
                <li><a href="rreports"><i class="fas fa-chart-line"></i> Reports</a></li>
                <li><a href="rsettings"><i class="fas fa-cogs"></i> Profile</a></li>
            </ul>
        </div>
    </div>

    <div class="main-content" id="mainContent">
        <header>
            <h1>CareerStream</h1>
            <div class="user-info">
                <span><%= r.getName() %></span>
                <a href="rlogout"><button class="logout-btn">Logout</button></a>
            </div>
        </header>

        <c:choose>
            <c:when test="${empty joblist}">
                <section class="no-jobs-section">
                    <div class="no-jobs-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h2 class="no-jobs-title">No Job Postings Found</h2>
                    <p class="no-jobs-description">
                        You haven't created any job postings yet. Start by adding a new job listing.
                    </p>
                    <a href="radd_job_posting" class="add-job-btn">
                        <i class="fas fa-plus"></i> Add New Job Posting
                    </a>
                </section>
            </c:when>
            <c:otherwise>
                <section class="job-postings">
                    <h2>Job Postings</h2>
                    <div class="filter-container">
    <label for="statusFilter">Filter by Status: </label>
    <select id="statusFilter" class="filter-input">
        <option value="all">All Statuses</option>
        <option value="Active">Active</option>
        <option value="Inactive">Inactive</option>
        
    </select>
    <button id="applyFilter" class="filter-button">Apply Filter</button>
    <button id="resetFilter" class="reset-button">Reset</button>
</div>
                    <table>
                        <thead>
                            <tr>
                                <th>Job ID</th>
                                <th>Job Title</th>
                                <th>Company</th>
                                <th>Location</th>
                                <th>Applicants</th>
                                <th>Status</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${joblist}" var="job">
                            <c:if test="${job.status != 'Blocked'}">
                                <tr>
                                    <td><c:out value="${job.jobsid}" /></td>
                                    <td><c:out value="${job.name}" /></td>
                                    <td><c:out value="${job.company}" /></td>
                                    <td><c:out value="${job.location}" /></td>
                                    
                                    <td class="applicants">
                                    		<c:if test="${job.status != 'Blocked' }">
                                        <a href="/recruiter/getapplicants?id=${job.id}&name=${job.name}" 
                                           class="applicants-link" 
                                           title="View Applicants" >
                                            <i class="fas fa-eye"></i> 
                                            
                                        </a>
                                        </c:if>
                                        
                                    </td>
                                    <td>
								<c:choose>
        								<c:when test="${job.status =='Active'}">
								            <span class="status-badge status-accepted">${job.status}</span>
								        </c:when>

								        <c:when test="${job.status == 'Inactive'}">
								            <span class="status-badge status-pending">${job.status}</span>
								        </c:when>
								        <c:otherwise>
								            <span class="status-badge status-rejected">${job.status}</span>
								        </c:otherwise>
								</c:choose>
								</td>
                                    
                                </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </section>
            </c:otherwise>
        </c:choose>
    </div>

    
    <script src="dashboard.js">
    </script>
    
    <script type="text/javascript">
    
    document.addEventListener('DOMContentLoaded', function() {
        const statusFilter = document.getElementById('statusFilter');
        const filterButton = document.getElementById('applyFilter');
        const jobTable = document.querySelector('table tbody');
        const rows = jobTable.querySelectorAll('tr');

        function applyFilter() {
            const filterValue = statusFilter.value.toLowerCase();

            rows.forEach(row => {
                const statusCell = row.querySelector('td:last-child .status-badge');
                const status = statusCell.textContent.toLowerCase();

                // Normalize filter values to match exact status text
                const normalizedFilterValue = filterValue === 'active' ? 'active' :
                                              filterValue === 'inactive' ? 'inactive' :
                                              filterValue === 'blocked' ? 'blocked' : 
                                              'all';

                if (normalizedFilterValue === 'all' || status === normalizedFilterValue) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Add event listener to filter button
        filterButton.addEventListener('click', applyFilter);

        // Optional: Reset filter functionality
        const resetButton = document.getElementById('resetFilter');
        if (resetButton) {
            resetButton.addEventListener('click', function() {
                statusFilter.value = 'all';
                rows.forEach(row => {
                    row.style.display = '';
                });
            });
        }
    });
    </script>
<script src="${pageContext.request.contextPath}/dashboard.js"></script>
</body>
</html>
