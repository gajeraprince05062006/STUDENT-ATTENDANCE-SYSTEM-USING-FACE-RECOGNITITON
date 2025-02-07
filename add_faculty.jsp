<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Registration Form</title>
    <link rel="stylesheet" href="form.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
  
    <style>
        
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            background-color: #f8f8f8;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
        }

        
    </style>
</head>
<body>
    <div class="container">
        <center><h1>Faculty Registration Form</h1></center>
        <form action="AddFaculty.jsp" method="post">
            <label for="fname"><b>Full Name:</b></label><br>
            <input type="text" id="fname" name="fname" placeholder="Enter Full Name" required><br>
 

            <label for="dept"><b>Department:</b></label><br>
            <select id="dept" name="dept" required>
                <option value="Computer Science">Computer Science</option>
                <option value="Electrical Engineering">Electrical Engineering</option>
                <option value="Mechanical Engineering">Mechanical Engineering</option>
                <option value="Civil Engineering">Civil Engineering</option>
                <option value="Automobile Engineering.">Automobile Engineering.</option>
                <option value="Information and Communication Engineering."> Information and Communication Engineering.</option>
            </select><br>

            <label for="cno"><b>Contact No:</b></label><br>
            <input type="number" id="cno" name="cno" placeholder="Enter Contact No" required><br>

            <label for="email"><b>Email ID:</b></label><br>
            <input type="email" id="email" name="email" placeholder="Enter Email id" required><br>

			<label for="username"><b>User name:</b></label><br>
            <input type="text" id="username" name="username" placeholder="Enter User name" required><br>
            
            <label for="password"><b>Password:</b></label><br>
            <input type="password" id="password" name="password" placeholder="Enter Password" required><br>
            
			
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
