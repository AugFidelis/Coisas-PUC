<?php
    //variable: a reusable container that holds data (string, integer, float, boolean)

    $name = "Nebulous Fabulous"; //strings
    $food = "pizza";
    $email = "fake123@gmail.com";

    $age = 21; //integers (numeros inteiros)
    $users = 2;
    $quantity = 4;

    $nota = 2.5; //float
    $price = 5.99;
    $tax_rate = 4.1;

    $employed = true; //boolean
    $online = false; //n aparece pq é falso, se é true aparece um 1
    $for_sale = true;

    $total = null;
    
    echo "Hello {$name}<br>";
    echo "You like {$food}<br>";
    echo "Your email is {$email}<br>";

    echo "You are {$age} years old<br>";
    echo "There are {$users} users online<br>";
    echo "You would like to buy {$quantity} items<br>";

    echo "Your grade is: {$nota}<br>";
    echo "Your pizza is \${$price}<br>"; //pra colocar o $ tem q colocar a barra senao o site fica confuso achando q é variavel
    echo "The sales tax rate is {$tax_rate}%<br>";

    echo "Online status: {$online}<br><br>";

    echo "You have ordered {$quantity}x {$food}s<br>";
    $total = $quantity * $price;
    echo "Your total is \${$total}<br>";

    
?>
