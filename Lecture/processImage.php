<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['image'])) {
    $uploadedFile = $_FILES['image']['tmp_name'];
    $destination = "uploads/" . $_FILES['image']['name'];

    // Move the uploaded file to the uploads directory
    if (move_uploaded_file($uploadedFile, $destination)) {
        // Call the Python script
        $command = escapeshellcmd("python process_image.py " . escapeshellarg($destination));
        $output = shell_exec($command);

        if ($output === null) {
            // Log error if shell_exec fails
            error_log("Error: Failed to execute Python script.");
            echo json_encode([
                "success" => false,
                "message" => "Failed to process the image."
            ]);
            exit;
        }

        // Parse the Python script output
        $response = json_decode($output, true);
        if ($response && isset($response['success']) && $response['success']) {
            $editedImagePath = $response['editedImagePath'];
            echo json_encode([
                "success" => true,
                "editedImagePath" => $editedImagePath,
                "html" => "<img src='" . htmlspecialchars($editedImagePath) . "' alt='Processed Image' />"
            ]);
        } else {
            // Log Python script error message
            error_log("Python script error: " . ($response['message'] ?? "Unknown error."));
            echo json_encode([
                "success" => false,
                "message" => $response['message'] ?? "Unknown error occurred."
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Failed to upload the image."
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request."
    ]);
}
?>
