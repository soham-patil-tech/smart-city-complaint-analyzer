<?php
include "db.php";

$user = $_POST['user_id'] ?? 1;
$dept = $_POST['department'] ?? 1;
$area = $_POST['area'] ?? 1;
$title = $_POST['title'] ?? '';
$desc = $_POST['description'] ?? '';
$urgency = $_POST['urgency'] ?? 'Low';

if (empty($title) || empty($desc)) {
    echo "Title or Description missing";
    exit;
}

$sql = "INSERT INTO complaints 
(user_id, department_id, area_id, title, description, urgency)
VALUES ('$user','$dept','$area','$title','$desc','$urgency')";

if ($conn->query($sql)) {
    echo "Complaint submitted";
} else {
    echo "DB Error";
}
?>
