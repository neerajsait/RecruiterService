<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>
<style nonce="<%= request.getAttribute("cspNonce") %>">
        

        .add-job-posting {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            max-width: 800px;
            margin: 20px auto;
            padding: 32px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .form-full-width {
            grid-column: 1 / -1;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #374151;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px 16px;
            border: 1.5px solid #e5e7eb;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f9fafb;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #3b82f6;
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-group select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23666' viewBox='0 0 16 16'%3E%3Cpath d='M8 10.5l-4-4h8l-4 4z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 40px;
        }

        .submit-btn {
            background-color: #2563eb;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
        }

        .form-section-title {
            font-size: 1.1rem;
            color: #1f2937;
            font-weight: 600;
            margin: 24px 0 16px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e5e7eb;
            grid-column: 1 / -1;
        }

        
</style>

        <section class="add-job-posting">
            <form action="editjobposting?id=${job.id}" method="POST">
                <input type="hidden" name="_csrf" value="<%= request.getAttribute("csrfToken") %>" />
            
            <input type="hidden" name="jobid" value="${job.id}">
    <input type="hidden" name="recruiterid" value="${job.recruiterid}">
    <input type="hidden" name="jobsid" value="${job.jobsid}">
    
    
                <div class="form-grid">
                    <div class="form-section-title">Basic Information</div>
                    
                    <div class="form-group">
                        <label for="jname">Job Title</label>
                        <input type="text" id="jname" name="jname" required 
                               placeholder="e.g., Senior Software Engineer" value="${job.name}">
                    </div>

                    <div class="form-group">
                        <label for="jcompany">Company</label>
                        <input type="text" id="jcompany" name="jcompany"  value="<%= r.getCompany() %>" readonly
                               placeholder="Your company name">
                    </div>

                    <div class="form-group">
                        <label for="jlocation">Location</label>
                        <input type="text" id="jlocation" name="jlocation" required
                               placeholder="e.g., New York, NY" value="${job.location}">
                    </div>

                    <div class="form-group">
                        <label for="jemail">Contact Email</label>
                        <input type="email" id="jemail" name="jemail" required
                               placeholder="contact@company.com" value="${job.email }">
                    </div>

                    <div class="form-section-title">Job Details</div>

                   <div class="form-group">
    <label for="jetype">Employment Type</label>
    <select id="jetype" name="jetype" required>
        <option value="">Select employment type</option>
        <option value="Full-Time" ${job.etype == 'Full-Time' ? 'selected' : ''}>Full-Time</option>
        <option value="Part-Time" ${job.etype == 'Part-Time' ? 'selected' : ''}>Part-Time</option>
        <option value="Contract" ${job.etype == 'Contract' ? 'selected' : ''}>Contract</option>
        <option value="Internship" ${job.etype == 'Internship' ? 'selected' : ''}>Internship</option>
        <option value="Temporary" ${job.etype == 'Temporary' ? 'selected' : ''}>Temporary</option>
    </select>
</div>


                   <div class="form-group">
    <label for="jtype">Work Model</label>
    <select id="jtype" name="jtype" required>
        <option value="">Select work model</option>
        <option value="On-Site" ${job.type == 'On-Site' ? 'selected' : ''}>On-Site</option>
        <option value="Remote" ${job.type == 'Remote' ? 'selected' : ''}>Remote</option>
        <option value="Hybrid" ${job.type == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
    </select>
</div>


                    <div class="form-group">
                        <label for="jexperience">Required Experience (Years)</label>
                        <input type="number" id="jexperience" name="jexperience" min="0" step="1" required
                               placeholder="e.g., 3" value="${job.experience }">
                    </div>

                    <div class="form-group">
                        <label for="jsalary">Salary Range</label>
                        <input type="text" id="jsalary" name="jsalary" required
                               placeholder="e.g., $50,000 - $70,000" value="${job.salary}">
                    </div>

                    <div class="form-group form-full-width">
                        <label for="jqualifications">Qualifications</label>
                        <textarea id="jqualifications" name="jqualifications" 
                                  placeholder="List the required qualifications and educational background" >${job.qualifications}</textarea>
                    </div>

                    <div class="form-group form-full-width">
                        <label for="jdescription">Job Description</label>
                        <textarea id="jdescription" name="jdescription" required
                                  placeholder="Provide a detailed description of the role, responsibilities, and expectations" >${job.description }</textarea>
                    </div>

                    <div class="form-group">
                        <label for="jdeadline">Application Deadline</label>
                        <input type="date" id="jdeadline" name="jdeadline" value="${job.deadline }">
                    </div>
                    
                    <div class="form-group">
                        <label for="jexperience">Maximum Acceptable Applications</label>
                        <input type="number" id="jmaxappl" name="jmaxappl"  required
                               placeholder="e.g., 100" value="${job.maxapplications}">
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-plus-circle"></i> Create Job Posting
                </button>
            </form>
        </section>
<%@ include file="recruiter_footer.jsp" %>