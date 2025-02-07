<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- Java code for database connectivity and data insertion or update --%>
<%
    String message = "";

    String url = "jdbc:mysql://localhost:3307/prince";
    String username = "root";
    String password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            if (connection != null) {
                // Check if the enrollment number (eno) already exists in the database
                String checkSql = "SELECT * FROM student WHERE enrollment_no = ?";
                try (PreparedStatement checkStatement = connection.prepareStatement(checkSql)) {
                    checkStatement.setLong(1, Long.parseLong(request.getParameter("eno")));
                    ResultSet resultSet = checkStatement.executeQuery();

                    if (resultSet.next()) {
                        // If the record exists, update the record
                        String updateSql = "UPDATE student SET fullname=?, sem=?, branch=?, dob=?, contact_no=?, email=?, address=? WHERE enrollment_no=?";
                        try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                            updateStatement.setString(1, request.getParameter("fname"));
                            updateStatement.setInt(2, Integer.parseInt(request.getParameter("sem")));
                            updateStatement.setString(3, request.getParameter("dept"));
                            updateStatement.setDate(4, Date.valueOf(request.getParameter("dob")));
                            updateStatement.setLong(5, Long.parseLong(request.getParameter("cno")));
                            updateStatement.setString(6, request.getParameter("email"));
                            updateStatement.setString(7, request.getParameter("address"));
                            updateStatement.setLong(8, Long.parseLong(request.getParameter("eno")));

                            int rowsAffected = updateStatement.executeUpdate();

                            if (rowsAffected > 0) {
                                message = "Data updated successfully!";
                            } else {
                                message = "Failed to update data.";
                            }
                        }
                    } else {
                        message = "Enrollment number does not exist. Use insert operation instead.";
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
