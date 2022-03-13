<?php require "config.php";
$connection = new PDO($dsn, $username, $password, $options);
$connection ->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);?>