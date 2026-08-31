<%@page import="com.klef.jfsd.springboot.model.Recruiter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="recruiter_header.jsp" %>

        
        <div class="profile-container">
            <div class="profile-header">
                <div class="profile-avatar">
                    <%= r.getName().charAt(0) %>
                </div>
                <div class="profile-header-info">
                    <h1><%=r.getName() %></h1>
                    <p><%=r.getCompany() %> | Recruiter</p>
                </div>
            </div>

            <div class="profile-grid">
                <div class="profile-field">
                    <label>Email</label>
                    <div class="value"><%=r.getEmail() %></div>
                </div>
                <div class="profile-field">
                    <label>Contact Number</label>
                    <div class="value"><%=r.getContact() %></div>
                </div>
                <div class="profile-field">
                    <label>Gender</label>
                    <div class="value"><%=r.getGender() %></div>
                </div>
                <div class="profile-field">
                    <label>Date of Birth</label>
                    <div class="value"><%=r.getDateofbirth() %></div>
                </div>
                <div class="profile-field">
                    <label>Location</label>
                    <div class="value"><%=r.getLocation() %></div>
                </div>
                <div class="profile-field">
                    <label>Company</label>
                    <div class="value"><%=r.getCompany() %></div>
                </div>
            </div>

            <button class="edit-profile-btn" onclick="window.location.href='/recruiter/rupdateprofile'">Edit Profile</button>
        </div>

        
<%@ include file="recruiter_footer.jsp" %>