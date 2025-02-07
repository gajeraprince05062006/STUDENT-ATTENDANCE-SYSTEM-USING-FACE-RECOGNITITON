<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Faculty Details</title>
    <link rel="stylesheet" href="table.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    <style>
        .back-button {
            background-color: rgb(228, 151, 8);
            margin-left: 550px;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-button:hover {
            border: 2px solid black;
        }
    </style>
</head>
<body>

<%
    try {
        // JDBC Connection
        String jdbcUrl = "jdbc:mysql://localhost:3307/prince";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

        // SQL Query
        String query = "SELECT full_name, username FROM faculty";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Display Data in Table
%>
    <div class="container">
        <h2>Faculty Details</h2>
        <ul class="responsive-table">
            <li class="table-header">
                <div class="col col-1">Full Name</div>
                <div class="col col-2">Username</div>
                <div class="col col-3"></div>
                <div class="col col-4"></div>
            </li>
<%
            while (resultSet.next()) {
%>
            <li class="table-row">
                <div class="col col-1" data-label="Full Name"><%= resultSet.getString("full_name") %></div>
                <div class="col col-2" data-label="Username"><%= resultSet.getString("username") %></div>
                <div class="col col-3" data-label="View">
                    <a href="view_faculty.jsp?username=<%= resultSet.getString("username") %>">View</a>
                </div>
                <div class="col col-4" data-label="Update">
                    <a href="update_faculty_details.jsp?username=<%= resultSet.getString("username") %>">Update</a>
                </div>
            </li>
<%
            }
%>
        </ul>
    </div>
<%
        // Close resources
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<a href="management.jsp" class="back-button">Back to Management</a>
</body>
</html>
