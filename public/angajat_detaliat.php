<?php include "templates/header.php"; ?>
<?php require "../connect.php";
echo "<h2>Angajati vazuti detaliat</h2>";
$sql = "select * from angajat_detaliat order by id_angajat;";
$statement = $connection->prepare($sql);
$statement->execute();
echo "<table border='1'>
<tr>
<th>Id angajat</th>
<th>Nume</th>
<th>Prenume</th>
<th>Numar telefon</th>
<th>Email</th>
<th>Data nasterii</th>
<th>Functie</th>
<th>Cod functie</th>
<th>Nume aeroport</th>
<th>Id aeroport</th>
<th>Oras</th>
<th>Tara</th>
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