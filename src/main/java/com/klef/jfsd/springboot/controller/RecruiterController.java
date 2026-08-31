package com.klef.jfsd.springboot.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Random;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.batch.BatchProperties.Job;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klef.jfsd.springboot.model.Recruiter;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.Task;
import com.klef.jfsd.springboot.model.AppliedJobs;
import com.klef.jfsd.springboot.model.Documents;
import com.klef.jfsd.springboot.model.Education;
import com.klef.jfsd.springboot.model.Jobs;
import com.klef.jfsd.springboot.service.RecruiterService;

import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.internet.MimeMessage;
import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("recruiter")
public class RecruiterController {
	private static final Logger logger = LoggerFactory.getLogger(RecruiterController.class);

	@Autowired
	private RecruiterService recruiterService;
	
	@Autowired 
	private JavaMailSender mailSender;
	
	@Autowired
	private Validator validator;
	

	@GetMapping("/")
	public ModelAndView home() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("home");
		return mv;
	}

	@GetMapping("rreg")
	public ModelAndView rreg() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rreg");
		return mv;
	}

	@GetMapping("rhome")
	public ModelAndView rhome(HttpServletRequest request,HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView();
		Recruiter r = (Recruiter)  session.getAttribute("recruiter");
		if (r == null) {
		    mv.setViewName("rsessionexpiry");
		    return mv;
		    
		}
		long jcnt = recruiterService.findjobspostedbyrecruiter(r.getId());
		long scnt = recruiterService.studentcount(r.getId(),"Watchlist");
		long icnt = recruiterService.interviewscount(r.getId(), "Interview");
		long acnt = recruiterService.jobscount(r.getId(), "Active");
		long pcnt = recruiterService.jobscount(r.getId(), "Inactive");
		long bcnt = recruiterService.jobscount(r.getId(), "Blocked");
		
		mv.setViewName("rhome");
		mv.addObject("jobscnt", jcnt);
		mv.addObject("scnt", scnt);
		mv.addObject("icnt", icnt);
		mv.addObject("acnt", acnt);
		mv.addObject("pcnt", pcnt);
		mv.addObject("bcnt", bcnt);
		mv.addObject("tasks", recruiterService.viewAllTasks());
		return mv;
	}

	@GetMapping("rlogin")
	public ModelAndView rlogin() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rlogin");
		return mv;
	}

	@PostMapping("insertrec")
	public ModelAndView insertrec(HttpServletRequest request) {
		String name = request.getParameter("rname");
		String gender = request.getParameter("rgender");
		String dob = request.getParameter("rdob");
		String company = request.getParameter("rcompany");
		String location = request.getParameter("rlocation");
		String email = request.getParameter("remail");
		String password = request.getParameter("rpwd");
		String contact = request.getParameter("rcontact");

		Recruiter rec = new Recruiter();
		rec.setName(name);
		rec.setGender(gender);
		rec.setDateofbirth(dob);
		rec.setCompany(company);
		rec.setLocation(location);
		rec.setEmail(email);
		rec.setPassword(password);
		rec.setContact(contact);
		rec.setStatus("PENDING");

		// Manual check for password presence during registration
		if (password == null || password.trim().isEmpty()) {
			ModelAndView mv = new ModelAndView("rreg");
			mv.addObject("errorMessage", "Password cannot be blank");
			return mv;
		} else if (password.length() < 8 || password.length() > 50) {
			ModelAndView mv = new ModelAndView("rreg");
			mv.addObject("errorMessage", "Password must be between 8 and 50 characters");
			return mv;
		}

		// Run JSR-380 validation
		Set<ConstraintViolation<Recruiter>> violations = validator.validate(rec);
		if (!violations.isEmpty()) {
			ModelAndView mv = new ModelAndView("rreg");
			mv.addObject("errorMessage", violations.iterator().next().getMessage());
			return mv;
		}

		try {
			String msg = recruiterService.RecruiterRegistration(rec);
			ModelAndView mv = new ModelAndView("regsuccess");
			mv.addObject("message", msg);
			return mv;
		} catch (Exception e) {
			ModelAndView mv = new ModelAndView("rreg");
			if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
				mv.addObject("errorMessage", "Email or Contact Number already registered!");
			} else {
				mv.addObject("errorMessage", "Registration failed: " + e.getMessage());
			}
			return mv;
		}
	}
	
	@GetMapping("rupdateprofile")
	public ModelAndView rupdateprofile()
	{
		ModelAndView mv = new ModelAndView("reditprofile");
		return mv;
	}
	
	@PostMapping("rprofileupdate")
	public ModelAndView rprofileupdate(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    Recruiter rec = (Recruiter) session.getAttribute("recruiter");

	    if (rec == null) {
	        return new ModelAndView("redirect:/recruiter/sessionexpiry");
	    }

	    // Fetch form data
	    String name = request.getParameter("rname");
	    String gender = request.getParameter("rgender");
	    String dob = request.getParameter("rdob");
	    String company = request.getParameter("rcompany");
	    String location = request.getParameter("rlocation");
	    String email = request.getParameter("remail");
	    String password = request.getParameter("rpwd");
	    String contact = request.getParameter("rcontact");

	    Recruiter r = new Recruiter();
	    r.setId(rec.getId());
	    r.setName(name);
	    r.setGender(gender);
	    r.setDateofbirth(dob);
	    r.setCompany(company);
	    r.setLocation(location);
	    r.setEmail(email);
	    r.setPassword(password); // Pass password as is (can be null/blank)
	    r.setContact(contact);
	    r.setStatus(rec.getStatus());

	    // Password validation only if provided
	    if (password != null && !password.trim().isEmpty()) {
	        if (password.length() < 8 || password.length() > 50) {
	            ModelAndView mv = new ModelAndView("reditprofile");
	            mv.addObject("errorMessage", "Password must be between 8 and 50 characters");
	            return mv;
	        }
	    }

	    // Run JSR-380 validation
	    Set<ConstraintViolation<Recruiter>> violations = validator.validate(r);
	    if (!violations.isEmpty()) {
	        ModelAndView mv = new ModelAndView("reditprofile");
	        mv.addObject("errorMessage", violations.iterator().next().getMessage());
	        return mv;
	    }

	    try {
	        String message = recruiterService.updaterProfile(r);
	        // Update session with the latest data
	        Recruiter updatedRecruiter = recruiterService.getrecruiterbyid(rec.getId());
	        session.setAttribute("recruiter", updatedRecruiter);
	        return new ModelAndView("redirect:/recruiter/rsettings");
	    } catch (Exception e) {
	        ModelAndView mv = new ModelAndView("reditprofile");
	        if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
	            mv.addObject("errorMessage", "Contact Number is already in use by another account!");
	        } else {
	            mv.addObject("errorMessage", "Profile update failed: " + e.getMessage());
	        }
	        return mv;
	    }
	}


	@GetMapping("checkreclogin")
	public ModelAndView checkrecloginGet() {
		return new ModelAndView("redirect:/recruiter/rlogin");
	}

	@PostMapping("checkreclogin")
	public ModelAndView checkreclogin(HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();

		String remail = request.getParameter("remail");
		String rpwd = request.getParameter("rpwd");
		Recruiter recruiter = recruiterService.checkreclogin(remail, rpwd);
		if (recruiter != null) {
			logger.info("Recruiter login successful for email: {}", remail);
			HttpSession session = request.getSession();
			session.setAttribute("recruiter", recruiter);
			mv.setViewName("redirect:/recruiter/rhome");
		}

		else {
			logger.warn("Recruiter login failed for email: {}", remail);
			mv.setViewName("rlogin");
			mv.addObject("message", "login failed");
		}
		return mv;
	}

	@GetMapping("rlogout")
	public ModelAndView reclogout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("recruiter");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rlogin");
		return mv;
	}

	@GetMapping("rsessionexpiry")
	public ModelAndView rsessionexpiry(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("recruiter");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rsessionexpiry");
		return mv;
	}

	
	@GetMapping("rview_job_postings")
	public ModelAndView viewalljobs(HttpServletRequest request) {
	    ModelAndView mv = new ModelAndView();
	    HttpSession session = request.getSession();	    
	    Recruiter r  = (Recruiter) session.getAttribute("recruiter");
	    
	    if (r == null) {
		    mv.setViewName("rsessionexpiry");
		    return mv;
		    
		}
	    
	    try {
	        List<Jobs> joblist = recruiterService.Viewjobsbyrecruiterid(r.getId());
	        if (joblist.isEmpty()) {
	            mv.setViewName("rview_job_postings");
	            return mv;
	        }
	        mv.setViewName("rview_job_postings");
	        mv.addObject("joblist", joblist);
	        long count = recruiterService.jobcount();
	        mv.addObject("job", count);

	    } catch (Exception e) {
	        mv.setViewName("taskerror");
	        mv.addObject("message", "Error while fetching job postings: " + e.getMessage());
	    }

	    return mv;
	}

		
	@GetMapping("rsettings")
	public ModelAndView rsettings() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rsettings");
		return mv;
	}

	@GetMapping("radd_job_posting")
	public ModelAndView radd_job_posting() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("radd_job_posting");
		return mv;
	}

	 @PostMapping("insertjobs")
	    public ModelAndView insertjob(HttpServletRequest request) {
		 
		 
		String jobid = generateRandomId();
		String name = request.getParameter("jname");
		String company = request.getParameter("jcompany");
		String location = request.getParameter("jlocation");
		String etype = request.getParameter("jetype");
		String jtype = request.getParameter("jtype");
		String experience = request.getParameter("jexperience");
		String salary = request.getParameter("jsalary");
		String qualifications = request.getParameter("jqualifications");
		String jemail = request.getParameter("jemail");
		String description = request.getParameter("jdescription");
		String deadline = request.getParameter("jdeadline");
		
		int maxappl = 0;
		try {
			String maxapplStr = request.getParameter("jmaxappl");
			if (maxapplStr != null && !maxapplStr.trim().isEmpty()) {
				maxappl = Integer.parseInt(maxapplStr.trim());
			}
		} catch (NumberFormatException e) {
			ModelAndView mv = new ModelAndView("radd_job_posting");
			mv.addObject("error", "Maximum Acceptable Applications must be a valid number");
			return mv;
		}
		
		HttpSession session = request.getSession();
		Recruiter r = (Recruiter) session.getAttribute("recruiter");
		
		Jobs job = new Jobs();
		job.setJobsid(jobid);
		job.setRecruiterid(r.getId());
		job.setName(name);
		job.setCompany(company);
		job.setLocation(location);
		job.setEtype(etype);
		job.setType(jtype);
		job.setExperience(experience);
		job.setSalary(salary);
		job.setQualifications(qualifications);
		job.setDescription(description);
		job.setDeadline(deadline);
		job.setEmail(jemail);
		job.setMaxapplications(maxappl);
		job.setStatus("Active");

		// Run JSR-380 validation
		Set<ConstraintViolation<Jobs>> violations = validator.validate(job);
		if (!violations.isEmpty()) {
			ModelAndView mv = new ModelAndView("radd_job_posting");
			mv.addObject("error", violations.iterator().next().getMessage());
			return mv;
		}

		String msg = recruiterService.addingjob(job);
		
		ModelAndView mv = new ModelAndView("radd_job_posting");
		mv.addObject("message", msg);

		return mv;
	}
	 
	 public static String generateRandomId() {
	      
	        String prefix = "J";
	        Random random = new Random();
	        int randomNumber = 1000 + random.nextInt(9000);
	        return prefix + randomNumber;
	    }

	@GetMapping("redit_job_posting")
	public ModelAndView redit_job_posting(@RequestParam("id")int jid) 
	{
		ModelAndView mv = new ModelAndView();
		Jobs job = recruiterService.getJobById(jid);
		mv.setViewName("redit_job_posting");
		mv.addObject("job", job);
		return mv;
	}
	
	
	@PostMapping("editjobposting")
	public ModelAndView editjobposting(@RequestParam("id")int jid,HttpServletRequest request, RedirectAttributes redirectAttributes)
	{
		Jobs j = recruiterService.getJobById(jid);
		String jobid = j.getJobsid();
		String name = request.getParameter("jname");
		String company = request.getParameter("jcompany");
		String location = request.getParameter("jlocation");
		String etype = request.getParameter("jetype");
		String jtype = request.getParameter("jtype");
		String experience = request.getParameter("jexperience");
		String salary = request.getParameter("jsalary");
		String qualifications = request.getParameter("jqualifications");
		String jemail = request.getParameter("jemail");
		String description = request.getParameter("jdescription");
		String deadline = request.getParameter("jdeadline");
		
		int maxappl = 0;
		try {
			String maxapplStr = request.getParameter("jmaxappl");
			if (maxapplStr != null && !maxapplStr.trim().isEmpty()) {
				maxappl = Integer.parseInt(maxapplStr.trim());
			}
		} catch (NumberFormatException e) {
			ModelAndView mv = new ModelAndView("redit_job_posting");
			mv.addObject("job", j);
			mv.addObject("error", "Maximum Acceptable Applications must be a valid number");
			return mv;
		}
		
		HttpSession session = request.getSession();
		Recruiter r = (Recruiter) session.getAttribute("recruiter");
		
		Jobs job = new Jobs();
		job.setId(jid);
		job.setJobsid(jobid);
		job.setRecruiterid(r.getId());
		job.setName(name);
		job.setCompany(company);
		job.setLocation(location);
		job.setEtype(etype);
		job.setType(jtype);
		job.setExperience(experience);
		job.setSalary(salary);
		job.setQualifications(qualifications);
		job.setDescription(description);
		job.setDeadline(deadline);
		job.setEmail(jemail);
		job.setMaxapplications(maxappl);
		job.setStatus("Active");

		// Run JSR-380 validation
		Set<ConstraintViolation<Jobs>> violations = validator.validate(job);
		if (!violations.isEmpty()) {
			ModelAndView mv = new ModelAndView("redit_job_posting");
			mv.addObject("job", job);
			mv.addObject("error", violations.iterator().next().getMessage());
			return mv;
		}

		String msg = recruiterService.updatejob(job);

		ModelAndView mv = new ModelAndView("redirect:/recruiter/rview_job_postings");
		redirectAttributes.addFlashAttribute("msg", msg);
		return mv;
	}

	@GetMapping("rapplications")
	public ModelAndView rapplications(HttpServletRequest request) 
	{
		ModelAndView mv = new ModelAndView();
	    HttpSession session = request.getSession();	    
	    Recruiter r  = (Recruiter) session.getAttribute("recruiter");
	    
	    if (r == null) {
		    mv.setViewName("rsessionexpiry");
		    return mv;
		    
		}
	    
	    try {
	        List<Jobs> joblist = recruiterService.Viewjobsbyrecruiterid(r.getId());
	        if (joblist.isEmpty()) {
	            mv.setViewName("rview_job_postings");
	            return mv;
	        }
	        mv.setViewName("rapplications");
	        mv.addObject("joblist", joblist);
	        long count = recruiterService.jobcount();
	        mv.addObject("job", count);

	    } catch (Exception e) {
	        mv.setViewName("taskerror");
	        mv.addObject("message", "Error while fetching job postings: " + e.getMessage());
	    }

	    return mv;
	}

	

	@GetMapping("rtask")
	public ModelAndView rtask() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rtask");
		mv.addObject("tasks", recruiterService.viewAllTasks());
		return mv;
	}

	@GetMapping("rapplication1")
	public ModelAndView rapplication1() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("rapplication1");
		return mv;
	}

	@GetMapping("view")
	public ModelAndView view() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("view");
		return mv;
	}

	
	@GetMapping("/rget_job_details/{jid}")
	public ModelAndView getJobDetails(@PathVariable("jid") int jid) {
	    logger.info("Fetching details for jobId: {}", jid);
	    Jobs job = recruiterService.getJobById(jid);
	    ModelAndView mv = new ModelAndView();

	    if (job != null) {
	        mv.addObject("job", job);
	        mv.setViewName("jobDetails");
	    } else {
	        mv.addObject("error", "Job not found");
	        mv.setViewName("errorPage");
	    }

	    return mv;
	}

	
	@GetMapping("rdelete_job_posting")
    public ModelAndView rdelete_job_posting(@RequestParam("id") int jid, HttpServletRequest request)
    {
      ModelAndView mv = new ModelAndView();
      HttpSession session = request.getSession();	    
	  Recruiter r  = (Recruiter) session.getAttribute("recruiter");
	  
	  if (r == null) {
		    mv.setViewName("rsessionexpiry");
		    return mv;
		    
		}
      String msg = recruiterService.deletejob(jid);
      
      List<Jobs> joblist = recruiterService.Viewjobsbyrecruiterid(r.getId());
      
      mv.setViewName("rview_job_postings");
      mv.addObject("joblist", joblist);
      
      return mv;
    }

	


    @GetMapping("addtask")
    public ModelAndView addtask() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("addtask"); 
        return mv;
    }

    @PostMapping("addtask")
    public ModelAndView addtask(HttpServletRequest request, HttpSession session) {
        ModelAndView mv = new ModelAndView();

        try {
            String taskDescription = request.getParameter("taskDescription");
            String taskDeadline = request.getParameter("taskDeadline");
            Recruiter recruiter = (Recruiter) session.getAttribute("recruiter");

            if (recruiter == null) {
                mv.setViewName("redirect:rlogin");
                return mv;
            }

            Task task = new Task();
            task.setDescription(taskDescription);
            task.setDeadline(taskDeadline);
            recruiterService.addTask(task);
            
            mv.setViewName("redirect:rtask");
        } catch (Exception e) {
            e.printStackTrace();  
            mv.setViewName("redirect:rtask");
        }

        return mv;
    }


    @GetMapping("list")
    public ModelAndView getTasksByRecruiter(HttpSession session) {
        ModelAndView mv = new ModelAndView();

        Recruiter recruiter = (Recruiter) session.getAttribute("recruiter");
        if (recruiter == null) {
		    mv.setViewName("rsessionexpiry");
		    return mv;
		    
		}
        else {
       
           // List<Task> tasks = recruiterService.getTasksByRecruiterId(recruiter.getId());
            mv.setViewName("task_list");
            //mv.addObject("taskList", tasks);
         
        }
        return mv;
    }
    
    
    @GetMapping("jobapplications")
    public ModelAndView jobapplications(HttpServletRequest request)
    {
    	
	    HttpSession session = request.getSession();	  
	    ModelAndView mv = new ModelAndView("jobapplications");
	    Recruiter r  = (Recruiter) session.getAttribute("recruiter");
	    if (r == null) {
		    mv.setViewName("rsessionexpiry");
		    return mv;
		    
		}
	    
    	
    	try {
	        List<Jobs> joblist = recruiterService.Viewjobsbyrecruiterid(r.getId());
	        
	        mv.setViewName("jobapplications");
	        mv.addObject("joblist", joblist);
	        

	    } catch (Exception e) {
	        mv.setViewName("taskerror");
	        mv.addObject("message", "Error while fetching job postings: " + e.getMessage());
	    }

    	return mv;
    }
    
    @GetMapping("getapplicants")
    public ModelAndView getapplicantsbyjobid(@RequestParam("id")int jid,@RequestParam("name")String jobname)
    {
    	List<AppliedJobs> applicants = recruiterService.getapplicantsbyjobid(jid);
    	ModelAndView mv = new ModelAndView();
    	if(applicants!=null)
    	{
    		mv.setViewName("jobapplicants");
    		mv.addObject("applicants", applicants);
    		mv.addObject("jobid", jid);
    		mv.addObject("jobname", org.springframework.web.util.HtmlUtils.htmlEscape(jobname));
    	}
    	else
    	{
    		mv.setViewName("jobapplications");
    		mv.addObject("msg","No Applicants found for this job");
    	}
    	
    	return mv;
    }
    
    @GetMapping("getinterviewlist")
    public ModelAndView getinterviewlistbyjobid(@RequestParam("id")int jid,@RequestParam("name")String jobname)
    {
    	List<AppliedJobs> applicants = recruiterService.getapplicantsbyjobid(jid);
    	ModelAndView mv = new ModelAndView();
    	if(applicants!=null)
    	{
    		mv.setViewName("jobinterviews");
    		mv.addObject("applicants", applicants);
    		mv.addObject("jobname", org.springframework.web.util.HtmlUtils.htmlEscape(jobname));
    		mv.addObject("jobid", jid);
    	}
    	else
    	{
    		mv.setViewName("jobinterviews");
    		mv.addObject("msg","No Applicants found for this job");
    	}
    	
    	return mv;
    }
    
    @GetMapping("getstudentdetails")
	public ModelAndView getstudentdetails(HttpServletRequest request, @RequestParam("id") long id)
	{
		Student s = recruiterService.findstudentbyid(id);
		Education e = recruiterService.findstudenteducationdetails(id);
		Documents d = recruiterService.getdocumentsbyid(id);
		
		ModelAndView mv  = new  ModelAndView("studenttotaldetails");
		mv.addObject("student", s);
		mv.addObject("edu", e);
		mv.addObject("doc", d);
		
		return mv;
	}
    
    @GetMapping("/getMarksheets/{studentId}")
	public ResponseEntity<byte[]> getMarksheets(@PathVariable long studentId) throws SQLException {
	    Documents doc = recruiterService.getdocumentsbyid(studentId);
	    if (doc != null && doc.getMarksheet() != null) {
	        byte[] marksheetBytes = doc.getMarksheet().getBytes(1, (int) doc.getMarksheet().length());
	        return ResponseEntity.ok()
	                .contentType(MediaType.APPLICATION_PDF)
	                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename="+studentId+"marksheet.pdf")
	                .body(marksheetBytes);
	    }
	    return ResponseEntity.notFound().build();
	}

	@GetMapping("/getResume/{studentId}")
	public ResponseEntity<byte[]> getResume(@PathVariable long studentId) throws SQLException {
	    Documents doc = recruiterService.getdocumentsbyid(studentId);
	    if (doc != null && doc.getResume() != null) {
	        byte[] resumeBytes = doc.getResume().getBytes(1, (int) doc.getResume().length());
	        return ResponseEntity.ok()
	                .contentType(MediaType.APPLICATION_PDF)
	                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename="+studentId+"_resume.pdf")
	                .body(resumeBytes);
	    }
	    return ResponseEntity.notFound().build();
	}
	
	@GetMapping("setstatus/{id}/{status}")
	public ModelAndView setjobstatus(@PathVariable("id")int id, @PathVariable("status")String status) throws MessagingException
	{
		String msg = recruiterService.updatestudentjobstatus(status,id);
		AppliedJobs app = recruiterService.getappliedjobbyid(id);
		ModelAndView mv = new ModelAndView();
		
		MimeMessage mimeMessage = mailSender.createMimeMessage(); 
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        
        helper.setTo(app.getStudent().getEmail());
        helper.setFrom("ktatwadarsan@gmail.com");
		
		String name = app.getStudent().getName();
		String company = app.getJobs().getCompany();
		String position = app.getJobs().getName();
		
		String subject = null;
		String content = null;
		
		

			
			if (status.equalsIgnoreCase("Shortlisted")) {
		        subject = "Shortlisting for " + position + " position at " + company;
		        content = "<div style='font-family: Arial, sans-serif; color: #333;'>"
		                + "<h2 style='color: #4CAF50;'>Congratulations, " + name + "!</h2>"
		                + "<p style='font-size: 16px;'>We are pleased to inform you that you have been <strong style='color: #4CAF50;'>shortlisted</strong> for the position of "
		                + "<strong>" + position + "</strong> at <strong>" + company + "</strong>.</p>"
		                + "<p style='font-size: 16px;'>Please await further updates regarding the next steps in the process.</p>"
		                + "<hr style='border-top: 2px solid #4CAF50;'>"
		                + "<p style='font-size: 14px; color: #777;'>Best regards,</p>"
		                + "<p style='font-size: 14px; color: #777;'>The Recruitment Team</p>"
		                + "</div>";
		    } else if (status.equalsIgnoreCase("Rejected")) {
		        subject = "Application Update for " + position + " position at " + company;
		        content = "<div style='font-family: Arial, sans-serif; color: #333;'>"
		                + "<h2 style='color: #FF0000;'>Update on Your Application</h2>"
		                + "<p style='font-size: 16px;'>Dear " + name + ",</p>"
		                + "<p style='font-size: 16px;'>We regret to inform you that your application for the position of "
		                + "<strong>" + position + "</strong> at <strong>" + company + "</strong> has not been shortlisted at this time.</p>"
		                + "<p style='font-size: 16px;'>We thank you for your interest and encourage you to apply for future opportunities with us.</p>"
		                + "<hr style='border-top: 2px solid #FF0000;'>"
		                + "<p style='font-size: 14px; color: #777;'>Best regards,</p>"
		                + "<p style='font-size: 14px; color: #777;'>The Recruitment Team</p>"
		                + "</div>";
		        
		       
		    }
		    else if (status.equalsIgnoreCase("Interview")) {
		        subject = "Interview Invitation for " + position + " position at " + company;
		        content = "<div style='font-family: Arial, sans-serif; color: #333;'>"
		                + "<h2 style='color: #FFA500;'>Congratulations, " + name + "!</h2>"
		                + "<p style='font-size: 16px;'>We are excited to inform you that you have been <strong style='color: #FFA500;'>selected for an interview</strong> for the position of "
		                + "<strong>" + position + "</strong> at <strong>" + company + "</strong>.</p>"
		                + "<p style='font-size: 16px;'>Interview Details will be provided shortly</p>"
		                + "<p style='font-size: 16px;'>Please prepare accordingly and let us know if you have any questions.</p>"
		                + "<hr style='border-top: 2px solid #FFA500;'>"
		                + "<p style='font-size: 14px; color: #777;'>Best regards,</p>"
		                + "<p style='font-size: 14px; color: #777;'>The Recruitment Team," +company+"</p>"
		                + "</div>";
		    }
					
		
			helper.setSubject(subject);
		    helper.setText(content, true);
		    mailSender.send(mimeMessage);
		
		
		
		mv.setViewName("redirect:/recruiter/getapplicants?id=" + app.getJobs().getId() + "&name=" + app.getJobs().getName());
		return mv;
	}
	
	@GetMapping("setinterviewstatus/{id}/{status}")
	public ModelAndView setinterviewstatus(@PathVariable("id")int id, @PathVariable("status")String status) throws MessagingException
	{
		String msg = recruiterService.updatestudentjobstatus(status,id);
		AppliedJobs app = recruiterService.getappliedjobbyid(id);
		
		MimeMessage mimeMessage = mailSender.createMimeMessage(); 
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        
        helper.setTo(app.getStudent().getEmail());
        helper.setFrom("ktatwadarsan@gmail.com");
		
		String name = app.getStudent().getName();
		String company = app.getJobs().getCompany();
		String position = app.getJobs().getName();
		
		String subject = null;
		String content = null;
		logger.info("Sending selection/rejection email to candidate: {} for position: {}", name, position);
		
		if (status.equalsIgnoreCase("Selected")) {
			subject = "Job Offer for " + position + " position at " + company;
		    content = "<div style='font-family: Arial, sans-serif; color: #333;'>"
		            + "<h2 style='color: darkgreen;'>Congratulations, " + name + "!</h2>"
		            + "<p style='font-size: 16px;'>We are excited to inform you that you have been <strong style='color: #4CAF50;'>selected</strong> for the position of "
		            + "<strong>" + position + "</strong> at <strong>" + company + "</strong>.</p>"
		            + "<p style='font-size: 16px;'>Here are the details of your job offer:</p>"
		            + "<ul style='font-size: 16px;'>"
		            + "<li><strong>Position:</strong> " + position + "</li>"
		            + "<li><strong>Company:</strong> " + company + "</li>"
		            + "</ul>"
		            + "<p style='font-size: 16px;'>Offer Letter and joining details willbe communicated shortly</p>"
		            + "<p style='font-size: 16px;'>Please confirm your acceptance of this offer by responding to this email or contacting us directly at your earliest convenience.</p>"
		            + "<p style='font-size: 16px;'>We look forward to welcoming you to our team and wish you success in this new journey!</p>"
		            + "<hr style='border-top: 2px solid #4CAF50;'>"
		            + "<p style='font-size: 14px; color: #777;'>Best regards,</p>"
		            + "<p style='font-size: 14px; color: #777;'>The Recruitment Team</p>"
		            + "</div>";
		    
		    logger.info("Selection email structure generated successfully for candidate: {}", name);
	    } else if (status.equalsIgnoreCase("Rejected")) {
	        subject = "Application Update for " + position + " position at " + company;
	        content = "<div style='font-family: Arial, sans-serif; color: #333;'>"
	                + "<h2 style='color: #FF0000;'>Update on Your Application</h2>"
	                + "<p style='font-size: 16px;'>Dear " + name + ",</p>"
	                + "<p style='font-size: 16px;'>We regret to inform you that your application for the position of "
	                + "<strong>" + position + "</strong> at <strong>" + company + "</strong> has not been shortlisted at this time.</p>"
	                + "<p style='font-size: 16px;'>We thank you for your interest and encourage you to apply for future opportunities with us.</p>"
	                + "<hr style='border-top: 2px solid #FF0000;'>"
	                + "<p style='font-size: 14px; color: #777;'>Best regards,</p>"
	                + "<p style='font-size: 14px; color: #777;'>The Recruitment Team</p>"
	                + "</div>";
	    }
		
			
		helper.setSubject(subject);
	    helper.setText(content, true);
	    mailSender.send(mimeMessage);
		
		
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/recruiter/getinterviewlist?id=" + app.getJobs().getId() + "&name=" + app.getJobs().getName());
		return mv;
	}
	
	@GetMapping("rpending")
	public ModelAndView rpending()
	{
		ModelAndView mv = new ModelAndView("regpending");
		return mv;
	}
	
	@GetMapping("rblocked")
	public ModelAndView recblocked()
	{
		ModelAndView mv = new ModelAndView("recblocked");
		return mv;
	}
	
	
	@RequestMapping("/recruiter/chat")
	public class RecruiterChatBotController {

	    @PostMapping
	    public ResponseEntity<String> handleChat(@RequestBody String message) {
	        message = message.toLowerCase();
	        String response = getBotResponse(message);
	        return ResponseEntity.ok(response);
	    }

	    private String getBotResponse(String message) {
	        if (message.contains("post job")) {
	            return "Go to the 'Job Postings' section to create a new job post.";
	        } else if (message.contains("view applications") || message.contains("student applications")) {
	            return "Navigate to 'Student Applications' in the dashboard to view them.";
	        } else if (message.contains("create a job post")) {
	            return "Sure! Please provide the job title, company name, and job description in order.";
	        } else if (message.contains("schedule interview")) {
	            return "Please specify candidate name, date and time to schedule the interview.";
	        } else if (message.contains("today's interviews")) {
	            return "You have 2 interviews scheduled for today at 11:00 AM and 3:00 PM."; // Ideally fetched from DB
	        } else if (message.contains("find candidates") || message.contains("search candidates")) {
	            return "You can use the 'Candidates' tab with filters like skills, experience, or qualification.";
	        } else if (message.contains("update profile")) {
	            return "Go to the 'Settings' > 'Profile' section to update your company profile.";
	        } else if (message.contains("support")) {
	            return "You can reach out to support at support@careerstream.com or use the Help section.";
	        } else if (message.contains("edit job")) {
	            return "Visit 'Job Postings', click on the job you want to edit, and hit 'Edit'.";
	        } else if (message.contains("show me stats")) {
	            return "You posted 5 jobs, received 80 applications, and shortlisted 12 candidates.";
	        } else if (message.contains("rejection message")) {
	            return "Suggested message: 'We appreciate your application. Unfortunately, you weren’t shortlisted.'";
	        } else if (message.contains("interview invite")) {
	            return "Suggested message: 'You are invited for an interview scheduled on [date] at [time].'";
	        } else {
	            return "I'm here to help! Try asking about job posting, viewing applications, scheduling interviews, or more!";
	        }
	    }
	    }
	
	
    
	
}
