<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";

    String url = "jdbc:mysql://localhost:3307/prince";
    String username = "root";
    String password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            if (connection != null) {
                // Check if the username already exists in the database
                String checkSql = "SELECT * FROM faculty WHERE username = ?";
                try (PreparedStatement checkStatement = connection.prepareStatement(checkSql)) {
                    checkStatement.setString(1, request.getParameter("username"));
                    ResultSet resultSet = checkStatement.executeQuery();

                    if (resultSet.next()) {
                        // If the record exists, update the record
                        String updateSql = "UPDATE faculty SET full_name=?, department=?, contact_no=?, email=?, username=?, password=? WHERE username=?";
                        try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                            updateStatement.setString(1, request.getParameter("fname"));
                            updateStatement.setString(2, request.getParameter("dept"));
                            updateStatement.setLong(3, Long.parseLong(request.getParameter("cno")));
                            updateStatement.setString(4, request.getParameter("email"));
                            updateStatement.setString(5, request.getParameter("username"));
                            updateStatement.setString(6, request.getParameter("password"));
                            updateStatement.setString(7, request.getParameter("username")); // This line was added

                            int rowsAffected = updateStatement.executeUpdate();

                            if (rowsAffected > 0) {
                                message = "Data updated successfully!";
                            } else {
                                message = "Failed to update data.";
                            }
                        }
                    } else {
                        message = "Username does not exist. Use insert operation instead.";
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error: " + e.getMessage();
    }

    // Print the message
    out.println("<h1><center>" + message + "</center></h1>");
    // Use JavaScript to redirect after 3 seconds
    out.println("<script>");
    out.println("setTimeout(function() { window.location.href = 'management.jsp'; }, 1000);");
    out.println("</script>");
%>
