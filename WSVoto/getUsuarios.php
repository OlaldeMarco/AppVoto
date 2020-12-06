<?php
/*
 * El siguiente código Inserta un voto
 * MAOC    Nov/2020
 */

$response = array();

$Cn = mysqli_connect("localhost","root","","prevotacion")or die ("server no encontrado");
mysqli_set_charset($Cn,"utf8");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    
    $result = mysqli_query($Cn,"SELECT idUsr,nombre,correo,contraseña FROM usuario ORDER BY nombre");
    if (!empty($result)) {
        if (mysqli_num_rows($result) > 0) {
            while ($res = mysqli_fetch_array($result)){
                $user = array();
                $user["success"] = 200;  
                $user["message"] = "Producto encontrado";
                $user["idUsr"] = $res["idUsr"];
                $user["nombre"] = $res["nombre"];
                $user["correo"] = $res["correo"];
                $user["contraseña"]=$res["contraseña"];
               // $user["idCasilla"]=$res["idCasilla"];
                array_push($response, $user);
            }
           echo json_encode($response);
        } else {
            $user = array();
            $user["success"] = 404;  //No encontro información y el success = 0 indica no exitoso
            $user["message"] = "Producto no encontrado";
            array_push($response, $user);
            echo json_encode($response);
        }
    } else {
        $user = array();
        $user["success"] = 404;  //No encontro información y el success = 0 indica no exitoso
        $user["message"] = "Producto no encontrado";
        array_push($response, $user);
        echo json_encode($response);
    }
} else {
    $user = array();
    $user["success"] = 400;
    $user["message"] = "Faltan Datos entrada";
    array_push($response, $user);
    echo json_encode($response);
}
mysqli_close($Cn);
?>

