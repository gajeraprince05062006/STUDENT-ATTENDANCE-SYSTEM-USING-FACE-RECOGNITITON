<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Employee Registration</title>
  <link rel="stylesheet" href="form.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
</head>
<body> 

  <div class="main"> 
    <h1>Registration</h1> 
    <form id="registration-form" action="addemployee.jsp" method="post" enctype="multipart/form-data"> 
      <label for="id">Employee Id:</label> 
      <input type="number" id="id" name="id" placeholder="Enter Employee Id" required> 
      
      <label for="first">First Name:</label> 
      <input type="text" id="first" name="first" placeholder="Enter your first name" required> 

      <label for="last">Last Name:</label> 
      <input type="text" id="last" name="last" placeholder="Enter your last name" required> 

      <label for="email">Email:</label> 
      <input type="email" id="email" name="email" placeholder="Enter your email" required> 

      <label for="dob">Date of Birth:</label> 
      <input type="date" id="dob" name="dob" placeholder="Enter your DOB" required> 

      <label for="password">Password:</label> 
      <input type="password" id="password" name="password" placeholder="Enter your password"
             pattern="^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])\S{8,}$" required 
             title="Password must contain at least one number, one alphabet, one symbol, and be at least 8 characters long"> 

      <label for="repassword">Re-type Password:</label> 
      <input type="password" id="repassword" name="repassword" placeholder="Re-Enter your password" required> 
      <span id="pass"></span> 

      <label for="department">Department:</label> 
      <select id="department" name="department" required> 
        <option value="coding">Coding</option> 
        <option value="testing">Testing</option> 
        <option value="design">Design</option> 
      </select> 
      
      <label for="address">Address:</label> 
      <input type="text" id="address" name="address" placeholder="Enter your Address" required maxlength="500">
      
      <label for="city">City:</label> 
      <input type="text" id="city" name="city" placeholder="Enter your city" required>
      
      <label for="country">Country:</label> 
      <input type="text" id="country" name="country" placeholder="Enter your country" required>  
      
      <label for="mobile">Contact:</label> 
      <input type="text" id="mobile" name="mobile" placeholder="Enter your Mobile Number" required maxlength="10"> 

      <label for="gender">Gender:</label> 
      <select id="gender" name="gender" required> 
        <option value="male">Male</option> 
        <option value="female">Female</option> 
        <option value="other">Other</option> 
      </select> 

      <!-- New button for capturing image -->
      <button id="capture-btn" type="button" onclick="openCamera()">Capture Image</button>

      <!-- Hidden input to store captured image data -->
      <input type="hidden" id="captured-image" name="captured-image" required>

      <!-- Display captured image -->
      <img id="captured-image-preview" style="display: none; width: 100%; margin-top: 10px;" alt="Captured Image">
      
      <div class="wrap"> 
        <button type="submit">Submit</button> 
      </div> 
    </form> 
  </div>
  
  <!-- Container for camera screen -->
  <div id="camera-container" style="display: none;">
    <video id="camera-feed" autoplay playsinline></video>
    <button id="take-image-btn" onclick="captureImage()">Take Image</button>
  </div>

  <!-- JavaScript for capturing image from camera -->
  <script>
    function openCamera() {
      document.getElementById('camera-container').style.display = 'block';
      document.getElementById('registration-form').style.display = 'none'; // Hide the form
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
      document.getElementById('registration-form').style.display = 'block'; // Show the form again
    }
  </script> 
</body> 
</html>
