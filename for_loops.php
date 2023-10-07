<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>'for' Loops</title>
</head>
<body>
    <form action="for_loops.php" method="post">
        <label>Enter a number to count to:</label>
        <input type="text" name="counter">
        
        <br>
        
        <label>Enter a number to count down from:</label>
        <input type="text" name="ctdown">
        <br>
        <input type="submit" value="Start">
    </form>
    <br>
</body>
</html>

<?php

    // for loop: repeats some code a certain amount of times

    $counter = $_POST["counter"];
    $ctdown = $_POST["ctdown"];

    if($counter == true){
        echo "Counting up to {$counter}:<br>";
        for($i = 1; $i <= $counter; $i++){
            echo $i . "<br>";
        }
    }

    if($ctdown == true){
        echo "<br>Counting down from {$ctdown}:<br>";
        for($i = $ctdown; $i > 0; $i--){
            echo $i . "<br>";
        }
    }

?>