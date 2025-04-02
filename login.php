<?php
session_start();
include "DBconnection.php"; 

error_reporting(E_ALL);
ini_set('display_errors', 1);


if (!isset($_POST['email']) || !isset($_POST['password']) || !isset($_POST['role'])) {
    echo "<script>
        alert('Please fill in all the required fields!');
        window.location.href = 'Log-In page.html';
    </script>";
    exit();
}

$email = $_POST['email'];
$password = $_POST['password'];
$role = $_POST['role'];

$table = ($role == "doctor") ? "doctor" : "patient";

$sql = "SELECT id, password FROM $table WHERE emailAddress = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    if (password_verify($password, $row['password'])) { 
        $_SESSION['user_id'] = $row['id'];
        $_SESSION['user_role'] = $role;

        if ($role == "doctor") {
            header("Location: Doctor.php");
        } else {
            header("Location: Patient Homepage.php");
        }
        exit();
    } else {
        echo "<script>
            alert('Invalid password! Please try again');
            window.location.href = 'Log-In page.html';
        </script>";
        exit();
    }
} else {
    echo "<script>
        alert('User not found! Please check your email');
        window.location.href = 'Log-In page.html';
    </script>";
    exit();
}
?>


