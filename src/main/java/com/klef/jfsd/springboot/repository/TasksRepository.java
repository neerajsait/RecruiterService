package com.klef.jfsd.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Task;

@Repository
public interface TasksRepository extends JpaRepository<Task, Integer> {
	 //List<Task> findByRecruiterId(int recruiterId);

}
