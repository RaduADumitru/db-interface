<?php include "templates/header.php"; ?>
<?php require "../connect.php";
echo "<h2> Date pentru personalul cabin crew care a efectuat mai mult de un zbor </h2>";
$sql = "select a.id_angajat, a.nume, a.prenume, aer.nume as nume_aeroport,(select count(*) from
(select * from asociere_zbor asoc_nr where asoc_nr.id_angajat = a.id_angajat) as nr_zboruri) as numar_zboruri
from angajat a
join aeroport aer on a.id_aeroport=aer.id_aeroport
where a.cod_functie like 'CC' and (select count(*) from
(select * from asociere_zbor asoc_nr where asoc_nr.id_angajat = a.id_angajat) as nr_zboruri) > 1;";
$statement = $connection->prepare($sql);
$statement->execute();
echo "<table border='1'>
<tr>
<th>Id angajat</th>
<th>Nume</th>
<th>Prenume</th>
<th>Aeroport</th>
<th>Numar zboruri</th>
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