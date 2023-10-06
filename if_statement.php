<?php

    // If statement: 
    //if some condition is true, do something, if condition is false, don't do it

    /*
    $age = 101;

    if($age >= 100){
        echo "You are too old to enter this site";
    }
    elseif($age >= 18){
        echo "You may enter this site";
    }
    // == é pra comparação e = é pra igualar valor
    elseif($age <= 0){
        echo "That isn't a valid age";
    }
    else{
        echo "Die";
    }
    */

    $adult = true;

    if($adult){
        echo "You may enter this site";
    }
    else{
        echo "You must be an adut to enter";
    }

?>