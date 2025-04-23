<?php

/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHP.php to edit this template
 */


include 'DBconnection.php';

if (isset($_POST['specialty'])) {
    $specialty = $_POST['specialty'];

    $stmt = $conn->prepare("SELECT id FROM speciality WHERE speciality = ?");
    $stmt->bind_param("s", $specialty);
    $stmt->execute();
    $result = $stmt->get_result();
    $speRow = $result->fetch_assoc();

    $stmt = $conn->prepare("SELECT id, firstName, lastName FROM doctor WHERE SpecialityID = ?");
    $stmt->bind_param("i", $speRow['id']);
    $stmt->execute();
    $result = $stmt->get_result();

    $doctors = [];
    while ($row = $result->fetch_assoc()) {
        $doctors[] = [
            'id' => $row['id'],
            'name' => $row['firstName'] . ' ' . $row['lastName']
        ];
    }

    echo json_encode($doctors);
}
?>
