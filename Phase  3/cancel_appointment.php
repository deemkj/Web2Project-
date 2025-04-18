<?php

/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHP.php to edit this template
 */


session_start();
include 'DBconnection.php';

if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== 'patient') {
    header("Location: ../pages/Log-In page.html"); 
    exit();
}
if (isset($_GET['appointment_id'])) {
    $appointment_id = $_GET['appointment_id'];


    $sql = "DELETE FROM Appointment WHERE id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $appointment_id);

    if (mysqli_stmt_execute($stmt)) {
        header("Location: Patient Homepage.php"); 
        exit();
    } else {
        die("Error canceling appointment: " . mysqli_error($conn));
    }
} else {
    die("Invalid request.");
}

// close connection to ebsardb
mysqli_close($conn);
?>
