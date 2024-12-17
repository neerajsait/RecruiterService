<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title>About Us</title>
  <link rel="stylesheet" href="./css/about.css" />
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
  background-size: 100% auto;
  background-attachment: fixed;
  background-position: center top;
  background-repeat: no-repeat;
  background-color: transparent;
  backdrop-filter: blur(8px);
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
section {
  display: flex;
  height: 80vh; /* Reduced height to bring it up */
  width: 100%;
  align-items: center;
  justify-content: center;
  color: #96c7e8;
  font-size: 70px;
}
.button a {
  position: fixed;
  bottom: 20px;
  right: 20px;
  color: #fff;
  background: #2980b9;
  padding: 7px 12px;
  font-size: 18px;
  border-radius: 6px;
  box-shadow: rgba(0, 0, 0, 0.15);
}
.about {
  padding: 50px 20px 20px; /* Reduced top padding */
}
.about .container {
  max-width: 800px;
  margin-top: 246px;
  background: #fff;
  padding: 40px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.about h1 {
  font-size: 36px;
  margin-bottom: 20px;
  color: #1d07a9;
}
.about p {
  font-size: 18px;
  line-height: 1.6;
  margin-bottom: 20px;
  color: #333;
}
footer {
padding: 14px 10px; /* Slightly increased padding */
margin-top: 103px; /* Adds space above the footer */
background: #1d07a9;
color: #fff;
text-align: center;
}
footer h2 {
  font-size: 30px;
  margin-bottom: px;
}
footer .details {
  display: flex; /* Flexbox layout */
  justify-content: center; /* Center items horizontally */
  align-items: center;
  font-size: 18px;
  color: #fff;
}
footer .details .item {
  margin: 0 20px; /* Side-by-side alignment */
  display: flex;
  align-items: center;
}
footer .details .item i {
  font-size: 24px;
  margin-right: 10px;
}
footer .details .item a {
  color: #fff;
  text-decoration: none;
}
footer .details .item a:hover {
  text-decoration: underline;
}</style>
</head>
<body>
  <nav>
    <div class="navbar">
      <div class="logo"><a href="index.jsp">CareerStream</a></div>
      <ul class="menu">
        <li><a href="about.jsp">About</a></li>
        <li><a href="contact.jsp">Contact</a></li>
        <li><a href="feedback.jsp">Feedback</a></li>
      </ul>
    </div>
  </nav>

  <section class="about">
    <div class="container">
      <h1>About Us</h1>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent varius sapien et dolor ultricies, nec elementum mi dictum. Curabitur ultrices est et est fermentum, a interdum nisl condimentum. Integer congue, nunc sit amet vehicula consequat, elit felis blandit lacus, sed tincidunt magna metus nec ligula. In egestas, velit vel faucibus fringilla, ex sapien convallis odio, sit amet lacinia dui eros non lorem.</p>
      <p>Quisque in nulla non sapien suscipit rhoncus. Morbi aliquet felis et metus lacinia, ac convallis sapien congue. Nullam varius nunc ut ipsum eleifend, id aliquet justo malesuada. Duis euismod turpis eget enim bibendum, non dictum mauris gravida. Proin auctor orci sed eros efficitur, et euismod erat vehicula. Vestibulum dapibus justo at nisi interdum, eu scelerisque mauris lacinia.</p>
    </div>
  </section>

  
</body>
</html>
