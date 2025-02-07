<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student - Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
    <!-- Add the Font Awesome CSS link here -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<%
    if (request.getMethod().equals("POST")) {
        String enrollmentNo = request.getParameter("enrollmentNo");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/prince", "root", "");
            stmt = conn.prepareStatement("SELECT * FROM student WHERE enrollment_no = ? AND password = ?");
            stmt.setString(1, enrollmentNo);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // If the student exists, redirect to studentdetails.jsp
                response.sendRedirect("studentdetails.jsp");
                return; // Exit the script after redirection
            } else {
                // If the student doesn't exist, display an error message
                out.println("<div class='container'><div class='error'>Invalid Enrollment No or Password</div></div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<div class="container">
    <div class="screen">
        <div class="screen__content">
            <div class="welcome-text">Welcome Students</div>
            <form class="login" action="studentdetails.jsp" method="post">
                <div class="login__field">
                    <i class="fas fa-user"></i>
                    <input type="number" class="login__input" placeholder="Enrollment No" name="enrollmentNo">
                </div>
                <div class="login__field">
                    <i class="fas fa-lock"></i>
                    <input type="password" class="login__input" placeholder="Password" name="password">
                </div>
                <button class="button login__submit">
                    <span class="button__text">Log In Now</span>
                    <i class="button__icon fas fa-chevron-right"></i>
                </button>
            </form>
        </div>
        <div class="screen__background">
            <span class="screen__background__shape screen__background__shape4"></span>
            <span class="screen__background__shape screen__background__shape3"></span>
            <span class="screen__background__shape screen__background__shape2"></span>
            <span class="screen__background__shape screen__background__shape1"></span>
        </div>
    </div>
</div>
</body>
</html>
