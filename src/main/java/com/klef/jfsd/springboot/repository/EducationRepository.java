package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Education;
import java.util.List;

@Repository
public interface EducationRepository extends JpaRepository<Education, Long>
{
	@Query("select e from Education e where e.studentid=?1")
	public Education findEducationByStudentid(long studentid);
	
	
	
	
}
