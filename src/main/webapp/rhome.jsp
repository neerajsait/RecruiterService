<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>
<style nonce="<%= request.getAttribute("cspNonce") %>">
    :root {
        --primary-color: #2563eb;
        --secondary-color: #1e40af;
        --success-color: #059669;
        --warning-color: #d97706;
        --text-primary: #1f2937;
        --text-secondary: #4b5563;
        --background-light: #f3f4f6;
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
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }
</style>

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
                <c:forEach items="${tasks}" var="task">
                    <li>
                        <span class="task-desc" style="flex: 1;"><c:out value="${task.description}" /></span>
                        <button class="complete-btn" onclick="completeTask(this)" style="background-color: #1E3264; color: white; padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px; font-size: 12px; transition: 0.3s;">Mark as Complete</button>
                    </li>
                </c:forEach>
            </ul>
        </section>
        

    <script nonce="<%= request.getAttribute("cspNonce") %>">
        document.addEventListener('DOMContentLoaded', () => {
            let completedTasks = JSON.parse(localStorage.getItem('completedTasks') || '[]');
            const taskItems = document.querySelectorAll('.task-list li');
            
            taskItems.forEach(item => {
                let taskSpan = item.querySelector('.task-desc');
                if(!taskSpan) return;
                
                let taskText = taskSpan.innerText.trim();

                if (completedTasks.includes(taskText)) {
                    item.style.textDecoration = "line-through";
                    item.style.opacity = "0.5";
                    let btn = item.querySelector('.complete-btn');
                    if (btn) {
                        btn.disabled = true;
                        btn.innerText = "Completed";
                        btn.style.backgroundColor = "#28a745";
                        btn.style.cursor = "default";
                    }
                }
            });
        });

        function completeTask(button) {
            const listItem = button.closest('li');
            const taskText = listItem.querySelector('.task-desc').innerText.trim();

            listItem.style.textDecoration = "line-through";
            listItem.style.opacity = "0.5";
            button.disabled = true;
            button.innerText = "Completed";
            button.style.backgroundColor = "#28a745";
            button.style.cursor = "default";
            
            let completedTasks = JSON.parse(localStorage.getItem('completedTasks') || '[]');
            if (!completedTasks.includes(taskText)) {
                completedTasks.push(taskText);
                localStorage.setItem('completedTasks', JSON.stringify(completedTasks));
            }
        }
    </script>
<%@ include file="recruiter_footer.jsp" %>