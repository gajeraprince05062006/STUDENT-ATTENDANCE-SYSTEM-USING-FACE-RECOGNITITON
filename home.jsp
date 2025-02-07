<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Home</title>
  <link rel="stylesheet" href="style.css" />
  <!-- Font Awesome Cdn Link -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
  <script>
        function redirectToPage(role) {
            if (role === 'student') {
                window.location.href = 's_login.jsp';
            } else if (role === 'faculty') {
                window.location.href = 'f_login.jsp';
            } else if (role === 'management team') {
                window.location.href = 'm_login.jsp';
            }
        }

    </script>
</head>
<body>
  <header>
    <div class="container">
      <jsp:include page="menubar.jsp" />
  </header>

  <section class="home_section">
    <div class="overlay">
      <div class="container">
        <div class="home">
          <h1><span>Dr.S & S.S</span> Ghandhy <br>College <span>Of</span> <br><span>Engineering &</span> Technology</h1>
          <div class="home_buttons">
            <button class="btn1">Explore More</button>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="services">
    <div class="container">
      <div class="services_boxes">
        <div class="box" onclick="redirectToPage('student')">
          <i class="fa-solid fa-user"></i>
          <h4>Student</h4>
          
        </div>

        <div class="box" onclick="redirectToPage('faculty')">
         <i class="fa-solid fa-chalkboard-user"></i>
          <h4>Faculty</h4>
          
        </div>

        <div class="box" onclick="redirectToPage('management team')">
          <i class="fa-solid fa-people-roof"></i>
          <h4>Management Team</h4>
          
        </div>
      </div>
  </div>
  </section>

</body>
</html>
</span>