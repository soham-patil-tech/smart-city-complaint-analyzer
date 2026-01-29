<?php
include "db.php";

$email = $_POST['email'];
$password = $_POST['password'];

$res = $conn->query("SELECT * FROM users WHERE email='$email' AND password='$password'");
if ($res->num_rows > 0) {
    echo "success";
} else {
    echo "failed";
}
?>
