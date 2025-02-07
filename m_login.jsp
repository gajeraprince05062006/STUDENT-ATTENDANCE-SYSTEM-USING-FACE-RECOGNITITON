<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management - Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
    <!-- Add the Font Awesome CSS link here -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="screen">
            <div class="screen__content">
                <div class="welcome-text">Welcome Management Team</div>
                <form class="login" id="loginForm" onsubmit="return validateForm()">
                    <div class="login__field">
                        <i class="fas fa-user"></i>
                        <input id="uname" type="text" class="login__input" placeholder="Username">
                    </div>
                    <div class="login__field">
                        <i class="fas fa-lock"></i>
                        <input id="psw" type="password" class="login__input" placeholder="Password">
                    </div>
                    <button type="submit" class="button login__submit">
                        <span class="button__text">Log In Now</span>
                        <i class="button__icon fas fa-chevron-right"></i>
                    </button>
                </form>
            </div>
            <div class="screen__background">
                <span class="screen__background__shape screen__background__shape4"></span>
                <span class="screen__background__shape screen__background__shape3"></span>
                <span class="screen__background__shape screen__background__shape2"></span>
                <span class="screen__background__shape screen__background__shape1"></span>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var username = document.getElementById('uname').value;
            var password = document.getElementById('psw').value;

            // Check credentials
            if (username === 'hod' && password === 'hod@123') {
                // Redirect to management.jsp
                window.location.href = 'management.jsp';
                return false; // Prevent form submission
            } else {
                // Handle invalid credentials (display a message, etc.)
                alert('Invalid credentials. Please try again.');
                return false; // Prevent form submission
            }
        }
    </script>
</body>
</html>
