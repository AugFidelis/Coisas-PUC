<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercicio math functions</title>
</head>
<body>
    <form action="ex_mathfunctions.php" method="post">
        <label>Radius:</label>
        <input type="text" name="radius">
        <input type="submit" value="Calculate">
        <label></label>
    </form>
    <br>
</body>
</html>

<?php
    
    $radius = $_POST["radius"];
    $circumference = null;
    $area = null;
    $volume = null;

    $circumference = 2 * pi() * $radius;
    $circumference = round($circumference, 2);
    //colocar um número além da variável no round arredonda até o numero especificado

    $area = pi() * pow($radius, 2);
    $area = round($area, 2);

    $volume = 4/3 * pi() * pow($radius, 3);
    $volume = round($volume, 2);

    echo "The circumference is: {$circumference}cm <br>";
    echo "The area is: {$area}cm^2 <br>";
    echo "The volume is: {$volume}cm^3 <br>";


?>