<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = "localhost:8889"; 
$username = "root";
$password = "root";
$dbname = "ebsardb";

$conn = mysqli_connect($host, $username, $password, $dbname);
$error = mysqli_connect_error();

if ($error != null) {
    die("Connection failed: " . $error);
}

?>
