package com.klef.jfsd.springboot.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public ModelAndView handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            
            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                return new ModelAndView("404_error");
            }
            else if (statusCode == HttpStatus.METHOD_NOT_ALLOWED.value()) {
                return new ModelAndView("405_error");
            }
            else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                return new ModelAndView("500_error");
            }
            else if (statusCode == HttpStatus.BAD_REQUEST.value()) {
                return new ModelAndView("400_error");
            }
        }
        
        // Fallback for any other unexpected error codes
        return new ModelAndView("400_error"); 
    }
}
