package com.klef.jfsd.springboot.service;

import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

@ExtendWith(MockitoExtension.class)
public class EmailServiceTest {

    @Mock
    private JavaMailSender mailSender;

    @InjectMocks
    private EmailService emailService;

    @Test
    void testSendRegistrationPendingEmail() {
        String toEmail = "test@example.com";
        String recruiterName = "John Doe";

        emailService.sendRegistrationPendingEmail(toEmail, recruiterName);

        verify(mailSender, times(1)).send(any(SimpleMailMessage.class));
    }

    @Test
    void testSendFeedbackEmail() {
        String name = "Alice";
        String fromEmail = "alice@example.com";
        String feedbackMessage = "Great portal!";

        emailService.sendFeedbackEmail(name, fromEmail, feedbackMessage);

        verify(mailSender, times(1)).send(any(SimpleMailMessage.class));
    }
}
