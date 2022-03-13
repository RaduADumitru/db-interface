<?php include "templates/header.php"; ?>
<h2> Tabel vizualizat: </h2>
<form id="tabel" method="post">
    <select name="tabel_ales">
        <option value="">--Alegeti tabelul--</option>
        <?php
        require "../connect.php";
        $sql1 = "SELECT TABLE_NAME 
        FROM information_schema.tables 
        WHERE table_schema='gestionare_angajati_companie_aeriana';";
        $statement = $connection->prepare($sql1);
        $statement->execute();
        while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
            $table = $row['TABLE_NAME'];
            echo "<option value=$table>" . ucfirst($table) . '</option>';
        }
        ?>
    </select>
    <input type="submit" name="submittabel" value="Submit">
</form>
<?php
if (isset($_POST['tabel_ales'])) {
    $tabel = $_POST['tabel_ales'];
    echo '<form id="sortare" method="post">';
    echo '<label> Ordonare '. ucfirst($tabel) . ':</label>';
    $sql2 = "SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'gestionare_angajati_companie_aeriana' 
  AND TABLE_NAME = '" . $tabel . "' 
  ORDER BY ORDINAL_POSITION;";
    $statement2 = $connection->prepare($sql2);
    $statement2->execute();
    $columns_arr = array();
    while($row2=$statement2->fetch(PDO::FETCH_ASSOC)) {
        $column = $row2['COLUMN_NAME'];
        echo "<label><input type='radio' name='sortare' value=" . $column . ">" . ucfirst($column) . "</label>";
        $columns_arr[] = $column;
    }
    echo "<input type='hidden' name='columns' value=";
    echo rawurlencode(serialize($columns_arr));
    echo "><input type='hidden' name='tabel_sortare' value=";
    echo $tabel;
    echo "><input type='submit' name='submitorder' value='Submit'></form>";
}
if(isset($_POST['submitorder'])) {
    $column2 = $_POST['sortare'];
    $tabel2 = $_POST['tabel_sortare'];
    $columns_arr2 = unserialize(rawurldecode($_POST['columns']));
    if(isset($_POST['sortare'])) {
        $sql3 = "select * from " . $tabel2 . " order by " . $column2 . ";";
    }
    else {
        $sql3 = "select * from " . $tabel2 . ";";
    }
    $statement3 = $connection->prepare($sql3);
    $statement3->execute();
    echo '<label>' . ucfirst($tabel2) . ':</label>';
    echo "<table border=1><tr>";
    foreach($columns_arr2 as $col3) {
        echo "<th>" . $col3 . "</th>";
    }
    echo "<th>Update</th><th>Delete</th>";
    echo "</tr>";
    while($row=$statement3->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        $entry = array();
        foreach($columns_arr2 as $col3) {
            echo "<td>" . $row[$col3] . "</td>";
            $entry[$col3] = $row[$col3];
        }
        echo "<td><form method='post'>
            <input type='hidden' name='tabel_update' value=";
        echo $tabel2;
        echo "><input type='hidden' name='entry_update' value=";
        echo rawurlencode(serialize($entry));
        echo "><input type='submit' name='submit_update' value='Update'>
</form>
</td>
<td>
        <form method='post'>
        <input type='hidden' name='tabel_delete' value=";
        echo $tabel2;
        echo "><input type='hidden' name='entry_delete' value=";
        echo rawurlencode(serialize($entry));
        echo "><input type='submit' name='submit_delete' value='Delete'>
</form>
</td></tr>";
    }
    echo "</table>";
}
if (isset($_POST['submit_update'])) {
    $tab_upd = $_POST['tabel_update'];
    echo '<label>Update:</label>';
    $update_entry = unserialize(rawurldecode($_POST['entry_update']));
    echo "<table border='1'><tr>";
    foreach($update_entry as $col_upd => $val_upd) {
        echo "<th>" . $col_upd . "</th>";
    }
    echo "</tr><tr>";
    foreach($update_entry as $col_upd => $val_upd) {
        echo "<td>" . $val_upd . "</td>";
    };
    $update_entry_post = rawurlencode(serialize($update_entry));
    echo "</tr></table>";
    echo "<form method='post'>
    <input type='hidden' name='old_entry' value=$update_entry_post>
    <input type='hidden' name='update_table' value=$tab_upd>";
    foreach($update_entry as $col_upd => $val_upd) {
        echo "<label for=$col_upd>" . ucfirst($col_upd) . "</label>
<input type='text' name='new_entry[$col_upd]' value='$val_upd'>";
    }
    echo "<input type='submit' name='confirm_update' value='Update'>";
    echo "</form>";
}
if (isset($_POST['confirm_update'])) {
    $update_old = unserialize(rawurldecode($_POST['old_entry']));
    $update_new = $_POST['new_entry'];
    $update_table = $_POST['update_table'];
    $sql4 = "update " . $update_table . " set ";
    foreach($update_new as $col_upd => $val_upd) {
        if($val_upd != $update_old[$col_upd]) {
            if(!empty($val_upd)) {
                $sql4 .= $col_upd . " = '" . $val_upd . "' and ";
            }
            else $sql4 .= $col_upd . " = null and ";
        }
    }
    $sql4 = substr($sql4, 0, -4);
    $sql4 .= "where (";
    foreach($update_old as $col_old => $val_old) {
        if(!empty($val_old)) {
            $sql4 .= $col_old . " = '" . $val_old . "' and ";
        }
    }
    $sql4 = substr($sql4, 0, -5);
    $sql4 .= ");";
    echo "Query: " . $sql4;
    $statement4 = $connection->prepare($sql4);
    $statement4->execute();
    echo '<label>Update realizat cu succes!</label>';
}
if (isset($_POST['submit_delete'])) {
    $delete_entry = unserialize(rawurldecode($_POST['entry_delete']));
    $sql5 = "delete from " . $_POST['tabel_delete'] . " where ";
    foreach($delete_entry as $col_del => $val_del) {
        if(!empty($val_del)) {
            $sql5 .= $col_del . " = '" . $val_del . "' and ";
        }
    }
    $sql5 = substr($sql5, 0, -5);
    $sql5 .= ";";
    echo "Query: " . $sql5;
    $statement5 = $connection->prepare($sql5);
    $statement5->execute();
    echo '<label>Stergere realizata cu succes!</label>';
}?>
<?php include  "templates/footer.php"; ?>

