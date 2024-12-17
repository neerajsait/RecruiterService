package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Jobs;
import com.klef.jfsd.springboot.model.Recruiter;

@Repository
public interface RecruiterRepository extends JpaRepository<Recruiter,Integer>
{
	@Query("select r from Recruiter r where r.email=?1 and r.password=?2")
	public Recruiter checkreclogin(String email, String pwd);

	

}
