<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json");

include 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect inputs safely
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';
    $phone = $_POST['phone'] ?? '';
    $dob = $_POST['dob'] ?? '';
    $gender = $_POST['gender'] ?? '';
    $blood_group = $_POST['blood_group'] ?? '';

    // Validate required fields
    if (empty($name) || empty($email) || empty($password) || empty($phone)) {
        echo json_encode([
            "success" => false,
            "message" => "Required fields are missing"
        ]);
        exit;
    }

    // Prepare SQL
    $sql = "INSERT INTO submitted_data (name, email, password, phone, dob, gender, blood_group) 
            VALUES (?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);

    if (!$stmt) {
        echo json_encode([
            "success" => false,
            "message" => "Prepare failed: " . $conn->error
        ]);
        exit;
    }

    $stmt->bind_param("sssssss", $name, $email, $password, $phone, $dob, $gender, $blood_group);

    if ($stmt->execute()) {
        echo json_encode([
            "success" => true,
            "message" => "Form submitted successfully"
        ]);
    } else {
        // Check for duplicate entry error (MySQL error code 1062)
        if ($stmt->errno === 1062) {
            echo json_encode([
                "success" => false,
                "message" => "Duplicate entry: Email or Phone already exists"
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Database error: " . $stmt->error
            ]);
        }
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request"
    ]);
}
?>
