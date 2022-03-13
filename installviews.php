<?php

require "connect.php";
$sql = file_get_contents("data/initviews.sql");
$connection->exec($sql);
echo "Vizualizari adaugate cu succes!";