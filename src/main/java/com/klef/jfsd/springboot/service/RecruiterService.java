package com.klef.jfsd.springboot.service;

import java.util.List;

import com.klef.jfsd.springboot.model.AppliedJobs;
import com.klef.jfsd.springboot.model.Documents;
import com.klef.jfsd.springboot.model.Education;
import com.klef.jfsd.springboot.model.Jobs;
import com.klef.jfsd.springboot.model.Recruiter;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.Task;

public interface RecruiterService 
{
	public String RecruiterRegistration(Recruiter re);
	public Recruiter checkreclogin(String email, String pwd);
	public String updaterProfile(Recruiter recruiter);
	public Recruiter getrecruiterbyid(int id);
	//public String deleterecruiter(int id);
	public long jobcount();
	
	
	//Jobs
	public String addingjob(Jobs r);
	public Jobs displayjobs(int jid);
	public List<Jobs> Viewjobsbyrecruiterid(int rid);
	public Jobs getJobById(int jid);
	public String deletejob(int jid);
	public List<AppliedJobs> getapplicantsbyjobid(int jid);
	public AppliedJobs getappliedjobbyid(int id);
	public String updatejob(Jobs job);
	
	
	//Tasks 
	 Task addTask(Task task);
	 //List<Task> getTasksByRecruiterId(int recruiterId);
	 Task updateTask(Task task);
	 void deleteTask(int taskId);
	 
	 
	 //student related
	 public Student findstudentbyid(long id);
	 public Education findstudenteducationdetails(long id);
	 public Documents getdocumentsbyid(long id);
	 public String updatestudentjobstatus(String status, int sid);
	 
	 
	 //dashboard
	 public long findjobspostedbyrecruiter(int rid);
	 public long studentcount(int rid,String status);
	 public long interviewscount(int rid,String status);
	 public long jobscount(int rid,String status);
	

	

}
