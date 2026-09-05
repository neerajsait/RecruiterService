<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>
<style nonce="<%= request.getAttribute("cspNonce") %>">
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
    padding-left: 0;
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

.task-section button {
    background-color: #1E3264;
    color: white;
    padding: 5px 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px;
}

.task-section button:hover {
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

        <section class="task-section">
            <h2>Manage Your Tasks</h2>
            <p>View, add, edit, and manage tasks with deadlines related to recruitment activities.</p>
            
            <!-- Task List -->
            <div class="task-list">
                <h3>Current Tasks</h3>
                <ul id="taskList">
                    <c:forEach items="${tasks}" var="task">
                        <li data-task-id="${task.id}">
                            <span class="task-desc" style="flex: 1;"><c:out value="${task.description}" /></span>
                            <input type="date" class="task-date" value="${task.deadline}" readonly>
                            <button class="complete-btn" onclick="completeTask(this)">Mark as Complete</button>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div class="add-task">
                <h3>Add New Task</h3>
                <form action="addtask" method="POST">
                    <input type="hidden" name="_csrf" value="${csrfToken}" />
                    <label for="taskDescription">Task Description:</label>
                    <input type="text" id="taskDescription" name="taskDescription" placeholder="Enter task description" required>
                    <label for="taskDeadline">Deadline:</label>
                    <input type="date" id="taskDeadline" name="taskDeadline" required>
                    <button type="submit">Add Task</button>
                </form>
            </div>
        </section>
    <script nonce="<%= request.getAttribute("cspNonce") %>">
        document.addEventListener('DOMContentLoaded', () => {
            let completedTasks = JSON.parse(localStorage.getItem('completedTasks') || '[]');
            const taskItems = document.querySelectorAll('.task-list li');
            
            taskItems.forEach(item => {
                let taskId = item.getAttribute('data-task-id');
                if(!taskId) return;

                if (completedTasks.includes(taskId)) {
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
            const taskId = listItem.getAttribute('data-task-id');
            if(!taskId) return;

            listItem.style.textDecoration = "line-through";
            listItem.style.opacity = "0.5";
            button.disabled = true;
            button.innerText = "Completed";
            button.style.backgroundColor = "#28a745";
            button.style.cursor = "default";
            
            let completedTasks = JSON.parse(localStorage.getItem('completedTasks') || '[]');
            if (!completedTasks.includes(taskId)) {
                completedTasks.push(taskId);
                localStorage.setItem('completedTasks', JSON.stringify(completedTasks));
            }
        }
    </script>
<%@ include file="recruiter_footer.jsp" %>
