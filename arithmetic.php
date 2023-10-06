<?php 

// Arithmetic operators
// + - * / ** %

// ** é potencia e % é resto da divisao


$x = 10;
$y = 3;
$z = null;

$z = $x / $y;

echo "{$z} <br>";

//----------------------------------------

// Increment/Decrement operators

$inc = 0;
$inc2 = 0;
$dec = 10;
 
$inc++;
$inc2+=2; //incrementa por 2 -= faz o msm com decremento
$dec--; 

echo "$inc / $dec / $inc2 <br>";

//---------------------------------------------

//Operator precedence
// ()  ->  **  ->  * / %  ->  + -

$total = 1 + 2 - 3 * 4 / 5 ** 6;

echo $total;



?>