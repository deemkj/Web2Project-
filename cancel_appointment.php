<?php
session_start();
include 'DBconnection.php';

// التحقق من أن هناك appointment_id مرسل عبر GET
if (isset($_GET['appointment_id'])) {
    $appointment_id = $_GET['appointment_id'];

    // حذف الموعد من قاعدة البيانات
    $sql = "DELETE FROM Appointment WHERE id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $appointment_id);

    if (mysqli_stmt_execute($stmt)) {
        header("Location: PatientHomepage.php"); // إعادة التوجيه بعد الحذف
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
