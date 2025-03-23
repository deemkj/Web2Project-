<?php
session_start();

include 'DBconnection.php'; 


if ($_SERVER["REQUEST_METHOD"] == "POST") {

    if (isset($_POST["role"])) {
        $role = $_POST["role"];
    } else {
        $role = '';
    }

    $firstName = $_POST["first-name"];
    $lastName = $_POST["last-name"];
    $email = $_POST["email"];
    $id = $_POST["id"];
    $password = password_hash($_POST["password"], PASSWORD_DEFAULT); 
    

    $checkId = mysqli_prepare($conn, "SELECT id FROM " . ($role == "patient" ? "patient" : "doctor") . " WHERE id = ?");
    mysqli_stmt_bind_param($checkId, "s", $id);
    mysqli_stmt_execute($checkId);
    mysqli_stmt_store_result($checkId);

    if (mysqli_stmt_num_rows($checkId) > 0) {
        echo "<script>
                alert('This ID has already been used! Please check');
                window.location.href = 'Sign-Up page.html';
              </script>";
        exit();
    }
    mysqli_stmt_close($checkId);

    $checkEmail = mysqli_prepare($conn, "SELECT id FROM " . ($role == "patient" ? "patient" : "doctor") . " WHERE emailAddress = ?");
    mysqli_stmt_bind_param($checkEmail, "s", $email);
    mysqli_stmt_execute($checkEmail);
    mysqli_stmt_store_result($checkEmail);

    if (mysqli_stmt_num_rows($checkEmail) > 0) {
        echo "<script>
                alert('This email has already been used! Please check');
                window.location.href = 'Sign-Up page.html';
              </script>";
        exit();
    }
    mysqli_stmt_close($checkEmail);

    if ($role == "patient") {
        $gender = $_POST["gender"];
        $dob = $_POST["dob"];


        $stmt = mysqli_prepare($conn, "INSERT INTO patient (id, firstName, lastName, Gender, DoB, emailAddress, password) VALUES (?, ?, ?, ?, ?, ?, ?)");
        mysqli_stmt_bind_param($stmt, "sssssss", $id, $firstName, $lastName, $gender, $dob, $email, $password);

        if (mysqli_stmt_execute($stmt)) {
            $_SESSION["user_id"] = mysqli_insert_id($conn);
            $_SESSION["user_type"] = "patient";
            header("Location: Patient Homepage.php");
            exit();
        } else {
            echo "Error: " . mysqli_stmt_error($stmt);
        }
        mysqli_stmt_close($stmt);
    } elseif ($role == "doctor") {
        $speciality = $_POST["speciality"];
        $photoName = "";


        if (isset($_FILES["photo"]) && $_FILES["photo"]["error"] == 0) {
            $fileType = strtolower(pathinfo($_FILES["photo"]["name"], PATHINFO_EXTENSION));
            $allowedTypes = ["jpg", "jpeg", "png"];

            if (in_array($fileType, $allowedTypes)) {
                $photoName = uniqid("doc_") . "." . $fileType; 
                $uploadDir = "C:/MAMP/htdocs/serverImages/";
                $targetFilePath = $uploadDir . $photoName;

                
                if (!file_exists($uploadDir)) {
                    mkdir($uploadDir, 0777, true);
                }

                if (move_uploaded_file($_FILES["photo"]["tmp_name"], $targetFilePath)) {
                    echo "The image has been uploaded successfully!";
                } else {
                    die("Failed to upload the image! Please check the folder permissions");
                }
            } else {
                die("File format not supported!");
            }
        } else {
            die("No image was uploaded, or an error occurred during the upload!");
        }

        
        $stmt = mysqli_prepare($conn, "INSERT INTO doctor (id, firstName, lastName, uniqueFileName, SpecialityID, emailAddress, password) VALUES (?, ?, ?, ?, ?, ?, ?)");
        mysqli_stmt_bind_param($stmt, "sssssss", $id, $firstName, $lastName, $photoName, $speciality, $email, $password);

        if (mysqli_stmt_execute($stmt)) {
            $_SESSION["user_id"] = mysqli_insert_id($conn);
            $_SESSION["user_type"] = "doctor";
            header("Location: Doctor.php");
            exit();
        } else {
            die(" Error while saving: " . mysqli_stmt_error($stmt));
        }
        mysqli_stmt_close($stmt);
    }
}


mysqli_close($conn);
?>
