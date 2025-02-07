<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.Base64, java.nio.file.*, java.nio.charset.StandardCharsets" %>

<%
    String message = "";
    String redirectURL = "management.jsp";

    String url = "jdbc:mysql://localhost:3307/prince";
    String username = "root";
    String password = "";
    String fullname = request.getParameter("fname");
    long enrollmentNumber = Long.parseLong(request.getParameter("eno"));
    int semester = Integer.parseInt(request.getParameter("sem"));
    String branch = request.getParameter("dept");
    Date dob = Date.valueOf(request.getParameter("dob"));
    long contactNumber = Long.parseLong(request.getParameter("cno"));
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    long pass = 0; // Default value for password, you may change this according to your requirements

    // Handle the "password" parameter
    String passwordParam = request.getParameter("password");
    if (passwordParam != null && !passwordParam.isEmpty()) {
        pass = Long.parseLong(passwordParam);
    } else {
        // Handle the case where password parameter is missing or empty
        // You may choose to throw an exception, set a default value, or handle it in another appropriate way
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            if (connection != null && fullname != null) {
                // Get student details from the request

                // Get the image data from the request
                String imageData = request.getParameter("captured-image");

                // Ensure image data is not null or empty
                if (imageData != null && !imageData.isEmpty()) {
                    // Remove MIME type prefix if present
                    imageData = imageData.replaceFirst("data:image\\/[^;]+;base64,", "");

                    // Convert Base64 string to byte array
                    byte[] imageBytes = Base64.getDecoder().decode(imageData);

                    // Increase max_allowed_packet size for large data
                    Statement stmt = connection.createStatement();
                    stmt.executeUpdate("SET GLOBAL max_allowed_packet=33554432"); // 32MB

                    // Insert the student details and image into the student table
                    String sql = "INSERT INTO student (enrollment_no, fullname, sem, branch, dob, contact_no, email, address, std_image,password) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                        // Set parameters based on the form data
                        preparedStatement.setLong(1, enrollmentNumber);
                        preparedStatement.setString(2, fullname);
                        preparedStatement.setInt(3, semester);
                        preparedStatement.setString(4, branch);
                        preparedStatement.setDate(5, dob);
                        preparedStatement.setLong(6, contactNumber);
                        preparedStatement.setString(7, email);
                        preparedStatement.setString(8, address);
                        preparedStatement.setBytes(9, imageBytes);
                        preparedStatement.setLong(10, pass);

                        // Execute the SQL statement
                        int rowsAffected = preparedStatement.executeUpdate();

                        if (rowsAffected > 0) {
                            // Data inserted successfully into the database
                            message = "Data inserted successfully!";
                        } else {
                            message = "Failed to insert data.";
                        }
                    }
                } else {
                    message = "Image data is missing.";
                }
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        message = "Error: " + e.getMessage();
        //redirectURL = "error.jsp"; // Redirect to an error page on failure
    }

    // Print the message
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Result</title>
    <!-- Add any additional CSS styles or meta tags here -->
</head>
<body>
    <div>
        <h1><center><%= message %></center></h1>
    </div>

    <!-- Use JavaScript to redirect after 3 seconds -->
    <script>
        setTimeout(function() { window.location.href = '<%= redirectURL %>'; }, 1000);
    </script>
</body>
</html>
