<?php
/*
 * El siguiente código Inserta un producto
 * MAOC    Nov/2020
 */

$response = array();
$user = array();

$Cn = mysqli_connect("localhost","root","","prevotacion")or die ("server no encontrado");
mysqli_set_charset($Cn,"utf8");

// Checa que le este llegando por el método POST el nomProd,existencia y precio

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $objArray = json_decode(file_get_contents("php://input"),true);
    if (empty($objArray))
    {
        // required field is missing
        $user["success"] = 400;
        $user["message"] = "Faltan Datos entrada";
        array_push($response,$user);
        echo json_encode($response);
    }
    else{
        $nom=$objArray['nombre']; 
        $corre=$objArray['correo'];
        $contra=$objArray['contraseña'];
        $result = mysqli_query($Cn,"INSERT INTO usuario(nombre,correo,contraseña) values 
        ('$nom','$corre','$contra')");
        //$idprod = mysqli_insert_id($Cn);
        if ($result) {   
            $user["success"] = 200;   // El success=200 es que encontro eñ producto
            $user["message"] = "Producto Insertado";

            array_push($response,$user);
            echo json_encode($response);
        } else {
                // 
                $user["success"] = 406;  
                $user["message"] = "Producto no Insertado";
                array_push($response,$user);
                echo json_encode($response);
        }
    }
} else {
    // required field is missing
    $user["success"] = 400;
    $user["message"] = "Faltan Datos entrada";
    array_push($response,$user);
    echo json_encode($response);
}
mysqli_close($Cn);
?>
