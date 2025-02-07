<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="form.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

</head>
<body>
<%
    // Retrieve enrollment number from URL parameter
    String enrollmentNumber = request.getParameter("enrollment");
    
    try {
        // JDBC Connection
        String jdbcUrl = "jdbc:mysql://localhost:3307/prince";
        String jdbcUsername = "root";
        String jdbcPassword = "";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

        // SQL Query
        String query = "SELECT * FROM student WHERE enrollment_no = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, enrollmentNumber);
        ResultSet resultSet = preparedStatement.executeQuery();

        // Display Student Details
        if(resultSet.next()) {
%>
    <div class="container" id="registration-container">
    <form action="update_details_database.jsp" method="post">
        <label for="fname"><b>Full Name:</b></label><br>
        <input type="text" id="fname" name="fname" value="<%= resultSet.getString("fullname") %>" required><br>

        <label for="eno"><b>Enrollment No:</b></label><br>
        <input type="number" id="eno" name="eno" value="<%= resultSet.getString("enrollment_no") %>" readonly><br>
        
        <label for="sem"><b>Semester:</b></label><br>
        <select id="sem" name="sem" required>
            <option value="1" <%= resultSet.getString("sem").equals("1") ? "selected" : "" %>>Semester 1</option>
            <option value="2" <%= resultSet.getString("sem").equals("2") ? "selected" : "" %>>Semester 2</option>
            <option value="3" <%= resultSet.getString("sem").equals("3") ? "selected" : "" %>>Semester 3</option>
            <option value="4" <%= resultSet.getString("sem").equals("4") ? "selected" : "" %>>Semester 4</option>
            <option value="5" <%= resultSet.getString("sem").equals("5") ? "selected" : "" %>>Semester 5</option>
            <option value="6" <%= resultSet.getString("sem").equals("6") ? "selected" : "" %>>Semester 6</option>
        </select><br>

        <label for="dept"><b>Department:</b></label><br>
        <select id="dept" name="dept" required>
            <option value="Computer Science" <%= resultSet.getString("branch").equals("Computer Science") ? "selected" : "" %>>Computer Science</option>
            <option value="Electrical Engineering" <%= resultSet.getString("branch").equals("Electrical Engineering") ? "selected" : "" %>>Electrical Engineering</option>
            <option value="Mechanical Engineering" <%= resultSet.getString("branch").equals("Mechanical Engineering") ? "selected" : "" %>>Mechanical Engineering</option>
            <option value="Civil Engineering" <%= resultSet.getString("branch").equals("Civil Engineering") ? "selected" : "" %>>Civil Engineering</option>
            <option value="Automobile Engineering" <%= resultSet.getString("branch").equals("Automobile Engineering") ? "selected" : "" %>>Automobile Engineering</option>
            <option value="Information and Communication Engineering" <%= resultSet.getString("branch").equals("Information and Communication Engineering") ? "selected" : "" %>> Information and Communication Engineering</option>
        </select><br>

        <label for="dob"><b>Date Of Birth:</b></label><br>
        <input type="date" id="dob" name="dob" value="<%= resultSet.getString("dob") %>" required><br>

        <label for="cno"><b>Contact No:</b></label><br>
        <input type="number" id="cno" name="cno" value="<%= resultSet.getString("contact_no") %>" required><br>

        <label for="email"><b>Email ID:</b></label><br>
        <input type="email" id="email" name="email" value="<%= resultSet.getString("email") %>" required><br>

        <label for="address"><b>Address:</b></label><br>
        <input type="text" id="address" name="address" value="<%= resultSet.getString("address") %>" required><br>

        <!-- Submit button -->
        <button type="submit">Update Details</button>
    </form>
</div>

<%
        } else {
%>
    <div class="container">
        <p>No student found with the enrollment number <%= enrollmentNumber %>.</p>
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
