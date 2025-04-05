<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
-->
 <?php

session_start();
include 'DBconnection.php';

// التحقق مما إذا كان المستخدم مسجل دخول أم لا
if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== 'patient') {
    header("Location: ../pages/Log-In page.html"); // إعادة التوجيه إلى صفحة تسجيل الدخول
    exit();
}

$patient_id = $_SESSION['user_id'];


$sql_patient = "SELECT id, firstName, lastName, emailAddress, DoB, Gender FROM Patient WHERE id = ?";
$stmt_patient = mysqli_prepare($conn, $sql_patient);
mysqli_stmt_bind_param($stmt_patient, "i", $patient_id);
mysqli_stmt_execute($stmt_patient);
$result_patient = mysqli_stmt_get_result($stmt_patient);

if (!$result_patient || mysqli_num_rows($result_patient) === 0) {
    die("No patient data found.");
}

$patient = mysqli_fetch_assoc($result_patient);
// حذف كل المواعيد التي حالتها 'done' للمريض الحالي
$delete_done_sql = "DELETE FROM Appointment WHERE PatientID = ? AND status = 'done'";
$stmt_delete = mysqli_prepare($conn, $delete_done_sql);
mysqli_stmt_bind_param($stmt_delete, "i", $patient_id);
mysqli_stmt_execute($stmt_delete);

$sql_appointments = "SELECT a.id, a.date, a.time, a.status, d.firstName AS doctor_first, d.lastName AS doctor_last, d.uniqueFileName 
                     FROM Appointment a
                     JOIN Doctor d ON a.DoctorID = d.id
                     WHERE a.PatientID = ?
                     ORDER BY a.date, a.time";

$stmt_appointments = mysqli_prepare($conn, $sql_appointments);
mysqli_stmt_bind_param($stmt_appointments, "i", $patient_id);
mysqli_stmt_execute($stmt_appointments);
$result_appointments = mysqli_stmt_get_result($stmt_appointments);

if (!$result_appointments) {
    die("Appointments query failed: " . mysqli_error($conn));
}
?>

<!DOCTYPE html> 
<html lang="en"> 
<head> 
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>Patient Homepage</title> 
    <link rel="stylesheet" href="../css/StyleSheet.css"> 
</head> 
<body> 

<header> 
    <div class="logo"><a href="../pages/Ebsar Homepage.html"><img src="../images/2logo.png" alt="Ebsar Logo"></a></div>
    <nav> 
        <ul> 
            <li><a href="../pages/Ebsar Homepage.html" class="sign-out-link">Log out</a></li> 
        </ul> 
    </nav> 
</header> 

<div class="cont"> 
    <section class="patient-info-section"> 
        <h2 class="welcome-text">Welcome, <?php echo htmlspecialchars($patient['firstName']); ?></h2> 
        <div class="patient-card"> 
            <div class="card-header"> 
                <h3>Patient Information</h3> 
            </div> 
            <div class="card-body"> 
                <p><strong>First Name:</strong> <?php echo htmlspecialchars($patient['firstName']); ?></p> 
                <p><strong>Last Name:</strong> <?php echo htmlspecialchars($patient['lastName']); ?></p> 
                <p><strong>ID:</strong> <?php echo htmlspecialchars($patient['id']); ?></p> 
                <p><strong>DoB:</strong> <?php echo htmlspecialchars($patient['DoB']); ?></p> 
                <p><strong>Email:</strong> <?php echo htmlspecialchars($patient['emailAddress']); ?></p> 
                <p><strong>Gender:</strong> <?php echo htmlspecialchars($patient['Gender']); ?></p> 
            </div> 
        </div> 
    </section> 

    <section class="appointments"> 
        <h2>Your Appointments</h2> 
        <table class="tablepat"> 
            <thead> 
                <tr> 
                    <th>Time</th> 
                    <th>Date</th> 
                    <th>Doctor's Name</th> 
                    <th>Doctor's Photo</th> 
                    <th>Status</th> 
                    <th>Actions</th> 
                </tr> 
            </thead> 
            <tbody> 
                <?php if (mysqli_num_rows($result_appointments) === 0): ?>
    <tr>
        <td colspan="6" style="text-align: center;">No appointments yet.</td>
    </tr>
<?php endif; ?>
                <?php while ($row = mysqli_fetch_assoc($result_appointments)): ?>
                    <tr> 
                        <td><?php echo htmlspecialchars($row['time']); ?></td> 
                        <td><?php echo htmlspecialchars($row['date']); ?></td> 
                        <td><?php echo htmlspecialchars("Dr. " . $row['doctor_first'] . " " . $row['doctor_last']); ?></td> 
                        <td> 
                  <?php
    $imagePath = "/serverImages/" . htmlspecialchars($row['uniqueFileName']);
    ?>
    
    <img src="<?php echo $imagePath; ?>" 
         alt="Doctor Photo" class="doctor-photo"
         onerror="this.onerror=null; this.src='default.png';">

                        </td> 
                        <td><?php echo htmlspecialchars($row['status']); ?></td> 
                        <td>
             <a href="cancel_appointment.php?appointment_id=<?php echo $row['id']; ?>" class="cancel-btn">Cancel</a>
              </td>
                    </tr> 
                <?php endwhile; ?>
            </tbody> 
        </table>
        <br><br> 
        <a href="Appointment Booking.php" class="book-link">Book an appointment</a> 
    </section> 
</div> 

<footer> 
    <div class="footer-left-1"> 
        <h4>Contact Us</h4> 
        <p>+996 563821256 | Ebsar@gmail.com | Riyadh, Saudi Arabia</p> 
    </div> 
    <div class="footer-center-1"> 
        <a href="../pages/Ebsar Homepage.html"><img src="../images/2logo.png" alt="Logo" class="footer-logo-1 logo-toggle"></a> 
    </div> 
    <div class="footer-right-1"> 
        <p>Social media:</p> 
        <div class="social-icons-1">
            <img src="../images/facebook1.png" alt="Facebook"> 
            <img src="../images/X1.png" alt="Twitter"> 
            <img src="../images/instagram1.png" alt="Instagram"> 
        </div> 
    </div> 
    <div class="footer-bottom-1"> 
        <p>&copy; 2025 Website. All rights reserved.</p> 
    </div> 
</footer> 
</body> 
</html>

<?php
mysqli_close($conn);
?>     