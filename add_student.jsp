<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
	<link rel="stylesheet" href="form.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
  
</head>
<body>
    <div class="container" id="registration-container">
        <center><h1>Registration Form</h1></center>
        <form action="AddStudent.jsp" method="post">
            <label for="fname"><b>Full Name:</b></label><br>
            <input type="text" id="fname" name="fname" placeholder="Enter Full Name" required><br>

            <label for="eno"><b>Enrollment No:</b></label><br>
            <input type="number" id="eno" name="eno" placeholder="Enter Enrollment No" required><br>
            
            <label for="sem"><b>Semester:</b></label><br>
            <select id="sem" name="sem" required>
                <option value="1">Semester 1</option>
                <option value="2">Semester 2</option>
                <option value="3">Semester 3</option>
                <option value="4">Semester 4</option>
                <option value="5">Semester 5</option>
                <option value="6">Semester 6</option>
            </select><br>

            <label for="dept"><b>Department:</b></label><br>
            <select id="dept" name="dept" required>
                <option value="Computer Science">Computer Science</option>
                <option value="Electrical Engineering">Electrical Engineering</option>
                <option value="Mechanical Engineering">Mechanical Engineering</option>
                <option value="Civil Engineering">Civil Engineering</option>
                <option value="Automobile Engineering.">Automobile Engineering.</option>
                <option value="Information and Communication Engineering."> Information and Communication Engineering.</option>
            </select><br>

            <label for="dob"><b>Date Of Birth:</b></label><br>
            <input type="date" id="dob" name="dob" placeholder="Enter Date Of Birth" required><br>

            <label for="cno"><b>Contact No:</b></label><br>
            <input type="number" id="cno" name="cno" placeholder="Enter Contact No" required><br>

            <label for="email"><b>Email ID:</b></label><br>
            <input type="email" id="email" name="email" placeholder="Enter Email id" required><br>

            <label for="address"><b>Address:</b></label><br>
            <input type="text" id="address" name="address" placeholder="Enter Address" required><br>
            
            <label for="password"><b>Password:</b></label><br>
            <input type="number" id="password" name="password" placeholder="Enter Password" required><br>

            <!-- New button for capturing image -->
            <button id="capture-btn" type="button" onclick="openCamera()">Capture Image</button>

            <!-- Hidden input to store captured image data -->
            <input type="hidden" id="captured-image" name="captured-image" required>

            <!-- Display captured image -->
            <img id="captured-image-preview" style="display: none; width: 100%; margin-top: 10px;" alt="Captured Image">

            <!-- Submit button -->
            <button type="submit">Add Image</button>
        </form>
    </div>

    <!-- Container for camera screen -->
    <div id="camera-container">
        <video id="camera-feed" autoplay playsinline></video>
        <button id="take-image-btn" onclick="captureImage()">Take Image</button>
    </div>

    <!-- JavaScript for capturing image from camera -->
    <script>
        function openCamera() {
            document.getElementById('registration-container').style.display = 'none';
            document.getElementById('camera-container').style.display = 'block';

            navigator.mediaDevices.getUserMedia({ video: true })
                .then(function (stream) {
                    var video = document.getElementById('camera-feed');
                    video.srcObject = stream;
                    video.play();
                })
                .catch(function (error) {
                    console.error('Error accessing camera: ', error);
                });
        }

        function captureImage() {
            var video = document.getElementById('camera-feed');
            var canvas = document.createElement('canvas');
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

            // Get base64 data URL of the captured image
            var dataURL = canvas.toDataURL('image/png');
            
            // Set the captured image data to the hidden input
            document.getElementById('captured-image').value = dataURL;

            // Display the captured image preview
            var capturedImagePreview = document.getElementById('captured-image-preview');
            capturedImagePreview.src = dataURL;
            capturedImagePreview.style.display = 'block';

            // Stop the video stream
            var tracks = video.srcObject.getTracks();
            tracks.forEach(track => track.stop());

            // Hide the camera screen and show the registration form
            document.getElementById('camera-container').style.display = 'none';
            document.getElementById('registration-container').style.display = 'block';
        }
    </script>
</body>
</html>
