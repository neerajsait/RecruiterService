<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>
<style nonce="${cspNonce}">
        
        .job-applicants-section {
            margin: 20px 0;
        }

        .section-header {
            color: #333;
            padding: 15px 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .section-header h4 {
            margin: 0;
            font-size: 1.5rem;
        }

        .header-controls {
            display: flex;
            flex-wrap: wrap;
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
            right: 50px;
            top: 210px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            width: 250px;
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
            font-weight: 600;
        }

        .filter-select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
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

        
        table {
            width: 100%;
            border-collapse: collapse;
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

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending { background-color: #ffc107; color: #212529; }
        .status-interview { background-color: #262dc3; color: white; }
        .status-accepted { background-color: #28a745; color: white; }
        .status-rejected { background-color: #dc3545; color: white; }
        .status-shortlisted { background-color: #dcfce7; color: #166534; }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            text-decoration: none;
        }

        .btn-profile { background-color: #0056b3; color: white; }
        .btn-profile:hover { background-color: #004494; }

        .btn-interview { background-color: #28a745; color: white; }
        .btn-interview:hover { background-color: #218838; }

        .btn-reject { background-color: #dc3545; color: white; }
        .btn-reject:hover { background-color: #c82333; }

        .custom-btn {
            background-color: #0056b3;
            color: #fff;
            font-size: 14px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 15px;
            text-decoration: none;
            display: inline-block;
        }

        .custom-btn:hover {
            background-color: #004494;
        }

        .actions {
            display: flex;
            gap: 5px;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            backdrop-filter: blur(4px);
        }
        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 25px;
            border-radius: 12px;
            width: 90%;
            max-width: 450px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            animation: modalFadeIn 0.3s ease;
        }
        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .modal-header h3 {
            margin: 0;
            color: #2c3e50;
            font-size: 1.3rem;
        }
        .close-modal {
            color: #999;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.2s;
        }
        .close-modal:hover {
            color: #333;
        }
        .modal-body label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #444;
        }
        .modal-body input[type="datetime-local"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 25px;
            font-family: inherit;
            font-size: 1rem;
            color: #333;
            transition: border-color 0.3s;
        }
        .modal-body input[type="datetime-local"]:focus {
            outline: none;
            border-color: #0d6efd;
        }
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }
        .modal-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s;
        }
        .modal-btn-cancel {
            background-color: #f1f3f5;
            color: #495057;
        }
        .modal-btn-cancel:hover {
            background-color: #e2e6ea;
        }
        .modal-btn-confirm {
            background-color: #0d6efd;
            color: white;
        }
        .modal-btn-confirm:hover {
            background-color: #0b5ed7;
        }
    </style>
    </style>
            <section class="job-applicants-section">
        <div class="section-header">
            <h4>${jobname} - Applicants</h4>
            <div class="header-controls">
                <button class="custom-btn" style="margin-bottom: 0;" onclick="window.location.href='/recruiter/getinterviewlist?id=${jobid}&name=${jobname}'" >Interview Candidates List</button>
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
                            <option value="">All</option>
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
            <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Student ID</th>
                        <th>Profile</th>
                        <th>Status</th>
                        <th>Interview</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <c:choose>
                    <c:when test="${not empty applicants}">
                        <c:forEach var="applicant" items="${applicants}">
                            <tr>
                                <td>${applicant.student.name}</td>
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
                                    <c:choose>
                                        <c:when test="${applicant.status == 'Interview' && not empty applicant.interviewDate}">
                                            <span style="font-size: 0.85rem; font-weight: bold;">${applicant.interviewDate.replace('T', ' ')}</span>
                                        </c:when>
                                        <c:when test="${applicant.status != 'Selected' && applicant.status != 'Rejected' && applicant.status != 'Interview'}">
                                            <button class="btn btn-interview" onclick="openScheduleModal('${applicant.id}')" title="Schedule Interview">
                                                <i class="fas fa-calendar-check"></i> 
                                            </button>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${applicant.status != 'Selected' && applicant.status != 'Rejected' && applicant.status != 'Interview'}">
                                        <div class="actions">
                                            <button class="btn btn-interview" title="Accept" onclick="window.location.href='/recruiter/setstatus/${applicant.id}/Shortlisted'">
                                                <i class="fas fa-check"></i>
                                            </button>
                                            <button class="btn btn-reject" title="Reject" onclick="window.location.href='/recruiter/setstatus/${applicant.id}/Rejected'">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Mock Data Row 1 -->
                        <tr>
                            <td>John Doe (Mock)</td>
                            <td>31001</td>
                            <td>
                                <button class="btn btn-profile" onclick="window.open('/recruiter/getstudentdetails?id=31001', '_blank')">
                                    <i class="fas fa-eye"></i> View Profile
                                </button>
                            </td>
                            <td><span class="status-badge status-pending">APPLIED</span></td>
                            <td>
                                <button class="btn btn-interview" onclick="openScheduleModal(null, this)" title="Schedule Interview">
                                    <i class="fas fa-calendar-check"></i> 
                                </button>
                            </td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-interview" title="Accept" onclick="mockAction(this, 'Shortlisted', 'status-shortlisted')"><i class="fas fa-check"></i></button>
                                    <button class="btn btn-reject" title="Reject" onclick="mockAction(this, 'Rejected', 'status-rejected')"><i class="fas fa-times"></i></button>
                                </div>
                            </td>
                        </tr>
                        <!-- Mock Data Row 2 -->
                        <tr>
                            <td>Jane Smith (Mock)</td>
                            <td>31002</td>
                            <td>
                                <button class="btn btn-profile" onclick="window.open('/recruiter/getstudentdetails?id=31002', '_blank')">
                                    <i class="fas fa-eye"></i> View Profile
                                </button>
                            </td>
                            <td><span class="status-badge status-interview">Interview</span></td>
                            <td><span style="font-size: 0.85rem; font-weight: bold;">2026-10-15 10:30</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-interview" title="Accept" onclick="mockAction(this, 'Shortlisted', 'status-shortlisted')"><i class="fas fa-check"></i></button>
                                    <button class="btn btn-reject" title="Reject" onclick="mockAction(this, 'Rejected', 'status-rejected')"><i class="fas fa-times"></i></button>
                                </div>
                            </td>
                        </tr>
                        <!-- Mock Data Row 3 -->
                        <tr>
                            <td>Michael Brown (Mock)</td>
                            <td>31003</td>
                            <td>
                                <button class="btn btn-profile" onclick="window.open('/recruiter/getstudentdetails?id=31003', '_blank')">
                                    <i class="fas fa-eye"></i> View Profile
                                </button>
                            </td>
                            <td><span class="status-badge status-accepted">Selected</span></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
            </div>
            
        </div>
        </div>
    </div>

    <!-- Schedule Interview Modal -->
    <div id="scheduleModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Schedule Interview</h3>
                <span class="close-modal" onclick="closeScheduleModal()">&times;</span>
            </div>
            <div class="modal-body">
                <label for="interviewDateTime">Select Date and Time:</label>
                <input type="datetime-local" id="interviewDateTime">
            </div>
            <div class="modal-footer">
                <button class="modal-btn modal-btn-cancel" onclick="closeScheduleModal()">Cancel</button>
                <button class="modal-btn modal-btn-confirm" onclick="confirmSchedule()">Confirm</button>
            </div>
        </div>
    </div>

    <script nonce="${cspNonce}">
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

    // Mock Action functionality for demo candidates
    function mockAction(button, newStatus, badgeClass, datetime = null) {
        const row = button.closest('tr');
        const badge = row.querySelector('.status-badge');
        
        // Update badge text and class
        badge.textContent = newStatus;
        badge.className = 'status-badge ' + badgeClass;

        // If moved to Interview, remove interview button and keep actions
        if (newStatus === 'Interview') {
            const interviewCell = row.querySelectorAll('td')[4];
            if (datetime) {
                interviewCell.innerHTML = '<span style="font-size: 0.85rem; font-weight: bold;">' + datetime.replace('T', ' ') + '</span>';
            } else {
                interviewCell.innerHTML = '';
            }
        } 
        // If moved to Selected/Rejected, remove all action buttons
        else if (newStatus === 'Shortlisted' || newStatus === 'Rejected' || newStatus === 'Selected') {
            const interviewCell = row.querySelectorAll('td')[4];
            const actionCell = row.querySelectorAll('td')[5];
            interviewCell.innerHTML = '';
            actionCell.innerHTML = '';
        }
    }

    // Modal functionality for Date/Time selection
    let currentApplicantId = null;
    let isMock = false;
    let currentMockRow = null;

    function openScheduleModal(applicantId, mockBtn = null) {
        currentApplicantId = applicantId;
        if (mockBtn) {
            isMock = true;
            currentMockRow = mockBtn;
        } else {
            isMock = false;
        }
        document.getElementById('interviewDateTime').value = '';
        document.getElementById('scheduleModal').style.display = 'block';
    }

    function closeScheduleModal() {
        document.getElementById('scheduleModal').style.display = 'none';
        currentApplicantId = null;
        isMock = false;
        currentMockRow = null;
    }

    function confirmSchedule() {
        const datetime = document.getElementById('interviewDateTime').value;
        if (!datetime) {
            alert('Please select a valid date and time.');
            return;
        }
        
        if (isMock) {
            mockAction(currentMockRow, 'Interview', 'status-interview', datetime);
            closeScheduleModal();
        } else {
            window.location.href = '/recruiter/setstatus/' + currentApplicantId + '/Interview?datetime=' + datetime;
        }
    }

    // Close modal if clicked outside
    window.onclick = function(event) {
        const modal = document.getElementById('scheduleModal');
        if (event.target == modal) {
            closeScheduleModal();
        }
    }
    </script>
<%@ include file="recruiter_footer.jsp" %>
