<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css" />
    <title>View Faculty Details</title>
    <style>
        body {
            background-color: #f1f1f1; /* Set background color */
            font-family: Arial, sans-serif; /* Set default font */
        }

        .container {
            display: flex;
            align-items: center;
            background-color: #fff; /* Set white background for container */
            padding: 20px; /* Add padding to the container */
            margin-top: 100px;
            border-radius: 10px; /* Add rounded corners to the container */
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Add shadow effect to the container */
        }
        

        .student-details {
            flex: 1;
            margin-top : 20px;
            margin-right: 50px; /* Add spacing between student details and image */
            font-size:20px;
        }

        .student-details h1 {
            text-align: center; /* Center-align the text within student details */
        }

        .student-image img {
            width: 350px;
            height: 300px;
            border-radius: 10px; /* Make image rounded square */
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Add shadow effect to the image */
        }

        .student-image {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 50px;
        }

        .forward-button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .forward-button {
            background-color: orange; /* Set background color */
            color: white; /* Set text color */
            padding: 10px 20px; /* Add padding */
            border: none; /* Remove border */
            border-radius: 5px; /* Add rounded corners */
            cursor: pointer; /* Add cursor pointer on hover */
            font-size: 16px; /* Set font size */
        }

        .forward-button:hover {
            background-color: darkorange; /* Change background color on hover */
        }
    </style>
</head>
<body>
<%
    // Retrieve enrollment number from URL parameter
    String Username = request.getParameter("username");
    
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
        preparedStatement.setString(1, Username);
        ResultSet resultSet = preparedStatement.executeQuery();

        // Display Student Details
        if(resultSet.next()) {
%>
    <div class="container">
        <div class="student-details">
            <h1>Faculty Details</h1>
            <p><strong>Full Name:</strong> <%= resultSet.getString("full_name") %></p>
            <p><strong>Department:</strong> <%= resultSet.getString("department") %></p>
            <p><strong>Contact No:</strong> <%= resultSet.getString("contact_no") %></p>
            <p><strong>Email:</strong> <%= resultSet.getString("email") %></p>
            <p><strong>Username:</strong> <%= resultSet.getString("username") %></p>
            <p><strong>Password:</strong> <%= resultSet.getString("password") %></p>
            
        </div>
        
        
    </div>
    <div class="forward-button-container">
        <form action="viewfacultydetails.jsp">
            <button class="forward-button" type="submit">Back</button>
        </form>
    </div>
<%
        } else {
%>
    <div class="container">
        <p>No faculty found with the  <%= Username %>.</p>
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
