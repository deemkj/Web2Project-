<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
-->
<?php 
    error_reporting(E_ALL);
ini_set('display_errors', 1);

    
include 'DBconnection.php';

    ?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Booking</title>
    <link rel="stylesheet" href="StyleSheet.css">
</head>
<body>
    <header>
        <div class="logo"><a href="Ebsar Homepage.php"><img src="images/2logo.png" alt="Ebsar Logo"></a>
        </div>

    </header>
    <div class="App-background"></div>
    <main class="appointment-section">
        <div class="content">
            <h1>Book Your Appointment</h1>
            <p>Select the details for your visit and schedule an appointment with ease.</p>
        </div>
        <div class="App-forms">
            <!-- First Form -->
            
            <form class="form form-specialty"   action='AppointmentBooking.php' method='post'>  <!--  Form -->
             <input type='hidden' value='selectSpecialty' name='requestType'>

                <h2>Select Specialty</h2>
                <?php
                $sql="SELECT * FROM speciality";
                $result=mysqli_query($conn,$sql);
          echo '<select name="speciality" id="specialty" class="dropdown" required>';
           echo' <option value="" disabled selected>Choose a specialty...</option>';

                while($r=mysqli_fetch_assoc($result)){
               echo "<option value='" . $r['speciality'] . "'>" . $r['speciality'] . "</option>";

                }
                echo"</select>";
                echo'<button type="submit" class="bttn">Submit</button>';
                
                        ?>
            </form>

            <!-- Second Form - Booking the Appointment-->
            <form class="form form-details" action='AppointmentBooking.php' method='post' >
                <input type='hidden' value='bookApp' name='requestType'>
                <h2>Appointment Details</h2>
                <select name="doctorID" id="doctor" class="dropdown" required>
                    <option value="" disabled selected>Select a doctor...</option>
                    
                    <?php
                    if($_SERVER['REQUEST_METHOD']=='GET'){
                         $sql="SELECT * FROM doctor";
                        $result=mysqli_query($conn,$sql);
                        while($r=mysqli_fetch_assoc($result)){
$sql2 = "SELECT speciality FROM speciality WHERE id='" . $r['SpecialityID'] . "'";
$result2=mysqli_query($conn,$sql2);
$speResult=mysqli_fetch_assoc($result2);

echo "<option value='" . $r['id'] . "'>" . $r['firstName'] . " " . $r['lastName'] ." -  ".$speResult['speciality']. "</option>";//cannot be hidden!!

                   
                        }   
                    }
                    
                    
                            ?>
                    <?php
             if($_SERVER['REQUEST_METHOD']=='POST' && $_POST['requestType']=='selectSpecialty'){
                        $specialty=$_POST['speciality'];// first we need to bring id of specialty from specialty table
                        
                        
             $sql = "SELECT id FROM speciality WHERE speciality='$specialty'";
                        $result=mysqli_query($conn,$sql);
                        $r=mysqli_fetch_assoc($result);
                        $speID=$r['id'];

                       $sql="SELECT * FROM doctor WHERE SpecialityID='$speID'";
                        $result=mysqli_query($conn,$sql);
                        while( $r=mysqli_fetch_assoc($result)){
echo "<option value='" . $r['id'] . "'>" . $r['firstName'] . " " . $r['lastName'] ." -  ".$_POST['speciality']."</option>";//cannot be hidden!!

                        }

                         
                         
                         
                         
                         
                         
                     }
                     ?>
                   
                </select>
                <input type="date" name="date" id="date" class="input" required>
                <input type="time" name="time" id="time" class="input" required>
                <textarea name="reason" id="reason" class="textarea" placeholder="Reason for visit..." required></textarea>
                <button type="submit" class="bttn">Book Appointment</button>
            </form>
            
            
            <?php
             if($_SERVER['REQUEST_METHOD']=='POST' && $_POST['requestType']=='bookApp'){
                 
                 $DoctorID=$_POST['doctorID'];
                 $Pid=$_GET["PatientID"];// need to be sent by patient page 
                 $date=$_POST['date'];
                 $time=$_POST['time'];
                 $reason=$_POST['reason'];
                 $status='Pending';
$sql = "INSERT INTO appointment (PatientID, DoctorID, `date`, `time`, reason, status) VALUES ('$Pid', '$DoctorID', '$date', '$time', '$reason', '$status')";
if (mysqli_query($conn, $sql)) {
   
    echo "<script>
                alert('Appointment booked successfully!');
                window.location.href = 'Patient HomePage.php';
              </script>";
    
    exit(); 
} else {
    echo " Error: " . mysqli_error($conn);
}

                 
                 
                 
             }
            
            
            ?>
        </div>
    </main>

    <footer>
        <div class="footer-left-1">
            <h4>Contact Us</h4>
            <div class="contact-info-1">
                <div class="contact-item-1">
                    <img src="images/phone1.png" alt="Phone Icon">
                    <span class="single-line-1">+996 563821256</span>
                </div>
                <div class="contact-item-1">
                    <img src="images/mail-icon.png" alt="Email Icon">
                    <span class="single-line-1">Ebsar@gmail.com</span>
                </div>
                <div class="contact-item-1">
                    <img src="images/location1.png" alt="Location Icon">
                    <span class="single-line-1">Riyadh, Saudi Arabia</span>
                </div>
            </div>
        </div>
        
        <div class="footer-center-1">
            <a href="Ebsar Homepage.html">
                <img src="images/2logo.png" alt="Logo" class="footer-logo-1 logo-toggle">
            </a>
        </div>
        
        <div class="footer-right-1">
            <p>Social media:</p>
            <div class="social-icons-1">
                <img src="images/facebook1.png" alt="Facebook">
                <img src="images/X1.png" alt="Twitter">
                <img src="images/instagram1.png" alt="Instagram">
            </div>
        </div>
        
        <div class="footer-bottom-1">
            <p>&copy; 2025 Website. All rights reserved.</p>
        </div>
    </footer>
    
   
</body>
</html>