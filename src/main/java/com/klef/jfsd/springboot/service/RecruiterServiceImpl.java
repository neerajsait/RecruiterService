package com.klef.jfsd.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.AppliedJobs;
import com.klef.jfsd.springboot.model.Documents;
import com.klef.jfsd.springboot.model.Education;
import com.klef.jfsd.springboot.model.Jobs;
import com.klef.jfsd.springboot.model.Recruiter;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.Task;
import com.klef.jfsd.springboot.repository.AppliedJobsRepository;
import com.klef.jfsd.springboot.repository.DocumentsRepository;
import com.klef.jfsd.springboot.repository.EducationRepository;
import com.klef.jfsd.springboot.repository.JobsRepository;
import com.klef.jfsd.springboot.repository.RecruiterRepository;
import com.klef.jfsd.springboot.repository.StudentRepository;
import com.klef.jfsd.springboot.repository.TasksRepository;

@Service
public class RecruiterServiceImpl implements RecruiterService 
{
	@Autowired
	private RecruiterRepository recruiterRepository;
	
	@Autowired
	private JobsRepository jobsRepository;
	
	@Autowired
	private TasksRepository taskRepository;
	
	@Autowired
	private AppliedJobsRepository appliedJobsRepository;
	
	@Autowired
	private StudentRepository studentRepository;
	
	@Autowired
	private EducationRepository educationRepository;
	
	@Autowired
	private DocumentsRepository documentsRepository;

	@Override
	public String RecruiterRegistration(Recruiter re) {
		 
	            recruiterRepository.save(re);
	            return "Congratulations! Your Account Has Been Created 😀";
	        
		
	}

	@Override
	public Recruiter checkreclogin(String email, String pwd) {
		return recruiterRepository.checkreclogin(email, pwd);

	}

	@Override
	public String updaterProfile(Recruiter recruiter) {
	    Recruiter r = recruiterRepository.findById(recruiter.getId()).orElseThrow(() -> 
	        new RuntimeException("Recruiter not found with ID: " + recruiter.getId()));
	    
	    
	    r.setName(recruiter.getName());
	    r.setContact(recruiter.getContact());
	    r.setDateofbirth(recruiter.getDateofbirth());
	    r.setGender(recruiter.getGender());
	    r.setLocation(recruiter.getLocation());
	    r.setCompany(recruiter.getCompany());
	    
	   
	    if (recruiter.getPassword() != null && !recruiter.getPassword().trim().isEmpty()) {
	        r.setPassword(recruiter.getPassword());
	    }
	    
	    recruiterRepository.save(r);
	    return "Profile Updated Successfully";
	}

	
	

	
	//jobs
	@Override
	public String addingjob(Jobs r) {
		jobsRepository.save(r);
		return "Job added successfully....!";
	}

	@Override
	public Jobs displayjobs(int jid) {
		
		return jobsRepository.findById(jid).get();
	}

	@Override
	public long jobcount() {
		
		return jobsRepository.count();
	}

	@Override
	public List<Jobs> Viewjobsbyrecruiterid( int rid) {
		System.out.println("Service Request recieved");
		return jobsRepository.findjobsbyrecruiterid(rid);
	}
	@Override
	public Jobs getJobById(int jid) {
		
		return jobsRepository.findjobbyid(jid);
	}
	@Override
	public String deletejob(int jid) {
		 Jobs j = jobsRepository.findById(jid).get();
		 j.setStatus("Blocked");
		 jobsRepository.save(j);
		 return "Jobs deleted successfully";
	}

	 

	
	//tasks
	@Override
	public Task addTask(Task task) {
		 return taskRepository.save(task);
	}

	
//	public List<Task> getTasksByRecruiterId(int recruiterId) {
//		 //return taskRepository.findByRecruiterId(recruiterId);
//	}

	@Override
	public Task updateTask(Task task) {
		return taskRepository.save(task);
	}

	@Override
	public void deleteTask(int taskId) {
		taskRepository.deleteById(taskId);
	}

	@Override
	public Recruiter getrecruiterbyid(int id) 
	{
		Recruiter r = recruiterRepository.findById(id).get();
		return r;
	}

	@Override
	public List<AppliedJobs> getapplicantsbyjobid(int jid) 
	{
		return appliedJobsRepository.getapplicantsbyjobid(jid);
	}
	
	@Override
	public Education findstudenteducationdetails(long id) 
	{
		
		return educationRepository.findEducationByStudentid(id);
	}
	
	@Override
	public Student findstudentbyid(long id) 
	{
		return studentRepository.findById(id).get();
	}
	
	@Override
	public Documents getdocumentsbyid(long id) 
	{
		return documentsRepository.finddocumentbystudentid(id);
	}

	@Override
	public String updatestudentjobstatus(String status, int id) 
	{
		appliedJobsRepository.updatestudentapplicationstatus(status, id);
		return "Application Status updated Successfully";
	}

	@Override
	public AppliedJobs getappliedjobbyid(int id) 
	{
		return appliedJobsRepository.findById(id).get();
	}

	@Override
	public String updatejob(Jobs job) 
	{
		System.out.println("Updating job with ID: " + job.getId());
		Jobs existingJob = jobsRepository.findById(job.getId()).get();
		
		if (existingJob != null) {
            // Update fields (set new values)
            existingJob.setName(job.getName());
            existingJob.setCompany(job.getCompany());
            existingJob.setLocation(job.getLocation());
            existingJob.setEtype(job.getEtype());
            existingJob.setType(job.getType());
            existingJob.setExperience(job.getExperience());
            existingJob.setSalary(job.getSalary());
            existingJob.setQualifications(job.getQualifications());
            existingJob.setDescription(job.getDescription());
            existingJob.setDeadline(job.getDeadline());
            existingJob.setEmail(job.getEmail());
            
            if(existingJob.getMaxapplications()<job.getMaxapplications())
            {
            	existingJob.setStatus("Active");
            }
            existingJob.setMaxapplications(job.getMaxapplications());
            jobsRepository.save(existingJob);
            return "Job Details updated successfully.";
        } else {
            return "Job not found.";
        }
    }

	@Override
	public long findjobspostedbyrecruiter(int rid) 
	{
		// TODO Auto-generated method stub
		return jobsRepository.findjobspostedbyrecruiter(rid);
	}

	@Override
	public long studentcount(int rid, String status)
	{
		return appliedJobsRepository.studentcount(rid, status);
	}

	@Override
	public long interviewscount(int rid, String status) 
	{
		return appliedJobsRepository.interviewscount(rid, status);
	}

	@Override
	public long jobscount(int rid, String status) 
	{
		return jobsRepository.jobscount(rid, status);
	} 
}

			


	
	
	


