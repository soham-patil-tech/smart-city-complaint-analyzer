<?php
$conn = new mysqli("localhost", "root", "", "smart_city");
if ($conn->connect_error) {
    die("DB Connection Failed");
}
?>
