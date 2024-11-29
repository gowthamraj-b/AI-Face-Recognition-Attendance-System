<?php
include '../Includes/dbcon.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Decode the JSON data from the request
    $data = json_decode(file_get_contents('php://input'), true);

    $course = $data['course'];
    $unit = $data['unit'];
    $venue = $data['venue'];
    $date = date("Y-m-d");

    // Update all attendance records for the specified course, unit, and venue
    $sql = "UPDATE tblattendance 
            SET attendanceStatus = 'present' 
            WHERE course = '$course' AND unit = '$unit' AND dateMarked = '$date'";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "message" => $conn->error]);
    }
}
?>

