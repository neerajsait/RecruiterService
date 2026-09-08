package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendRegistrationPendingEmail(String toEmail, String recruiterName) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("ktatwadarsan@gmail.com");
        message.setTo(toEmail);
        message.setSubject("Registration Pending - CareerStream Admin");
        
        String body = "Dear " + recruiterName + ",\n\n"
                    + "Thank you for registering on CareerStream as a Recruiter.\n\n"
                    + "Your registration is currently under review by our Admin team. "
                    + "Access will be granted once your account is approved. You will receive another notification once your account is activated.\n\n"
                    + "Please wait for further updates.\n\n"
                    + "Best Regards,\n"
                    + "CareerStream Admin Team";
                    
        message.setText(body);
        
        mailSender.send(message);
    }

    public void sendFeedbackEmail(String name, String fromEmail, String feedbackMessage) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("ktatwadarsan@gmail.com"); // Should ideally match the authenticated user or be a generic no-reply if not supported
        message.setTo("2200030957cseh@gmail.com");
        message.setSubject("New Feedback from " + name);
        
        String body = "You have received new feedback from the CareerStream portal:\n\n"
                    + "Name: " + name + "\n"
                    + "Email: " + fromEmail + "\n\n"
                    + "Message:\n"
                    + feedbackMessage;
                    
        message.setText(body);
        
        mailSender.send(message);
    }
}
