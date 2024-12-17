// Toggle the sidebar
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('active');
}

// Toggle the dropdown for the specified type
function toggleDropdown(type) {
    const dropdownContent = document.getElementById(`${type}-dropdown`);
    const arrow = dropdownContent.previousElementSibling.querySelector('.arrow');
    dropdownContent.classList.toggle('show');

    // Rotate arrow when dropdown is toggled
    if (dropdownContent.classList.contains('show')) {
        arrow.style.transform = "rotate(180deg)";
    } else {
        arrow.style.transform = "rotate(0deg)";
    }
}


// Logout function
function logout() {
    window.location.href = "rlogin.jsp"; // Redirect to the login page
}


/*// JavaScript for Password Matching Validation
        const form = document.querySelector('form');
        form.addEventListener('submit', function(event) {
            const password = document.getElementById('rpwd').value;
            const confirmPassword = document.getElementById('rpwd_confirm').value;
            if (password !== confirmPassword) {
                event.preventDefault();
                alert("Passwords do not match. Please try again.");
            }
        });*/
		
		
		
		// Function to show the modal and load job details
		       function viewJobDetails(jobId) {
		           // Use AJAX to fetch job details based on the jobId
		           var xhr = new XMLHttpRequest();
		           xhr.open("GET", "rget_job_details?id=" + jobId, true);
		           xhr.onreadystatechange = function() {
		               if (xhr.readyState == 4 && xhr.status == 200) {
		                   // Parse the JSON response
		                   var job = JSON.parse(xhr.responseText);

		                   // Populate the modal with job details
		                   document.getElementById('jobTitle').textContent = job.name;
		                   document.getElementById('jobCompany').textContent = job.company;
		                   document.getElementById('jobLocation').textContent = job.location;
		                   document.getElementById('jobEmploymentType').textContent = job.employmentType;
		                   document.getElementById('jobDescription').textContent = job.description;
		                   
		                   // Display the modal
		                   document.getElementById('jobDetailsModal').style.display = 'block';
		               }
		           };
		           xhr.send();
		       }

		       // Function to close the modal
		       function closeModal() {
		           document.getElementById('jobDetailsModal').style.display = 'none';
		       }
