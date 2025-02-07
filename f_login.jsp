<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>

<html>
<head>
    <title>Faculty - Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
    <!-- Add the Font Awesome CSS link here -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="screen">
            <div class="screen__content">
                <div class="welcome-text">Welcome Faculty Member</div>
                <form action="" method="post" class="login">
                    <div class="login__field">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" class="login__input" placeholder="Username">
                    </div>
                    <div class="login__field">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="login__input" placeholder="Password">
                    </div>
                    <button type="submit" class="button login__submit">
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

    <%
        if (request.getMethod().equals("POST")) {
            String enteredUsername = request.getParameter("username");
            String enteredPassword = request.getParameter("password");

            String url = "jdbc:mysql://localhost:3307/prince";
            String dbUsername = "root";
            String dbPassword = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);
                if(connection != null && enteredUsername != null ){
                	
                }

                String query = "SELECT * FROM faculty WHERE username=? AND password=?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, enteredUsername);
                preparedStatement.setString(2, enteredPassword);

                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    // Login successful, redirect to dashboard_faculty.jsp
                    response.sendRedirect("dashboard_faculty.jsp");
                } else {
                    // Invalid credentials, show an error message
                    out.println("Invalid credentials. Please try again.");
                }

                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
