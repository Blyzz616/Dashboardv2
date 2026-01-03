<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache');

// Database
// Connextion Details
$servername = "";
$username = "";
$password = "";
$dbname = "home";

$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    echo json_encode(["error" => true]);
    exit;
}

$sql = "SELECT percent FROM citrine
        WHERE timestamp >= NOW() - INTERVAL 6 HOUR
        ORDER BY timestamp DESC LIMIT 1";

$result = mysqli_query($conn, $sql);

if ($result && mysqli_num_rows($result) === 1) {
    $row = mysqli_fetch_assoc($result);
    $style =
        ($row['percent'] > 60) ? 'high' :
        (($row['percent'] < 42) ? 'low' : 'goldilocks');

    echo json_encode([
        "percent" => $row['percent'],
        "style"   => $style
    ]);
} else {
    echo json_encode([
        "percent" => null,
        "style"   => "alert"
    ]);
}

mysqli_close($conn);
