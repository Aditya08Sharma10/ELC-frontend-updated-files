<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'db_config.php';

$sql = "SELECT * FROM submitted_data";  // change table name if needed
$result = $conn->query($sql);

if ($result) {
    $data = [];
    
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode([
        "success" => true,
        "message" => "Data loaded successfully",
        "data" => $data
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Error loading data: " . $conn->error
    ]);
}

$conn->close();
?>