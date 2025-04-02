<!DOCTYPE html>
 <?php 
    error_reporting(E_ALL);
ini_set('display_errors', 1);
include 'DBconnection.php';
    ?>
<html lang="en">
<head>
   
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescribe Medication</title>
    <link rel="stylesheet" href="StyleSheet.css">
    <script src="JS.js"></script>
    
</head>
<body>
    <header>
        
            <div class="logo"><a href="Ebsar Homepage.html"><img src="images/2logo.png" alt="Ebsar Logo"></a>
            </div>    </header>
    <main class="prescribe-section">
        <div class="content">
            <h1>Prescribe Medication</h1>
            <p>Fill in the required information and prescribe medication for your patient.</p>
        </div>

       
        <form class="prescribe-form" id="prescribeForm" action='AddPrescribeMedication.php' method='post'>
                <h2>Patient Details</h2>
                <div id="PformContent"></div>
    <?php   
    
    
    if($_SERVER['REQUEST_METHOD']=='GET'){
   
      $appointmentID=$_GET['appointment_id'];
      $Pid=$_GET['patient_id'];
     $sql="SELECT * FROM Patient WHERE id='$Pid'";
        $result=mysqli_query($conn,$sql);
     
        
        
        
        
    
echo"<div class='patient-info'>";
    
    while($r= mysqli_fetch_assoc($result)){
echo "<label>Name: <input type='text' id='name' readonly value='" . $r['firstName'] . " " . $r['lastName'] . "'></label>";

//to calculate age using DOB
$dob = $r['DOB']; 
$dobObject = new DateTime($dob);
$today = new DateTime();
$age = $today->diff($dobObject)->y;
echo "<label>Age: <input type='number' id='age' value='$age' readonly></label>";

$gender = $r['Gender']; 


$genderText = ($gender === "F") ? "Female" : "Male";


echo "<label>Gender: <input type='text' id='gender' value='$genderText' readonly></label>";


    }
echo"</div>";
    }
?>
                <h2>Prescribe Medications</h2>
                <div class="medication-grid">
                    <?php
               
    echo "<input type='hidden' name='appId' value='$appointmentID'>";
    echo "<input type='hidden' name='patient_id' value='$Pid'>";


                    $sql="SELECT * FROM medication";
                    $result=mysqli_query($conn, $sql);
                    while($r= mysqli_fetch_assoc($result)){
echo "<label><input type='checkbox' name='medications[]' value='" . $r['id'] . "'> " . $r['MedicationName'] . "</label>";

                       
                    }
                    
                    ?>
                   
                </div>
                <br><br>
                
    <div style="text-align: center;">
    <input type="submit" class="btn" value="Save and Return">
     </div>


            </form>

           
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
</html
