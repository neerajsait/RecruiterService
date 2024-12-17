<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
 
  <link rel="stylesheet" href="./css/index.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
  @charset "UTF-8";
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
body {
  background-image: url('../images/HomePage.jpg');
  margin-top: 999px;
  background-size: 100% auto; /* Adjusts the width to 100% of the screen, height auto */
  background-attachment: fixed;
  background-position: center top; /* Keeps the image centered at the top */
  background-repeat: no-repeat; /* Prevents repeating of the image */
}

nav {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 62px;
  background-color: #2f335a;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
}
nav .navbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
  max-width: 90%;
  background: #2f335a;
  margin: auto;
}
nav .navbar .logo a {
  color: #fff;
  font-size: 27px;
  font-weight: 600;
  text-decoration: none;
}
nav .navbar .menu {
  display: flex;
}
.navbar .menu li {
  list-style: none;
  margin: 0 15px;
}
.navbar .menu li a {
  color: #fff;
  font-size: 17px;
  font-weight: 500;
  text-decoration: none;
}

.proverb {
  position: fixed;
  right: 20px;
  top: 50%;
  transform: translateY(-50%);
  color: #454024;
  font-size: 54px;
  padding: 20px;
  border-radius: 5px;
  text-align: center;
  width: 500px; /* Set a width for centering */
  margin-top: 60px;
}


button .arrow-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
}

button .arrow {
  margin-top: 1px;
  width: var(--arrow-width);
  background: var(--primary-color);
  height: var(--arrow-stroke);
  position: relative;
  transition: 0.2s;
}

button .arrow::before {
  content: "";
  box-sizing: border-box;
  position: absolute;
  border: solid var(--secondary-color);
  border-width: 0 var(--arrow-stroke) var(--arrow-stroke) 0;
  display: inline-block;
  top: -3px;
  right: 3px;
  transition: 0.2s;
  padding: 3px;
  transform: rotate(-45deg);
}

button:hover {
  background-color: var(--hover-color);
}

button:hover .arrow {
  background: var(--secondary-color);
}

button:hover .arrow:before {
  right: 0;
}

footer {
  padding: 4px 5px; /* Slightly increased padding */
  margin-top: 738px; /* Adds space above the footer */
  background: #1d07a9;
  color: #fff;
  text-align: center;
}
footer h2 {
  font-size: 30px;
  margin-bottom: 20px;
}
footer .details {
  font-size: 18px;
  color: #fff;
}
footer .details .item {
  margin-bottom: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
}
footer .details .item i {
  font-size: 24px;
  margin-right: 15px;
}
footer .details .item a {
  color: #fff;
  text-decoration: none;
}
footer .details .item a:hover {
  text-decoration: underline;
}
  
  </style>
  
</head>
<body>
  <nav>
    <div class="navbar">
      <div class="logo"><a href="index.jsp">CareerStream</a></div>
      <ul class="menu">
        <li><a href="home">About</a></li>
        <li><a href="contact.jsp">Contact</a></li>
        <li><a href="feedback.jsp">Feedback</a></li>
      </ul>
    </div>
  </nav>

</body>
</html>
