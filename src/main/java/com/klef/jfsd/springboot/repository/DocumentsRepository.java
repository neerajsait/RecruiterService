package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Documents;

@Repository
public interface DocumentsRepository extends JpaRepository<Documents, Long>
{
	@Query("select d from Documents d where d.studentid=?1")
	public Documents finddocumentbystudentid(long id);
}
