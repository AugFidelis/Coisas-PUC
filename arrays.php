<?php

    // arrays

    $foods = array("apple", "orange", "banana", "coconut");

    //foods[0] = "pineapple";

    //array_push($foods, "pineapple", "kiwi");
    //adiciona algo novo ao array

    //array_pop($foods);
    //remove a ultima coisa do array

    //array_shift($foods);
    //remove a primeira coisa do array e move o resto uma posicao atras

    $reversed_foods = array_reverse($foods);
    //inverte o array

    echo count($foods) . "<br>";
    //conta o número de valores do array

    echo $foods[0] . "<br>";
    echo $foods[1] . "<br>";
    echo $foods[2] . "<br>";
    echo $foods[3] . "<br>";

    echo "<br>";

    foreach($foods as $food){
        echo $food . "<br>";
    }

    echo "<br>";

    foreach($reversed_foods as $food){
        echo $food . "<br>";
    }
?>