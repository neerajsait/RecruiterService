package com.klef.jfsd.springboot.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "tasks_table")
public class Task {
		@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private int id;
		@Column(name="task_descripton",nullable=false,length = 2000)
	    private String description;
		@Column(name="task_deadline",nullable=false,length = 50)
	    private String deadline;
		@Column(name="iscomplete")
	    private boolean isComplete;
	
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public String getDeadline() {
			return deadline;
		}
		public void setDeadline(String deadline) {
			this.deadline = deadline;
		}
		public boolean isComplete() {
			return isComplete;
		}
		public void setComplete(boolean isComplete) {
			this.isComplete = isComplete;
		}
		
}
		

