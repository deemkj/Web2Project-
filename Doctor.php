<?php
session_start();
include "DBconnection.php";

// Redirect to homepage if user is not a doctor
if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== "doctor") {
    header("Location: Ebsar Homepage.html");
    exit();
}

$doctorID = $_SESSION['user_id'];

// Get doctor info
$sql = "SELECT d.firstName, d.lastName, s.speciality, d.emailAddress 
        FROM doctor d 
        JOIN speciality s ON d.SpecialityID = s.id
        WHERE d.id = '$doctorID'";
$result = mysqli_query($conn, $sql);
$doctor = mysqli_fetch_assoc($result);

// Get upcoming appointments
$sqlAppointments = "SELECT a.id, a.date, a.time, p.id AS patientID, p.firstName, p.lastName, p.DoB, p.Gender, a.reason, a.status 
                    FROM appointment a
                    JOIN patient p ON a.PatientID = p.id
                    WHERE a.DoctorID = '$doctorID' AND a.status IN ('Pending', 'Confirmed')
                    ORDER BY a.date, a.time";
$appointments = mysqli_query($conn, $sqlAppointments);

// Get past patients (appointments marked as Done)
$sqlPatients = "SELECT DISTINCT p.firstName, p.lastName, p.DoB, p.Gender, 
                       GROUP_CONCAT(m.MedicationName SEPARATOR ', ') AS Medications
                FROM appointment a
                JOIN patient p ON a.PatientID = p.id
                LEFT JOIN prescription pr ON a.id = pr.AppointmentID
                LEFT JOIN medication m ON pr.MedicationID = m.id
                WHERE a.DoctorID = '$doctorID' AND a.status = 'Done'
                GROUP BY p.id
                ORDER BY p.firstName, p.lastName";
$patients = mysqli_query($conn, $sqlPatients);
?>

<!DOCTYPE html>
<html lang="en">
    <style>
    .status-cell {
        font-size: 14px;
        line-height: 1.6;
    }

    .status-text {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .status-text.pending {
        color: #f0ad4e;
    }

    .status-text.confirmed {
        color: #5cb85c;
    }

    .status-text.done {
        color: #999;
        font-style: italic;
    }

    .action-link {
        display: inline-block;
        text-decoration: underline;
        font-weight: bold;
        color: #0645AD;
        transition: color 0.3s;
    }

    .action-link:hover {
        color: #002f6c;
    }

    
</style>
<head>
    <meta charset="UTF-8">
    <title>Doctor Homepage</title>
    <link rel="stylesheet" href="StyleSheet.css">
</head>
<body>
<header>
    <div class="logo"><a href="Ebsar Homepage.html"><img src="images/2logo.png" alt="Ebsar Logo"></a></div>
    <nav>
        <ul>
            <li><a href="logout.php" class="sign-out-link">Log out</a></li>
        </ul>
    </nav>
</header>

<div class="doctor-container">
    <section class="doctor-info-section">
        <h2 class="doctor-welcome-text">Welcome, <?php echo $doctor['firstName']; ?></h2>
        <div class="doctor-card">
            <div class="doctor-card-header"><h3>Doctor Information</h3></div>
            <div class="doctor-card-body">
                <p><strong>First Name:</strong> <?php echo $doctor['firstName']; ?></p>
                <p><strong>Last Name:</strong> <?php echo $doctor['lastName']; ?></p>
                <p><strong>Specialty:</strong> <?php echo $doctor['speciality']; ?></p>
                <p><strong>Email:</strong> <?php echo $doctor['emailAddress']; ?></p>
            </div>
        </div>
    </section>

    <section class="doctor-appointments">
        <h2>Upcoming Appointments</h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Patient's Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Reason</th>
                    <th>Status / Action</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = mysqli_fetch_assoc($appointments)) { 
                    $age = date("Y") - date("Y", strtotime($row['DoB']));
                ?>
                <tr>
                    <td><?php echo $row['date']; ?></td>
                    <td><?php echo date("g:i A", strtotime($row['time'])); ?></td>
                    <td><?php echo $row['firstName'] . " " . $row['lastName']; ?></td>
                    <td><?php echo $age; ?></td>
                    <td><?php echo $row['Gender']; ?></td>
                    <td><?php echo $row['reason']; ?></td>
                    <td class="status-cell">
                <?php if ($row['status'] === "Pending") { ?>
                    <span class="status-text pending">Pending</span><br>
                    <a class="actiion-link confirm-link" href="confirm_appointment.php?id=<?php echo $row['id']; ?>">Confirm</a>
                <?php } elseif ($row['status'] === "Confirmed") { ?>
                    <span class="status-text confirmed">Confirmed</span><br>
                    <a class="actiion-link prescribe-link" href="Prescribe Medication.php?appointment_id=<?php echo $row['id']; ?>&patient_id=<?php echo $row['patientID']; ?>">Prescribe</a>
                <?php } ?>
                 </td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
    </section>

    <section class="doctor-patients">
    <h2>Your Patients</h2>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Medications</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = mysqli_fetch_assoc($patients)) { 
                $age = date("Y") - date("Y", strtotime($row['DoB']));
            ?>
            <tr>
                <td><?php echo $row['firstName'] . ' ' . $row['lastName']; ?></td>
                <td><?php echo $age; ?></td>
                <td><?php echo $row['Gender']; ?></td>
                <td><?php echo $row['Medications'] ?: 'N/A'; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</section>
</div>

<footer>
    <p style="text-align:center; margin-top:20px;">&copy; 2025 Ebsar Clinic. All rights reserved.</p>
</footer>
</body>
</html>
