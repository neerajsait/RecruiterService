package com.klef.jfsd.springboot.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "education_details")
public class Education 
{
		@Id
		@Column(name = "student_id", nullable = false)
		private long studentid;
		
		@Column(name = "student_degree")
		private String degree;
		
		@Column(name = "student_major")
		private String major;
		
		@Column(name = "student_specialization")
		private String specialization;
		
		@Column(name = "student_cgpa")
		private double cgpa;
		
		@Column(name = "degree_startdate")
		private String startdate;
		
		@Column(name = "degree_enddate")
		private String enddate;

		@Override
		public String toString() {
			return "Education [studentid=" + studentid + ", degree=" + degree + ", major=" + major + ", specialization="
					+ specialization + ", cgpa=" + cgpa + ", startdate=" + startdate + ", enddate=" + enddate + "]";
		}

		public long getStudentid() {
			return studentid;
		}

		public void setStudentid(long studentid) {
			this.studentid = studentid;
		}

		public String getDegree() {
			return degree;
		}

		public void setDegree(String degree) {
			this.degree = degree;
		}

		public String getMajor() {
			return major;
		}

		public void setMajor(String major) {
			this.major = major;
		}

		public String getSpecialization() {
			return specialization;
		}

		public void setSpecialization(String specialization) {
			this.specialization = specialization;
		}

		public double getCgpa() {
			return cgpa;
		}

		public void setCgpa(double cgpa) {
			this.cgpa = cgpa;
		}

		public String getStartdate() {
			return startdate;
		}

		public void setStartdate(String startdate) {
			this.startdate = startdate;
		}

		public String getEnddate() {
			return enddate;
		}

		public void setEnddate(String enddate) {
			this.enddate = enddate;
		}
}
