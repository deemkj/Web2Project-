<?php
session_start();
include "DBconnection.php";

if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== "doctor") {
    header("Location:../pages/Ebsar Homepage.html");
    exit();
}

$appointmentID = $_GET['id'];
$sql = "UPDATE appointment SET status='Confirmed' WHERE id='$appointmentID'";
mysqli_query($conn, $sql);

header("Location:Doctor.php");
exit();
?>

