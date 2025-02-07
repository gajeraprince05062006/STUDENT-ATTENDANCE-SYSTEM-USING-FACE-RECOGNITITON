<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css" />
    <title>View Student Details</title>
    <style>
        body {
            background-color: #f1f1f1; /* Set background color */
            font-family: Arial, sans-serif; /* Set default font */
        }

        .container {
            display: flex;
            align-items: flex-start;
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
    <div class="container">
        <div class="student-details">
            <h1>Student Details</h1>
            <p><strong>Enrollment No.:</strong> <%= resultSet.getString("enrollment_no") %></p>
            <p><strong>Full Name:</strong> <%= resultSet.getString("fullname") %></p>
            <p><strong>Semester:</strong> <%= resultSet.getString("sem") %></p>
            <p><strong>Branch:</strong> <%= resultSet.getString("branch") %></p>
            <p><strong>Date of Birth:</strong> <%= resultSet.getString("dob") %></p>
            <p><strong>Contact No.:</strong> <%= resultSet.getString("contact_no") %></p>
            <p><strong>Email:</strong> <%= resultSet.getString("email") %></p>
            <p><strong>Address:</strong> <%= resultSet.getString("address") %></p>
            <!-- Add more fields as needed -->
        </div>
        <div class="student-image">
            <%-- Assuming the image is stored as binary data in the database --%>
            <% Blob imageBlob = resultSet.getBlob("std_image"); %>
            <% if (imageBlob != null) { %>
                <%-- Convert Blob data to byte array --%>
                <% byte[] imageData = imageBlob.getBytes(1, (int) imageBlob.length()); %>
                <%-- Convert byte array to base64 encoded string --%>
                <% String base64Image = java.util.Base64.getEncoder().encodeToString(imageData); %>
                <%-- Display the image using the base64 encoded string --%>
                <img src="data:image/jpeg;base64, <%= base64Image %>" alt="Student Image">
            <% } else { %>
                <p>No image available</p>
            <% } %>
        </div>
        
    </div>
    <div class="forward-button-container">
        <form action="viewstudentdetails.jsp">
            <button class="forward-button" type="submit">Back</button>
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
