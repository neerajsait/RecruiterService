package com.klef.jfsd.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.AppliedJobs;

import jakarta.transaction.Transactional;

@Repository
public interface AppliedJobsRepository extends JpaRepository<AppliedJobs, Integer>
{
	@Query("select ap from AppliedJobs ap where ap.jobs.id=?1")
	public List<AppliedJobs> getapplicantsbyjobid(int jid);
	
	@Modifying
    @Transactional
    @Query("update AppliedJobs ap set ap.status=?1 where ap.id=?2")
    public int updatestudentapplicationstatus(String status, int id);
	
	@Query("select count(ap) from AppliedJobs ap where ap.jobs.recruiterid=?1 and ap.status!=?2")
	public long studentcount(int rid,String status);
	
	@Query("select count(ap) from AppliedJobs ap where ap.jobs.recruiterid=?1 and ap.status=?2")
	public long interviewscount(int rid,String status);
	
	
	
}
