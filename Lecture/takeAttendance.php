


<?php 
error_reporting(0);
include '../Includes/dbcon.php';
include '../Includes/session.php';

function getCourseNames($conn) {
    $sql = "SELECT courseCode,name FROM tblcourse";
    $result = $conn->query($sql);

    $courseNames = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $courseNames[] = $row;
        }
    }

    return $courseNames;
}
function getVenueNames($conn) {
    $sql = "SELECT className FROM tblvenue";
    $result = $conn->query($sql);

    $venueNames = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $venueNames[] = $row;
        }
    }

    return $venueNames;
}
function getUnitNames($conn) {
    $sql = "SELECT unitCode,name FROM tblunit";
    $result = $conn->query($sql);

    $unitNames = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $unitNames[] = $row;
        }
    }

    return $unitNames;
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $attendanceData = json_decode(file_get_contents("php://input"), true);

    if (!empty($attendanceData)) {
        foreach ($attendanceData as $data) {
            $studentID = $data['studentID'];
            $attendanceStatus = $data['attendanceStatus'];
            $course = $data['course'];
            $unit = $data['unit'];
            $date = date("Y-m-d"); 

            $sql = "INSERT INTO tblattendance(studentRegistrationNumber, course, unit, attendanceStatus, dateMarked)  
                    VALUES ('$studentID', '$course', '$unit', '$attendanceStatus', '$date')";
            
            if ($conn->query($sql) === TRUE) {
                $message = " Attendance Recorded Successfully For $course : $unit on $date";
            } else {
                echo "Error inserting attendance data: " . $conn->error . "<br>";
            }
        }
    } else {
        echo "No attendance data received.<br>";
    }
} else {
}


if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'updateAttendance') {
    $course = $_POST['course'];
    $unit = $_POST['unit'];
    $venue = $_POST['venue'];

    // Update attendance to 'Present' for the selected course, unit, and venue
    $sql = "UPDATE tblattendance 
            SET attendanceStatus = 'Present' 
            WHERE course = '$course' AND unit = '$unit' AND venue = '$venue' AND attendanceStatus = 'Absent'";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => $conn->error]);
    }
    exit;
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="../admin/img/logo/attnlg.png" rel="icon">
  <title>lecture Dashboard</title>
  <link rel="stylesheet" href="css/styles.css">
  <script defer src="face-api.min.js"></script>

  <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css" rel="stylesheet">
</head>


<body>

<?php include 'includes/topbar.php';?>
    <section class="main">
        <?php include 'includes/sidebar.php';?>
    <div class="main--content">
    <div id="messageDiv" class="messageDiv"  style="display:none;" > </div>

    <form class="lecture-options" id="selectForm">
    <select required name="course" id="courseSelect"  onChange="updateTable()">
        <option value="" selected>Select Course</option>
        <?php
        $courseNames = getCourseNames($conn);
        foreach ($courseNames as $course) {
            echo '<option value="' . $course["courseCode"] . '">' . $course["name"] . '</option>';
        }
        ?>
    </select>

    <select required name="unit" id="unitSelect" onChange="updateTable()">
        <option value="" selected>Select Unit</option>
        <?php
        $unitNames = getUnitNames($conn);
        foreach ($unitNames as $unit) {
            echo '<option value="' . $unit["unitCode"] . '">' . $unit["name"] . '</option>';
        }
        ?>
    </select>
    
    <select required name="venue" id="venueSelect" onChange="updateTable()">
        <option value="" selected>Select Venue</option>
        <?php
        $venueNames = getVenueNames($conn);
        foreach ($venueNames as $venue) {
            echo '<option value="' . $venue["className"] . '">' . $venue["className"] . '</option>';
        }
        ?>
    </select>
   
    </form>
    <div class="attendance-button">
      <button id="startButton" class="add" >Launch Facial Recognition</button>
      <button id="endButton"class="add" style="display:none">End Attendance Process</button>
      <button id="endAttendance" class="add" >END Attendance Taking</button>
    </div>
   
    <div class="video-container" style="display: none;">
    <video id="video" width="600" height="450" autoplay></video>
    <canvas id="overlay" width="600" height="450"></canvas>
    </div>


    <div class="table-container">

                <div id="studentTableContainer" >
               

                    
                </div>
                
    </div>

