
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
-->

       <?php
    error_reporting(E_ALL);
ini_set('display_errors', 1);

    
include 'DBconnection.php';
 
                 $DoctorID=$_POST['doctorID'];
                 $Pid=$_GET["PID"];// need to be sent by patient page 
                 $date=$_POST['date'];
                 $time=$_POST['time'];
                 $reason=$_POST['reason'];
                 $status='Pending';
$sql = "INSERT INTO appointment (PatientID, DoctorID, `date`, `time`, reason, status) VALUES ('$Pid', '$DoctorID', '$date', '$time', '$reason', '$status')";
if (mysqli_query($conn, $sql)) {
   
    echo "<script>
                alert('Appointment booked successfully!');
                window.location.href = 'PatientHomePage.php';
              </script>";
    
    exit(); 
} else {
    echo " Error: " . mysqli_error($conn);
}

                 
                 
                 
             
            
            
            ?>
    