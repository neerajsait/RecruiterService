package com.klef.jfsd.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.service.EmailService;

@Controller
public class ClientController 
{
	@Autowired
	private EmailService emailService;

	@GetMapping("/")
	public ModelAndView index()
	{
		ModelAndView mv = new ModelAndView("index");
		return mv;
	}
	
	@GetMapping("about")
	public ModelAndView about()
	{
		ModelAndView mv = new ModelAndView("about");
		return mv;
	}
	
	@GetMapping("contact")
	public ModelAndView contact()
	{
		ModelAndView mv = new ModelAndView("contact");
		return mv;
	}
	
	@GetMapping("feedback")
	public ModelAndView feedback()
	{
		ModelAndView mv = new ModelAndView("feedback");
		return mv;
	}
	
	@PostMapping("submitfeedback")
	public ModelAndView submitFeedback(
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("message") String message) 
	{
		ModelAndView mv = new ModelAndView("feedback");
		try {
			emailService.sendFeedbackEmail(name, email, message);
			mv.addObject("successMessage", "Thank you for your feedback! We will get back to you shortly.");
		} catch (Exception e) {
			mv.addObject("errorMessage", "There was an error submitting your feedback. Please try again later.");
		}
		return mv;
	}
	
	@GetMapping("home")
	public ModelAndView home()
	{
		ModelAndView mv = new ModelAndView("index");
		return mv;
	}
	
	@GetMapping("roleselection")
	public ModelAndView roleselection()
	{
		ModelAndView mv = new ModelAndView("roleselection");
		return mv;
	}
}
