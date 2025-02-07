<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Faculty Details</title>
    <link rel="stylesheet" href="form.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    <style>
        
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            background-color: #f8f8f8;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
        }

        
    </style>
</head>
<body>
<%
    // Retrieve username from URL parameter
    String username = request.getParameter("username");
    
    try {
        // JDBC Connection
        String jdbcUrl = "jdbc:mysql://localhost:3307/prince";
        String jdbcUsername = "root";
        String jdbcPassword = "";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

        // SQL Query
        String query = "SELECT * FROM faculty WHERE username = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();

        // Display Faculty Details
        if(resultSet.next()) {
%>
    <div class="container" id="registration-container">
        <form action="update_faculty_details_database.jsp" method="post">
            <label for="fname"><b>Full Name:</b></label><br>
            <input type="text" id="fname" name="fname" value="<%= resultSet.getString("full_name") %>" required><br>

            <label for="dept"><b>Department:</b></label><br>
            <select id="dept" name="dept" required>
                <option value="Computer Science" <%= resultSet.getString("department").equals("Computer Science") ? "selected" : "" %>>Computer Science</option>
                <option value="Electrical Engineering" <%= resultSet.getString("department").equals("Electrical Engineering") ? "selected" : "" %>>Electrical Engineering</option>
                <option value="Mechanical Engineering" <%= resultSet.getString("department").equals("Mechanical Engineering") ? "selected" : "" %>>Mechanical Engineering</option>
                <option value="Civil Engineering" <%= resultSet.getString("department").equals("Civil Engineering") ? "selected" : "" %>>Civil Engineering</option>
                <option value="Automobile Engineering" <%= resultSet.getString("department").equals("Automobile Engineering") ? "selected" : "" %>>Automobile Engineering</option>
                <option value="Information and Communication Engineering" <%= resultSet.getString("department").equals("Information and Communication Engineering") ? "selected" : "" %>>Information and Communication Engineering</option>
            </select><br>

            <label for="cno"><b>Contact No:</b></label><br>
            <input type="text" id="cno" name="cno" value="<%= resultSet.getString("contact_no") %>" required><br>

            <label for="email"><b>Email ID:</b></label><br>
            <input type="email" id="email" name="email" value="<%= resultSet.getString("email") %>" required><br>

            <label for="username"><b>User name:</b></label><br>
            <input type="text" id="username" name="username" value="<%= resultSet.getString("username") %>" readonly><br>
                
            <label for="password"><b>Password:</b></label><br>
            <input type="password" id="password" name="password" value="<%= resultSet.getString("password") %>" required><br>
                
            <!-- Submit button -->
            <button type="submit">Update Details</button>
        </form>
    </div>
<%
        } else {
%>
    <div class="container">
        <p>No faculty found with the username <%= username %>.</p>
    </div>
<%
        }   
        // Close resources
        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