</div>
</section>
<script defer src="https://cdn.jsdelivr.net/npm/face-api.js"></script>
<script defer src="https://unpkg.com/face-api.js"></script>

<script>
document.getElementById("startButton").addEventListener("click", async () => {
    // Display video container
    document.querySelector(".video-container").style.display = "block";

    // Load face-api models
    await Promise.all([
        faceapi.nets.tinyFaceDetector.loadFromUri('/models'),
        faceapi.nets.faceLandmark68Net.loadFromUri('/models'),
        faceapi.nets.faceRecognitionNet.loadFromUri('/models'),
        // faceapi.nets.faceExpressionNet.loadFromUri('/models')
    ]);

    // Start the video stream
    const video = document.getElementById("video");
    navigator.mediaDevices
        .getUserMedia({ video: {} })
        .then((stream) => {
            video.srcObject = stream;
        })
        .catch((err) => console.error("Error accessing webcam: ", err));

    // Event listener for video playing
    video.addEventListener("play", () => {
        const canvas = document.getElementById("overlay");
        const displaySize = { width: video.width, height: video.height };
        faceapi.matchDimensions(canvas, displaySize);

        // Run detection on each frame
        setInterval(async () => {
            const detections = await faceapi.detectAllFaces(
                video,
                new faceapi.TinyFaceDetectorOptions()
            ).withFaceLandmarks();

            const resizedDetections = faceapi.resizeResults(detections, displaySize);

            // Clear previous drawings
            canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);

            // Draw bounding boxes
            faceapi.draw.drawDetections(canvas, resizedDetections);

            // Optional: Draw landmarks and expressions
            faceapi.draw.drawFaceLandmarks(canvas, resizedDetections);
            
        }, 100);
    });
});
document.getElementById("endButton").addEventListener("click", () => {
    const video = document.getElementById("video");
    const stream = video.srcObject;

    if (stream) {
        const tracks = stream.getTracks();
        tracks.forEach((track) => track.stop()); // Stop all tracks
    }

    // Hide video container
    document.querySelector(".video-container").style.display = "none";
});
document.getElementById("endAttendance").addEventListener("click", async () => {
    // Send an AJAX request to mark all attendance as 'present'
    const course = document.getElementById("courseSelect").value;
    const unit = document.getElementById("unitSelect").value;
    const venue = document.getElementById("venueSelect").value;

    if (!course || !unit || !venue) {
        alert("Please select all required fields.");
        return;
    }

    // Send the AJAX request to the server
    const response = await fetch('updateAttendance.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ course, unit, venue })
    });

    const data = await response.json();
    if (data.success) {
        alert("Attendance Marked.");
         window.location.href = 'viewattendance.php';
    } else {
        alert("Error updating attendance.");
    }
});

document.getElementById("endAttendance").addEventListener("click", async () => {
    // Get the selected values
    const course = document.getElementById("courseSelect").value;
    const unit = document.getElementById("unitSelect").value;
    const venue = document.getElementById("venueSelect").value;

    if (!course || !unit || !venue) {
        return;
    }

    // Send the AJAX request to the server
    const response = await fetch('takeattendence.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ course, unit, venue, action: 'updateAttendance' })
    });

    const data = await response.json();
    if (data.success) {
        alert("Attendance Marked.");
        // Optionally, reload the table to reflect the new status
        updateTable(); 

        setTimeout(() => {
            window.location.href = 'viewattendance.php';
        }, 10000);// This will reload the table with the updated attendance

    } else {
        alert("Error updating attendance.");
    }
});


document.getElementById("endAttendance").addEventListener("click", async () => {
    // Get the selected values
    const course = document.getElementById("courseSelect").value;
    const unit = document.getElementById("unitSelect").value;
    const venue = document.getElementById("venueSelect").value;

    if (!course || !unit || !venue) {
        
        return;
    }

    // Send the AJAX request to the server
    const response = await fetch('takeattendence.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ course, unit, venue, action: 'updateAttendance' })
    });
});


</script>
   
<script  src="script.js"></script>
<script  src="../admin/javascript/main.js"></script>





</body>
</html>