<?php
session_start();
include "DBconnection.php";

// Check if the user is a doctor
if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== "doctor") {
    echo "false";
    exit();
}

// Check for POST and appointment ID
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['id'])) {
    $appointmentID = intval($_POST['id']);
    $sql = "UPDATE appointment SET status='Confirmed' WHERE id='$appointmentID'";

    if (mysqli_query($conn, $sql)) {
        echo "true";
    } else {
        echo "false";
    }
} else {
    echo "false";
}
?>
