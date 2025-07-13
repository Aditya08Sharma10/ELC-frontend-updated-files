<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "bloodapp_db";

$conn = new mysqli($host,$user,$password,$database);

if($conn->connect_error){
    die("connection failed, Error :".$conn->connect_error);
}