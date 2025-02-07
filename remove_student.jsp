<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Details</title>
    <link rel="stylesheet" href="table.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    <script>
        function showMessage() {
            var message = document.getElementById('message');
            message.style.display = 'block';
            setTimeout(function() {
                message.style.display = 'none';
            }, 3000); // Adjust the time (in milliseconds) as needed
        }
    </script>
    <style>
        #message {
            display: none;
            margin: 10px 0;
            padding: 10px;
            background-color: #dff0d8;
            border: 1px solid #c8e0c8;
            border-radius: 4px;
            color: #3c763d;
            font-weight: bold;
        }

        .back-button {
            background-color: rgb(228, 151, 8);
            margin-left : 550px;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-button:hover {
            border :2px solid black;
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

        // Check if a delete request is made
        String enrollmentToDelete = request.getParameter("enrollment");
        if (enrollmentToDelete != null) {
            // Perform deletion
            String deleteQuery = "DELETE FROM student WHERE enrollment_no = ?";
            PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
            deleteStatement.setString(1, enrollmentToDelete);
            int rowsAffected = deleteStatement.executeUpdate();
            out.println("<p id='message'>" + rowsAffected + " record(s) deleted successfully.</p>");
            deleteStatement.close();
%>
            <script>
                showMessage();
            </script>
<%
        }

        // SQL Query
        String query = "SELECT enrollment_no, fullname FROM student";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Display Data in Table
%>
    <div class="container">
        <h2>Students Details</h2>
        <ul class="responsive-table">
            <li class="table-header">
                <div class="col col-1">Enrollment No.</div>
                <div class="col col-2">Full Name</div>
                <div class="col col-3"></div>
            </li>
<%
            while (resultSet.next()) {
%>
            <li class="table-row">
                <div class="col col-1" data-label="Enrollment No."><%= resultSet.getString("enrollment_no") %></div>
                <div class="col col-2" data-label="Full Name"><%= resultSet.getString("fullname") %></div>
                <div class="col col-3" data-label="View">
                    <a href="?enrollment=<%= resultSet.getString("enrollment_no") %>">Delete Student</a>
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
