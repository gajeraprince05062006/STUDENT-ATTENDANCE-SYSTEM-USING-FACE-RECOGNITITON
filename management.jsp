<!DOCTYPE html>
<html>
<head>
    <title>Management portal</title>
    <link rel="stylesheet" href="style.css" />
  <!-- Font Awesome Cdn Link -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
  

    <script>
        function redirectToPage(role) {
            if (role === 'add student') {
                window.location.href = 'add_student.jsp';
            } else if (role === 'view student details') {
                window.location.href = 'viewstudentdetails.jsp';
            } else if (role === 'remove student') {
                window.location.href = 'remove_student.jsp';
            }
        }

        function redirectToPageSecondRow(action) {
            if (action === 'add faculty') {
                window.location.href = 'add_faculty.jsp'; // Change the file name as needed
            } else if (action === 'view faculty details') {
                window.location.href = 'viewfacultydetails.jsp'; // Change the file name as needed
            } else if (action === 'remove faculty') {
                window.location.href = 'remove_faculty.jsp'; // Change the file name as needed
            }
        }
        function redirectToJSP() {
            window.location.href = "dashboard_faculty.jsp";
        }
        function redirectTophp() {
            window.location.href = "send_email.html";
        }

    </script>
</head>
<body>
<header>
    <div class="container">
      <jsp:include page="menubar.jsp" />
  </header>
<section class="services">

    <h1><center>Management Portal</center></h1>

    <div class="services_boxes">
        <div class="box" onclick="redirectToPage('add student')">
        <i class="fa-solid fa-user-plus"></i>
            <h2>Add Student</h2>
        </div>
        <div class="box" onclick="redirectToPage('view student details')">
        <i class="fa-solid fa-eye"></i>
            <h2>Student Details</h2>
        </div>
        <div class="box" onclick="redirectToPage('remove student')">
        <i class="fa-solid fa-user-xmark"></i>
            <h2>Remove Student</h2>
        </div>
    </div>

    <!-- Second row of buttons -->
    <div class="services_boxes">
        <div class="box" onclick="redirectToPageSecondRow('add faculty')">
        <i class="fa-solid fa-person-circle-plus"></i>
            <h2>Add Faculty</h2>
        </div>
        <div class="box" onclick="redirectToPageSecondRow('view faculty details')">
        <i class="fa-solid fa-street-view"></i>
            <h2>Faculty Details</h2>
        </div>
        <div class="box" onclick="redirectToPageSecondRow('remove faculty')">
        <i class="fa-solid fa-user-slash"></i>
            <h2>Remove Faculty</h2>
        </div>
    </div>
    
    <div class="services_boxes">
        <div class="box" onclick="redirectToJSP()">
        <i class="fa-solid fa-clipboard-user"></i>
            <h2>View Attendance</h2>
        </div>
        <div class="box" onclick="redirectTophp()">
        <i class="fa-solid fa-square-envelope"></i>
            <h2>Send Mail</h2>
        </div>
    </div>
   </section>

</body>
</html>
