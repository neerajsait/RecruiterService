<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>
<style nonce="<%= request.getAttribute("cspNonce") %>">
        
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
   
        .main-content {
            padding: 2rem;
            background-color: #f8f9fa;
        }

        header {
            background-color: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        header h1 {
            color: #2c3e50;
            margin: 0;
            font-size: 1.5rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info span {
            color: #555;
            font-weight: 500;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .dashboard-cards {
                grid-template-columns: 1fr;
            }
        }
        

        .btn {
            padding: 4px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-profile {
            background-color: #0d6efd;
            color: white;
        }

        .btn-profile:hover {
            background-color: #0b5ed7;
        }

        .btn-interview {
            background-color: #28a745;
            color: white;
        }

        .btn-interview:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background-color: #c82333;
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
        .status-shortlisted {
    background-color: #dcfce7;
    color: #166534;
}

* {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            line-height: 1.6;
        }

        .job-interviews-section {
            margin: 20px 0;
        }

        .section-header {
            color: #333;
            padding: 15px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .section-header h4 {
            margin: 0;
            font-size: 1.5rem;
        }

        .header-controls {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-container {
            display: flex;
            align-items: center;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }

        .search-icon {
            padding: 8px 10px;
            color: #666;
        }

        .search-input {
            border: none;
            padding: 8px;
            width: 250px;
            font-size: 0.9rem;
            outline: none;
        }

        .search-input::placeholder {
            color: #999;
        }

        .filter-button {
            background-color: #0056b3;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .filter-button:hover {
            background-color: #004494;
        }

        .filter-dropdown {
            position: absolute;
            right: 20px;
            top: 100px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            width: 300px;
            padding: 20px;
            display: none;
            z-index: 1000;
        }

        .filter-dropdown.show {
            display: block;
        }

        .filter-group {
            margin-bottom: 15px;
        }

        .filter-label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .filter-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .apply-filter-btn {
            width: 100%;
            padding: 10px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .apply-filter-btn:hover {
            background-color: #004494;
        }

        .section-body {
            padding: 20px 0;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table thead {
            background-color: #f4f4f4;
            color: #333;
        }

        .table th,
        .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.07);
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
        .status-shortlisted {
    background-color: #dcfce7;
    color: #166534;
}

        .btn-group {
            display: flex;
            gap: 5px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background-color: #0d6efd;
            color: white;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            list-style: none;
        }

        .pagination .page-item {
            margin: 0 5px;
        }

        .pagination .page-link {
            text-decoration: none;
            color: #022356;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pagination .page-item.active .page-link {
            background-color: #022356;
            color: white;
        }

        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                gap: 10px;
            }

            .header-controls {
                width: 100%;
                justify-content: space-between;
            }

            .search-input {
                width: 100%;
            }
        }
         .btn {
            padding: 8px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-profile {
            background-color: #0d6efd;
            color: white;
        }

        .btn-profile:hover {
            background-color: #0b5ed7;
        }

        .btn-interview {
            background-color: #28a745;
            color: white;
        }

        .btn-interview:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }
        .back-button-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}

.circular-back-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 250px;
    height: 50px;
    background-color: #0112AC;
    color: white;
    text-decoration: none;
    border-radius: 25px;
    transition: background-color 0.3s ease;
}

.circular-back-link i {
    margin-right: 5px;
    font-size: 18px;
}

.circular-back-link:hover {
    background-color: #0b5ed7;
}
        		
        
    </style>
        <div class="back-button-container">
    <a href="/recruiter/getapplicants?id=${jobid}&name=${jobname}" class="circular-back-link">
        <i class="fas fa-arrow-left"></i>
        Back to Job Applicants
    </a>
	</div>
            <section class="job-interviews-section">
        <div class="section-header">
            <h4>${jobname} - Interviews List</h4>
            <div class="header-controls">
                <div class="search-container">
                    <div class="search-icon">🔍</div>
                    <input type="text" class="search-input" placeholder="Search applications...">
                </div>
                <button class="filter-button">
                    ☰ Filter
                </button>
                <div class="filter-dropdown">
                    <div class="filter-group">
                        <label for="statusFilter" class="filter-label">Status</label>
                        <select id="statusFilter" class="filter-select">
                            <option value="">All Statuses</option>
                            <option value="Interview">Interview</option>
                            <option value="Interview">Interview</option>
                            <option value="APPLIED">Applied</option>
                            <option value="Selected">Selected</option>
                            <option value="Rejected">Rejected</option>
                            
                        </select>
                    </div>
                    <button class="apply-filter-btn">Apply Filters</button>
                </div>
            </div>
        </div>
        <div class="section-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>Student</th>
                                <th>Student ID</th>
                                <th>Profile</th>
                                <th>Status</th>
                                
                                <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="applicant" items="${applicants}">
                
                <c:if test="${applicant.status == 'Interview'}">
                
                
                    <tr>
                        <td>${applicant.student.name }</td>
       					<td>${applicant.student.id}</td>
        				
        				<td>
        				<button class="btn btn-profile" onclick="window.open('/recruiter/getstudentdetails?id=${applicant.student.id}', '_blank')">
    										<i class="fas fa-eye"></i> View Profile
						</button>
						</td>
        				<td>
        				<c:choose>
        								<c:when test="${applicant.status == 'APPLIED'}">
								            <span class="status-badge status-pending">${applicant.status}</span>
								        </c:when>
								        <c:when test="${applicant.status == 'Interview'}">
								            <span class="status-badge status-interview">${applicant.status}</span>
								        </c:when>
								        <c:when test="${applicant.status == 'Shortlisted'}">
								            <span class="status-badge status-shortlisted">${applicant.status}</span>
								        </c:when>
								        <c:when test="${applicant.status == 'Selected'}">
								            <span class="status-badge status-accepted">${applicant.status}</span>
								        </c:when>
								        <c:otherwise>
								            <span class="status-badge status-rejected">${applicant.status}</span>
								        </c:otherwise>
								</c:choose>
        				</td>
        				
                        <td>
                        <c:if test="${applicant.status != 'Selected'}">
        						<div class="d-flex gap-2">
            						<button class="btn btn-interview" title="Accept" onclick="window.location.href='/recruiter/setinterviewstatus/${applicant.id}/Selected'">
               						 <i class="fas fa-check"></i>
            						</button>
            						<button class="btn btn-reject" title="Reject" onclick="window.location.href='/recruiter/setinterviewstatus/${applicant.id}/Rejected'">
                						<i class="fas fa-times"></i>
            						</button>
        						</div>
    					</c:if>
                        </td>
                        
                    </tr>
                    
                    </c:if>
                    </c:forEach>
                </tbody>
            </table>
            
        </div>
    </div>
    
    </div>
    <script nonce="<%= request.getAttribute("cspNonce") %>">
 // Dropdown functionality
    const filterButton = document.querySelector('.filter-button');
    const filterDropdown = document.querySelector('.filter-dropdown');

    filterButton.addEventListener('click', function(event) {
        // Stop propagation to prevent immediate closure
        event.stopPropagation();
        filterDropdown.classList.toggle('show');
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        if (!filterDropdown.contains(event.target) && !filterButton.contains(event.target)) {
            filterDropdown.classList.remove('show');
        }
    });

    // Prevent dropdown from closing when interacting inside it
    filterDropdown.addEventListener('click', function(event) {
        event.stopPropagation();
    });

    // Search and filter functionality
    const searchInput = document.querySelector('.search-input');
    const statusFilter = document.getElementById('statusFilter');
    const applyFiltersBtn = document.querySelector('.apply-filter-btn');
    const table = document.querySelector('.table');
    const rows = table.querySelectorAll('tbody tr');

    function applySearchAndFilter() {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value.toLowerCase();

        rows.forEach(row => {
            const rowText = row.textContent.toLowerCase();
            const statusCell = row.querySelector('.status-badge');
            
            const matchesSearch = searchTerm === '' || rowText.includes(searchTerm);
            const matchesStatus = statusValue === '' || 
                (statusCell && statusCell.textContent.toLowerCase().includes(statusValue));

            row.style.display = (matchesSearch && matchesStatus) ? '' : 'none';
        });

        // Close dropdown after applying filters
        filterDropdown.classList.remove('show');
    }

    // Add event listeners
    searchInput.addEventListener('keyup', applySearchAndFilter);
    applyFiltersBtn.addEventListener('click', applySearchAndFilter);    
    </script>
<%@ include file="recruiter_footer.jsp" %>
