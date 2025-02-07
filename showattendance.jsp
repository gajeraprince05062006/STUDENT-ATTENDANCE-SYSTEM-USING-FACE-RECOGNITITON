<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
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
    <style>
        /* Your CSS styles */
        .back-button {
            background-color: rgb(228, 151, 8);
            margin-left : 550px;
            margin-top: 20px; /* Increased distance from the card */
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-button:hover {
            border :2px solid black;
        }


        .card {
            width: 50%;
            padding: 20px;
            margin: 0 auto; /* This will center the card horizontally */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #FF8C00; /* Card background color */
            display: flex;
            align-items: left;
            justify-content: left; /* This will center the content inside the card horizontally */
            margin-bottom: 20px; /* Increased distance from the back button */
        }


        .card label {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px; /* Increase the distance between label and button */
            margin-top: 20px; /* Adjust the distance between label and top */
            border-radius: 5px;
            outline: none;
        }
        .card input[type="date"] {
            width: 610px;
            padding: 10px;
            margin-bottom: 10px; /* Increase the distance between label and button */
            margin-top: 20px; /* Adjust the distance between label and top */
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
        }

        .card button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff; /* Button background color */
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px; /* Adjust the distance between button and other elements */
        }


        .card button:hover {
            background-color: #0056b3; /* Button background color on hover */
        }

        /* Hide container initially */
        .container {
            display: none;
        }

        /* Show container when date is entered */
        .show-container {
            display: block;
        }
    </style>
</head>
<body>
<h2>Students Attendance List</h2>
<div class="card">

    <form id="dateForm" action="" method="get">
        <label for="date"><b>Enter Date :</b></label><br>
        <input type="date" id="dob" name="date" placeholder="Enter Date" required><br>
        <button type="submit">Submit</button>
    </form>
</div>

<%
    try {
        if (request.getParameter("date") != null) {
%>
<div class="container show-container">

    <ul class="responsive-table">
        <li class="table-header">
            <div class="col col-1">Enrollment No.</div>
            <div class="col col-2">Date</div>
            <div class="col col-3">Time</div>
        </li>
        <%
            // JDBC Connection and fetching data based on the entered date
            String jdbcUrl = "jdbc:mysql://localhost:3307/prince";
            String jdbcUsername = "root";
            String jdbcPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

            String query = "SELECT * FROM attendance WHERE date = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, request.getParameter("date"));

            ResultSet resultSet = preparedStatement.executeQuery();

            SimpleDateFormat dateFormatInput = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat dateFormatOutput = new SimpleDateFormat("dd/MM/yyyy");

            while (resultSet.next()) {
                String date = resultSet.getString("date");
                java.util.Date utilDate = dateFormatInput.parse(date);
                String formattedDate = dateFormatOutput.format(utilDate);
        %>
        <li class="table-row">
            <div class="col col-1" data-label="Full Name With Enrollment No."><%= resultSet.getString("name_enrollment_no") %></div>
            <div class="col col-2" data-label="Date"><%= formattedDate %></div>
            <div class="col col-3" data-label="Time"><%= resultSet.getString("time") %></div>
        </li>
        <%
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        %>
    </ul>
</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<a href="dashboard.jsp" class="back-button">Back to Management</a>

<script>
    // JavaScript to hide/show container based on form submission
    document.getElementById('dateForm').addEventListener('submit', function() {
        document.querySelector('.container').classList.add('show-container');
    });
</script>

</body>
</html>
