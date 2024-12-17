<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title>Contact Us</title>
  <link rel="stylesheet" href="./css/contact.css" />
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
    .contact {
      padding: 80px 20px 20px;
    }
    .contact .container {
      max-width: 800px;
      margin: 0 auto;
      background: #fff;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-top: 186px;
    }
    .contact h1 {
      font-size: 36px;
      margin-bottom: 20px;
      color: #1d07a9;
    }
    .contact p {
      font-size: 18px;
      line-height: 1.6;
      margin-bottom: 20px;
      color: #333;
    }
    .contact .details {
      font-size: 18px;
      color: #333;
    }
    
    .contact .details .item {
      margin-bottom: 15px;
      display: flex;
      align-items: center;
    }
    .contact .details .item i {
      font-size: 24px;
      margin-right: 15px;
      color: #1d07a9;
    }
    .contact .details .item a {
      color: #333;
      text-decoration: none;
    }
    .contact .details .item a:hover {
      text-decoration: underline;
    }
  </style>
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

  <section class="contact">
    <div class="container">
      <h1>Contact Us</h1>
      <p>If you have any questions or need further information, please feel free to reach out to us through the following contact details:</p>
      <div class="details">
        <div class="item">
          <i class="fas fa-envelope"></i>
          <a href="mailto:info@example.com">info@example.com</a>
        </div>
        <div class="item">
          <i class="fas fa-phone"></i>
          <a href="tel:+1234567890">+1 234 567 890</a>
        </div>
        <div class="item">
          <i class="fab fa-instagram"></i>
          <a href="https://instagram.com/yourprofile" target="_blank">Instagram</a>
        </div>
        <div class="item">
          <i class="fab fa-telegram"></i>
          <a href="https://t.me/yourprofile" target="_blank">Telegram</a>
        </div>
      </div>
    </div>
  </section>
</body>
</html>
