package com.klef.jfsd.springboot.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="Recruiter_table")
public class Recruiter 
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="rec_id")
	private int id;

	@Column(name="rec_name",nullable=false,length = 50)
	@NotBlank(message = "Full Name cannot be blank")
	@Size(max = 50, message = "Full Name must not exceed 50 characters")
	private String name;

	@Column(name="rec_gender",nullable=false,length = 20)
	@NotBlank(message = "Gender cannot be blank")
	@Size(max = 20, message = "Gender must not exceed 20 characters")
	private String gender;

	@Column(name="rec_dob",nullable=false,length = 20)
	@NotBlank(message = "Date of Birth cannot be blank")
	@Size(max = 20, message = "Date of Birth must not exceed 20 characters")
	private String dateofbirth;

	@Column(name="rec_company",nullable=false,length = 20)
	@NotBlank(message = "Company cannot be blank")
	@Size(max = 20, message = "Company must not exceed 20 characters")
	private String company;

	@Column(name="rec_email",nullable=false,unique = true,length = 50)
	@NotBlank(message = "Email Address cannot be blank")
	@Email(message = "Please enter a valid email address")
	@Size(max = 50, message = "Email must not exceed 50 characters")
	private String email;

	@Column(name="rec_password",nullable=false,length = 100)
	@Size(max = 100, message = "Password must not exceed 100 characters")
	private String password;

	@Column(name="rec_location",nullable=false,length=50)
	@NotBlank(message = "Location cannot be blank")
	@Size(max = 50, message = "Location must not exceed 50 characters")
	private String location;

	@Column(name="rec_contact",nullable=false,unique = true)
	@NotBlank(message = "Contact Number cannot be blank")
	@Pattern(regexp = "^[0-9]{10}$", message = "Contact Number must be a valid 10-digit mobile number")
	private String contact;

	@Column(name="rec_status",nullable=false,length = 50)
	private String status;
	
	

	
	
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDateofbirth() {
		return dateofbirth;
	}
	public void setDateofbirth(String dateofbirth) {
		this.dateofbirth = dateofbirth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	

}
