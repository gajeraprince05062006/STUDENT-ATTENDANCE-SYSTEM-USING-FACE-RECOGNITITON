<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- Java code for database connectivity and data insertion --%>
<%
    String message = "";

    String url = "jdbc:mysql://localhost:3307/prince";
    String username = "root";
    String password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            if (connection != null) {
                String sql = "INSERT INTO faculty (full_name, department, contact_no, email, username, password) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    // Set parameters based on the form data
                    preparedStatement.setString(1, request.getParameter("fname"));
                    preparedStatement.setString(2, request.getParameter("dept"));
                    preparedStatement.setLong(3, Long.parseLong(request.getParameter("cno")));
                    preparedStatement.setString(4, request.getParameter("email"));
                    preparedStatement.setString(5, request.getParameter("username"));
                    preparedStatement.setString(6, request.getParameter("password"));
                    

                    // Execute the SQL statement
                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
                        message = "Data inserted successfully!";
                        // Print the message
                        out.println("<h1><center>" + message + "</center></h1>");
                        // Use JavaScript to redirect after 3 seconds
                        out.println("<script>");
                        out.println("setTimeout(function() { window.location.href = 'management.jsp'; }, 1000);");
                        out.println("</script>");
                    } else {
                        message = "Failed to insert data.";
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error: " + e.getMessage();
        // Print the error message
        out.println("<p>" + message + "</p>");
    }
%>
