<?php include "templates/header.php"; ?>
<h2> Tabel in care se vor insera date </h2>
<form id="tabel" method="post">
<select name="tabel_ales">
    <option value="">--Alegeti tabelul--</option>
<?php
require "../connect.php";
//Get all tables in database, for option selection screen
$sql1 = "SELECT TABLE_NAME FROM information_schema.tables WHERE table_schema='gestionare_angajati_companie_aeriana';";
$result = $connection->prepare($sql1);
$result->execute();
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $table = $row['TABLE_NAME'];
    echo "<option value=$table>" . ucfirst($table) . '</option>';
}


?>
</select>
    <input type="submit" name="submittabel" value="Submit">
</form>

<?php
if (isset($_POST['tabel_ales']) and $_POST['tabel_ales'] != ''){
    $tabel2 = $_POST['tabel_ales'];
    echo '<label for="tabel">' . ucfirst($tabel2) . ':</label>';
    echo '<form id="inserare" method="post">';
    //Get all columns in selected table, to create insertion textboxes for each column
    $sql2 = "SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'gestionare_angajati_companie_aeriana' AND TABLE_NAME = '" . $tabel2 . "' ORDER BY ORDINAL_POSITION;";
    $result2 = $connection->prepare($sql2);
    $result2->execute();
    while($row2=$result2->fetch(PDO::FETCH_ASSOC)) {
        $column = $row2['COLUMN_NAME'];
        echo "<label for=$column>" . ucfirst($column) . "</label> <input type='text' name=insertdata[$column] id=$column>";
    }
    echo '<input type="hidden" name="tabel_inserare" value=';
    echo $tabel2;
    echo '><input type="submit" name="submitentry" value="Submit">';
    echo '</form>';
}
if (isset($_POST['tabel_inserare'])) {
    //After entry data is written, attempt insert statement with completed data
    $tabel3 = $_POST['tabel_inserare'];
    $entry = $_POST['insertdata'];
    $sql3 = "insert into " . $tabel3 . " values (";
    foreach($entry as $col => $val) {
        if(!empty($val)) {
            $sql3 .= "'" . $val . "', ";
        }
        else $sql3 .= "null, ";
    }
    $sql3 = substr($sql3, 0, -2);
    $sql3 .= ");";
    echo "Query: " . $sql3;
    $statement = $connection->prepare($sql3);
    $statement->execute();
    //Following code only reached if statement is executed succesfully
    echo '<label>Inserare realizata cu succes!</label>';
}

?>
<?php include "templates/footer.php"; ?>
