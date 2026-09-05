<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>
<style nonce="<%= request.getAttribute("cspNonce") %>">
    .edit-profile-container {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        padding: 24px;
        max-width: 900px;
        margin: 10px auto;
    }

    .edit-profile-title {
        font-size: 1.5rem;
        color: #1f2937;
        font-weight: 600;
        margin-bottom: 16px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e5e7eb;
    }

    .edit-profile-form {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .form-columns {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }

    .form-col {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group label {
        margin-bottom: 4px;
        color: #374151;
        font-weight: 500;
        font-size: 0.9rem;
    }

    .form-group input, .form-group select {
        padding: 8px 12px;
        border: 1.5px solid #e5e7eb;
        border-radius: 8px;
        font-size: 0.95rem;
        background-color: #f9fafb;
        transition: all 0.3s ease;
    }

    .form-group input:focus, .form-group select:focus {
        outline: none;
        border-color: #3b82f6;
        background-color: #fff;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
    }

    .form-group input:read-only {
        background-color: #f3f4f6;
        cursor: not-allowed;
    }

    .submit-btn {
        background-color: #2563eb;
        color: white;
        padding: 10px 24px;
        border: none;
        border-radius: 8px;
        font-weight: 500;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        margin-top: 10px;
    }

    .submit-btn:hover {
        background-color: #1d4ed8;
    }

    .password-hint {
        color: #666;
        font-size: 0.8rem;
        margin-top: 4px;
    }
    </style>
        
        <div class="edit-profile-container">
            <div class="edit-profile-title">Edit Profile</div>
            <form action="rprofileupdate" method="post" class="edit-profile-form">
                <input type="hidden" name="_csrf" value="<%= request.getAttribute("csrfToken") %>" />
                <div class="form-columns">
                    
                    <div class="form-col">
                        <div class="form-group">
                            <label>Name</label>
                            <input type="text" name="rname" value="<%=r.getName() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="rgender" required>
                                <option value="Male" <%= r.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= r.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= r.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="rdob" value="<%=r.getDateofbirth() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Contact Number</label>
                            <input type="tel" name="rcontact" value="<%=r.getContact() %>" required>
                        </div>
                    </div>
                    
                    
                    <div class="form-col">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="remail" value="<%=r.getEmail() %>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Company</label>
                            <input type="text" name="rcompany" value="<%=r.getCompany() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Location</label>
                            <input type="text" name="rlocation" value="<%=r.getLocation() %>" required>
                        </div>
                    </div>
                </div>

                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="rpwd" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" placeholder="Enter new password (optional)" minlength="8">
                    <div class="password-hint">Leave blank to keep current password. Must contain 8+ chars, uppercase, lowercase, number, and special character.</div>
                </div>
                
                <button type="submit" class="submit-btn">Update Profile</button>
            </form>
        </div>
<%@ include file="recruiter_footer.jsp" %>