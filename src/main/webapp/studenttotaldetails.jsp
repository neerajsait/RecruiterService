<!DOCTYPE html>
<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${student.id}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.1/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
/* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'poppins', sans-serif;
}
        :root {
            --primary-color: #6a11cb;
            --secondary-color: #2ecc71;
            --background-light: #f0f4f8;
        }

        body {
            background-color: var(--background-light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 30px;
        }

        .section-header {
            color: var(--primary-color);
            border-bottom: 3px solid var(--primary-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .section-header i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .info-card {
            background-color: #f8f9fa;
            border-left: 4px solid var(--primary-color);
            padding: 15px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        .info-card:hover {
            transform: translateX(10px);
        }

        .student-details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .student-details-grid .detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .student-details-grid .detail-item i {
            margin-right: 10px;
            color: var(--primary-color);
            width: 20px;
            text-align: center;
        }

        .document-link {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #e9ecef;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            transition: background-color 0.3s ease;
        }

        .document-link:hover {
            background-color: #dee2e6;
        }

        .document-link .badge {
            margin-left: 10px;
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 15px;
            }
            .student-details-grid {
                grid-template-columns: 1fr;
            }
        }

        .professional-summary {
            text-align: justify;
            line-height: 1.4;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-container">
            <!-- Student Details Section -->
            <div class="row mb-4">
                <div class="col-12">
                    <h2 class="section-header">
                        <i class="fas fa-user-graduate"></i>
                        Student Details
                    </h2>
                </div>
                <div class="col-12">
                    <div class="info-card">
                        <div class="student-details-grid">
                            <div class="detail-item">
                                <i class="fas fa-id-card"></i>
                                <strong>Student ID: &nbsp; </strong> ${student.id}
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-signature"></i>
                                <strong>Name:&nbsp;  </strong> ${student.name }
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-birthday-cake"></i>
                                <strong>Date of Birth: &nbsp; </strong> ${student.dob}
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-venus-mars"></i>
                                <strong>Gender: &nbsp; </strong> ${student.gender}
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-envelope"></i>
                                <strong>Email: &nbsp;  </strong> ${student.email}
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-phone"></i>
                                <strong>Contact:&nbsp;  </strong> ${student.contact}
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <strong>Address:&nbsp;  </strong> ${student.address}
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course Details Section -->
            <div class="row mb-4">
                <div class="col-12">
                    <h2 class="section-header">
                        <i class="fas fa-graduation-cap"></i>
                        Course Details
                    </h2>
                </div>
                <div class="col-md-6">
                    <div class="info-card">
                        <strong>Program:&nbsp;</strong> ${edu.degree}
                        <br>
                        <strong>Major: &nbsp; </strong> ${edu.major}
                        <br>
                        <strong>Specialization: &nbsp; </strong> ${edu.specialization}
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-card">
                        <strong>C.G.P.A:&nbsp;</strong> ${edu.cgpa}
                        <br>
                        <strong>Expected Graduation: &nbsp; </strong> ${edu.enddate}
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-12">
                    <h2 class="section-header">
                        <i class="fas fa-book"></i>
                        Professional Summary
                    </h2>
                </div>
                <div class="col-12">
                    <div class="info-card">
                        <p class="professional-summary">
                           ${doc.summary}
                        </p>
                    </div>
                </div>
            </div>

            <!-- Documents Section -->
            <div class="row">
                <div class="col-12">
                    <h2 class="section-header">
                        <i class="fas fa-file-alt"></i>
                        Relevant Documents
                    </h2>
                </div>
                <div class="col-12">
                    <div class="document-link">
                        <span>
                            <i class="fab fa-github"></i>
                           &nbsp;&nbsp;  GitHub Link
                        </span>
                        <a href="${doc.githublink}" target="_blank" class="btn btn-sm btn-outline-primary">
                            Click Here
                            <i class="fas fa-external-link-alt ms-2"></i>
                        </a>
                    </div>
                    <div class="document-link">
                        <span>
                            <i class="far fa-file-pdf text-danger me-2"></i>
                            Resume
                        </span>
                        <a href="getResume/${student.id}" target="_blank" class="btn btn-sm btn-outline-primary">
                            View Document
                            <i class="fas fa-external-link-alt ms-2"></i>
                        </a>
                    </div>
                    <div class="document-link">
                        <span>
                            <i class="far fa-file-pdf text-danger me-2"></i>
                            Academic Marksheet
                        </span>
                        <a href="getMarksheets/${student.id}" target="_blank" class="btn btn-sm btn-outline-primary">
                            View Document
                            <i class="fas fa-external-link-alt ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.1/js/bootstrap.bundle.min.js"></script>
</body>
</html>