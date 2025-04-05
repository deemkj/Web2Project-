<?php

/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHP.php to edit this template
 */


 error_reporting(E_ALL);
ini_set('display_errors', 1);

    
include 'DBconnection.php';


$AppoinementID=$_POST['appId'];
$Pid=$_POST['patient_id'];
$mediIDS=$_POST['medications'];
foreach($mediIDS as $v){
$sql="INSERT INTO prescription (AppointmentID,MedicationID)VALUES('$AppoinementID','$v') ";
mysqli_query($conn,$sql);

}
$sql = "UPDATE appointment SET status = 'Done' WHERE id ='$AppoinementID'"; 

mysqli_query($conn,$sql);

header("Location: Doctor.php");
exit();



?>