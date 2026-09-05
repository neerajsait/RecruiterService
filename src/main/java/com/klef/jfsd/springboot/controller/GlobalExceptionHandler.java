package com.klef.jfsd.springboot.controller;

import java.sql.SQLException;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.ModelAndView;

import jakarta.mail.MessagingException;

@ControllerAdvice
public class GlobalExceptionHandler {

    // Handle specific 500 exceptions requested by the user
    @ExceptionHandler({SQLException.class, MessagingException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ModelAndView handleInternalServerError(Exception ex) {
        ModelAndView mv = new ModelAndView("500_error");
        // We log the exception but we show the safe page to the user
        ex.printStackTrace(); 
        return mv;
    }

    // Handle common 400 Bad Request exceptions
    @ExceptionHandler({
        IllegalArgumentException.class, 
        MethodArgumentTypeMismatchException.class, 
        MissingServletRequestParameterException.class
    })
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView handleBadRequest(Exception ex) {
        ModelAndView mv = new ModelAndView("400_error");
        ex.printStackTrace();
        return mv;
    }
}
