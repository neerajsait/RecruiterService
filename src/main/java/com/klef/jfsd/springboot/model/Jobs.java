package com.klef.jfsd.springboot.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Jobs_table")
public class Jobs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "jid")
    private int id;
    
    @Column(name = "jobs_id")
    private String jobsid;

    @Column(name = "rec_id")
    private int recruiterid;

    @Column(name = "jname", nullable = false, length = 50)
    private String name;

    @Column(name = "jcompany", nullable = false, length = 50)
    private String company;

    @Column(name = "location", nullable = false, length = 50)
    private String location;

    @Column(name = "jetype", nullable = false, length = 50)
    private String etype;

    @Column(name = "jtype", nullable = false, length = 50)
    private String type;

    @Column(name = "jexperience", nullable = false)
    private String experience;

    @Column(name = "jsalary", nullable = false, length = 50)
    private String salary;

    @Column(name = "jqualifications", nullable = false, length = 150)
    private String qualifications;

    @Column(name = "jdescription", nullable = false, length = 150)
    private String description;

    @Column(name = "jdeadline", nullable = false, length = 20)
    private String deadline;

    @Column(name = "jemail", nullable = false, length = 50)
    private String email;
    
    @Column(name = "max_applications", nullable = false)
    private int maxapplications;
    
    @Column(name = "recieved_applications", nullable = false)
    private int applicationsrecieved;
    
    @Column(name = "job_status")
    private String status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getMaxapplications() {
		return maxapplications;
	}

	public void setMaxapplications(int maxapplications) {
		this.maxapplications = maxapplications;
	}

	public int getApplicationsrecieved() {
		return applicationsrecieved;
	}

	public void setApplicationsrecieved(int applicationsrecieved) {
		this.applicationsrecieved = applicationsrecieved;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getJobsid() {
		return jobsid;
	}

	public void setJobsid(String jobsid) {
		this.jobsid = jobsid;
	}

	public int getRecruiterid() {
		return recruiterid;
	}

	public void setRecruiterid(int recruiterid) {
		this.recruiterid = recruiterid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getEtype() {
		return etype;
	}

	public void setEtype(String etype) {
		this.etype = etype;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getQualifications() {
		return qualifications;
	}

	public void setQualifications(String qualifications) {
		this.qualifications = qualifications;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

  


	
	
}
