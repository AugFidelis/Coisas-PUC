<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Math Functions</title>
    <link rel="shortcut icon" href="favicon.jpg" type="image/x-icon">
</head>
<body>
    <form action="mathfunctions.php" method="post">
        <label for="">x:</label>
        <input type="text" name="x">
        <br>
        <label for="">y:</label>
        <input type="text" name="y">
        <br>
        <label for="">z:</label>
        <input type="text" name="z">
        <br>
        <input type="submit" value="Total">
    </form>
</body>
</html>

<?php

    $x = $_POST["x"];
    $y = $_POST["y"];
    $z = $_POST["z"];
    $total = null;

    //$total = abs($x);
    
    //$total = round($x);
    //arredonda

    //$total = floor($x);
    //arredonda pra baixo

    //$total = ceil($x);
    //arredonda pra cima

    //$total = pow($x, $y);
    //potencia

    //$total = sqrt($x);
    //raiz quadrada
    
    //$total = max($x, $y, $z);
    //pega o maior valor dentre os valores inseridos

    //$total = min($x, $y, $z);
    //pega o menor valor dentre os valores inseridos

    //$total = pi();
    //da o valor de pi

    //$total = rand(1, 6);
    //da um valor aleatório, se tem valores inseridos são o minimo e o maximo q podem ser escolhidos
    
    echo "<br>";
    echo "x = " . $x . "<br>";
    echo "y = {$y}<br>";
    echo "z = {$z}<br>";
    echo $total;



?>