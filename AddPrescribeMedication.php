<?php
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
