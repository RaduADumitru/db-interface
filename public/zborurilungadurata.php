<?php include "templates/header.php"; ?>
<?php require "../connect.php";
echo "<h2>Zboruri de lunga durata</h2>";
$sql = "select z.nr_zbor, 
       concat(floor(avg((timestampdiff(minute, z.plecare_dus, z.sosire_dus)
    + timestampdiff(minute, z.plecare_intors, z.sosire_intors)) / 2) / 60), 'h ',
  lpad(floor(avg(timestampdiff(minute, z.plecare_dus, z.sosire_dus)) % 60) , 2, 0), 'min') 
    as durata_medie_zbor
from zbor z
group by z.nr_zbor
having avg((timestampdiff(minute, z.plecare_dus, z.sosire_dus)
    + timestampdiff(minute, z.plecare_intors, z.sosire_intors)) / 2) > 120;";
$statement = $connection->prepare($sql);
$statement->execute();
echo "<table border='1'>
<tr>
<th>Numar zbor</th>
<th>Durata medie zbor</th>
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