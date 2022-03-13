<?php



$host       = "localhost";
$username   = "user1";
$password   = "12345";
$dbname     = "gestionare_angajati_companie_aeriana"; // will use later
$dsn        = "mysql:host=$host;dbname=$dbname"; // will use later
$options    = array(
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
);