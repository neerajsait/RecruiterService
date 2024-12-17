package com.klef.jfsd.springboot.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "student_table")
public class Student 
{
	@Id
	@Column(name = "student_id")
	private long id;
	
	@Column(name = "student_name", nullable = false, length = 30)
	private String name;
	
	@Column(name = "student_dob", nullable = false, length = 15)
	private String dob;
	
	@Column(name = "student_gender", nullable = false, length = 10)
	private String gender;
	
	@Column(name = "student_password", nullable = false, length = 15)
	private String password;
	
	@Column(name = "student_address", nullable = false, length = 50)
	private String address;
	
	@Column(name = "student_email", nullable = false, length = 30 )
	private String email;
	
	@Column(name = "student_contact", nullable = false, length = 10)
	private String contact;
	
	

	
	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", dob=" + dob + ", gender=" + gender + ", password=" + password
				+ ", address=" + address + ", email=" + email + ", contact=" + contact + "]";
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}
	
}
