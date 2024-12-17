package com.klef.jfsd.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ClientController 
{
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
