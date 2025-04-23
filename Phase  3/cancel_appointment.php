<?php
session_start();
include 'DBconnection.php';


header('Content-Type: application/json');


if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== 'patient') {
    echo json_encode("Session not valid");
    exit();
}


if (isset($_POST['appointment_id'])) {
    $appointment_id = $_POST['appointment_id'];

    
    $sql = "DELETE FROM Appointment WHERE id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $appointment_id);

    if (mysqli_stmt_execute($stmt)) {
        echo json_encode(true); 
    } else {
        echo json_encode("Database error: " . mysqli_error($conn));
    }
} else {
    echo json_encode("No appointment ID received");
}

mysqli_close($conn);
?>
