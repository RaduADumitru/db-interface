<?php include "templates/header.php"; ?>
<?php require "../connect.php";
echo "<h2>Angajati per aeroport</h2>";
$sql = "select * from angajati_per_aeroport order by id_aeroport;";
$statement = $connection->prepare($sql);
$statement->execute();
echo "<table border='1'>
<tr>
<th>Id aeroport</th>
<th>Nume aeroport</th>
<th>Numar angajati</th>
</tr>";
while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
    echo "<tr>";
    foreach ($row as $col => $val) {
        echo "<td>" . $val . "</td>";
    }
    echo "</tr>";
}
echo "</table>";
include "templates/footer.php";