package com.klef.jfsd.springboot.model;

import java.sql.Blob;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "student_documents")
public class Documents 
{
	@Id
	@Column(name = "student_id")
	private long studentid;
	
	@Column(name = "student_githublink")
	private String githublink;
	
	@Column(name = "student_resume", nullable = false)	
	private Blob resume;
	
	@Column(name = "student_marksheet", nullable = false)
	private Blob marksheet;
	
	@Column(name = "student_summary", length = 200)
	private String summary;

	public long getStudentid() {
		return studentid;
	}

	public void setStudentid(long studentid) {
		this.studentid = studentid;
	}

	public String getGithublink() {
		return githublink;
	}

	public void setGithublink(String githublink) {
		this.githublink = githublink;
	}

	public Blob getResume() {
		return resume;
	}

	public void setResume(Blob resume) {
		this.resume = resume;
	}

	public Blob getMarksheet() {
		return marksheet;
	}

	public void setMarksheet(Blob marksheet) {
		this.marksheet = marksheet;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	
}
