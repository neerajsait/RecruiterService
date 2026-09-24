package com.klef.jfsd.springboot.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.klef.jfsd.springboot.model.Jobs;
import com.klef.jfsd.springboot.model.Recruiter;
import com.klef.jfsd.springboot.repository.JobsRepository;
import com.klef.jfsd.springboot.repository.RecruiterRepository;

@ExtendWith(MockitoExtension.class)
public class RecruiterServiceImplTest {

    @Mock
    private RecruiterRepository recruiterRepository;

    @Mock
    private JobsRepository jobsRepository;

    @Mock
    private BCryptPasswordEncoder passwordEncoder;

    @InjectMocks
    private RecruiterServiceImpl recruiterService;

    private Recruiter mockRecruiter;
    private Jobs mockJob;

    @BeforeEach
    void setUp() {
        mockRecruiter = new Recruiter();
        mockRecruiter.setId(1);
        mockRecruiter.setEmail("test@recruiter.com");
        mockRecruiter.setPassword("encodedPassword");

        mockJob = new Jobs();
        mockJob.setId(101);
        mockJob.setName("Software Engineer");
    }

    @Test
    void testCheckRecLogin_Success() {
        when(recruiterRepository.findByEmail("test@recruiter.com")).thenReturn(mockRecruiter);
        when(passwordEncoder.matches("password123", "encodedPassword")).thenReturn(true);

        Recruiter result = recruiterService.checkreclogin("test@recruiter.com", "password123");

        assertNotNull(result);
        assertEquals("test@recruiter.com", result.getEmail());
    }

    @Test
    void testCheckRecLogin_Failure() {
        when(recruiterRepository.findByEmail("test@recruiter.com")).thenReturn(mockRecruiter);
        when(passwordEncoder.matches("wrongpassword", "encodedPassword")).thenReturn(false);

        Recruiter result = recruiterService.checkreclogin("test@recruiter.com", "wrongpassword");

        assertNull(result);
    }

    @Test
    void testAddingJob() {
        when(jobsRepository.save(mockJob)).thenReturn(mockJob);

        String result = recruiterService.addingjob(mockJob);

        assertEquals("Job added successfully....!", result);
        verify(jobsRepository, times(1)).save(mockJob);
    }

    @Test
    void testDeleteJob() {
        when(jobsRepository.findById(101)).thenReturn(Optional.of(mockJob));
        
        String result = recruiterService.deletejob(101);

        assertEquals("Jobs deleted successfully", result);
        assertEquals("Blocked", mockJob.getStatus());
        verify(jobsRepository, times(1)).save(mockJob);
    }
    
    @Test
    void testUpdaterProfile() {
        Recruiter updatedData = new Recruiter();
        updatedData.setId(1);
        updatedData.setName("New Name");
        updatedData.setPassword("newpassword");

        when(recruiterRepository.findById(1)).thenReturn(Optional.of(mockRecruiter));
        when(passwordEncoder.encode("newpassword")).thenReturn("newEncodedPassword");

        String result = recruiterService.updaterProfile(updatedData);

        assertEquals("Profile Updated Successfully", result);
        assertEquals("New Name", mockRecruiter.getName());
        assertEquals("newEncodedPassword", mockRecruiter.getPassword());
        verify(recruiterRepository, times(1)).save(mockRecruiter);
    }
}
