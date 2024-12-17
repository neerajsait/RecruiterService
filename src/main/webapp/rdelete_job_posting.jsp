<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Job Post</title>
    <style>
        table {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            border-collapse: collapse;
            table-layout: auto;
            background-color: #fff;
        }

        table, th, td {
            border: 2px solid black;
        }

        th, td {
            padding: 10px;
            text-align: center;
            word-wrap: break-word;
        }

        th {
            background-color: black;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:nth-child(odd) {
            background-color: #fff;
        }
    </style>
</head>
<body>
    
    <h3 style="text-align: center;"><u>Delete Job Post</u></h3>
    <table>
        <tr>
            <th>Job ID</th>
            <th>Name</th>
            <th>Company</th>
            <th>Location</th>
            <th>Employment Type</th>
            <th>Job Type</th>
            <th>Experience</th>
            <th>Salary</th>
            <th>Qualifications</th>
            <th>Description</th>
            <th>Deadline</th>
            <th>Email</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <c:forEach items="${joblist}" var="job">
            <tr>
                <td><c:out value="${job.jobid}"/></td>
                <td><c:out value="${job.name}"/></td>
                <td><c:out value="${job.company}"/></td>
                <td><c:out value="${job.location}"/></td>
                <td><c:out value="${job.etype}"/></td>
                <td><c:out value="${job.type}"/></td>
                <td><c:out value="${job.experience}"/></td>
                <td><c:out value="${job.salary}"/></td>
                <td><c:out value="${job.qualifications}"/></td>
                <td><c:out value="${job.description}"/></td>
                <td><c:out value="${job.deadline}"/></td>
                <td><c:out value="${job.email}"/></td>
                <td><c:out value="${job.status}"/></td>
               <td>
    <a href="<c:url value='/rdelete_job_posting/${job.jobid}'/>">Delete</a>
</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
