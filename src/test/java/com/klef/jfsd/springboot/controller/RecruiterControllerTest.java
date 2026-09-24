package com.klef.jfsd.springboot.controller;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.klef.jfsd.springboot.model.Recruiter;
import com.klef.jfsd.springboot.service.RecruiterService;

import jakarta.validation.Validator;
import java.util.Collections;

@ExtendWith(MockitoExtension.class)
public class RecruiterControllerTest {

    private MockMvc mockMvc;

    @Mock
    private RecruiterService recruiterService;

    @Mock
    private Validator validator;

    @InjectMocks
    private RecruiterController recruiterController;

    @BeforeEach
    void setUp() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");

        mockMvc = MockMvcBuilders.standaloneSetup(recruiterController)
                .setViewResolvers(viewResolver)
                .build();
    }

    @Test
    void testHome() throws Exception {
        mockMvc.perform(get("/recruiter/"))
                .andExpect(status().isOk())
                .andExpect(view().name("home"));
    }

    @Test
    void testRlogin() throws Exception {
        mockMvc.perform(get("/recruiter/rlogin"))
                .andExpect(status().isOk())
                .andExpect(view().name("rlogin"));
    }

    @Test
    void testRhome_WithoutSession() throws Exception {
        mockMvc.perform(get("/recruiter/rhome"))
                .andExpect(status().isOk())
                .andExpect(view().name("rsessionexpiry"));
    }

    @Test
    void testRhome_WithSession() throws Exception {
        Recruiter mockRecruiter = new Recruiter();
        mockRecruiter.setId(1);
        mockRecruiter.setName("John");

        when(recruiterService.findjobspostedbyrecruiter(1)).thenReturn(5L);
        when(recruiterService.studentcount(1, "Watchlist")).thenReturn(10L);
        when(recruiterService.interviewscount(1, "Interview")).thenReturn(2L);
        when(recruiterService.jobscount(1, "Active")).thenReturn(3L);
        when(recruiterService.jobscount(1, "Inactive")).thenReturn(1L);
        when(recruiterService.jobscount(1, "Blocked")).thenReturn(1L);
        when(recruiterService.viewAllTasks()).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/recruiter/rhome").sessionAttr("recruiter", mockRecruiter))
                .andExpect(status().isOk())
                .andExpect(view().name("rhome"))
                .andExpect(model().attributeExists("jobscnt", "scnt", "icnt", "acnt", "pcnt", "bcnt", "tasks"));
    }

    @Test
    void testCheckRecLogin_Success() throws Exception {
        Recruiter mockRecruiter = new Recruiter();
        mockRecruiter.setEmail("test@example.com");
        mockRecruiter.setHasCompletedFirstLogin(true);

        when(recruiterService.checkreclogin("test@example.com", "password")).thenReturn(mockRecruiter);

        mockMvc.perform(post("/recruiter/checkreclogin")
                .param("remail", "test@example.com")
                .param("rpwd", "password"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/recruiter/rhome"))
                .andExpect(request().sessionAttribute("recruiter", mockRecruiter));
    }

    @Test
    void testCheckRecLogin_Failure() throws Exception {
        when(recruiterService.checkreclogin("test@example.com", "wrongpassword")).thenReturn(null);

        mockMvc.perform(post("/recruiter/checkreclogin")
                .param("remail", "test@example.com")
                .param("rpwd", "wrongpassword"))
                .andExpect(status().isOk())
                .andExpect(view().name("rlogin"))
                .andExpect(model().attribute("message", "login failed"));
    }
}
