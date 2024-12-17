package com.klef.jfsd.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Jobs;

import jakarta.transaction.Transactional;

@Repository
public interface JobsRepository extends JpaRepository<Jobs, Integer> {

	@Query("select j from Jobs j where j.id=?1")
    public Jobs findjobbyid(int id);

    @Modifying
    @Transactional
    @Query("delete from Jobs j where j.email = ?1")
    public int deletejobByEmail(String jemail);
    
    @Query("select j from Jobs j where j.recruiterid=?1")
    public List<Jobs> findjobsbyrecruiterid(int rid);
    
    @Query("select count(j) from Jobs j where j.recruiterid=?1 and j.status!='Blocked'")
    public long findjobspostedbyrecruiter(int rid);
    
    @Query("select count(j) from Jobs j where j.recruiterid=?1 and j.status=?2")
    public long jobscount(int rid,String status);
    
}
