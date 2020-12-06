<?php
/*
 * El siguiente código Inserta un voto
 * MAOC    Nov/2020
 */

$response = array();

$Cn = mysqli_connect("localhost","root","","prevotacion")or die ("server no encontrado");
mysqli_set_charset($Cn,"utf8");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    
    $result = mysqli_query($Cn,"SELECT id_Casilla,nombre_Casilla,latitud,longitud FROM casilla ORDER BY nombre_Casilla");
    if (!empty($result)) {
        if (mysqli_num_rows($result) > 0) {
            while ($res = mysqli_fetch_array($result)){
                $casi = array();
                $casi["success"] = 200;  
                $casi["message"] = "Producto encontrado";
                $casi["id_Casilla"] = $res["id_Casilla"];
                $casi["nombre_Casilla"] = $res["nombre_Casilla"];
                $casi["latitud"] = $res["latitud"];
                $casi["longitud"]=$res["longitud"];
               // $user["idCasilla"]=$res["idCasilla"];
                array_push($response, $casi);
            }
           echo json_encode($response);
        } else {
            $casi = array();
            $casi["success"] = 404;  //No encontro información y el success = 0 indica no exitoso
            $casi["message"] = "Producto no encontrado";
            array_push($response, $casi);
            echo json_encode($response);
        }
    } else {
        $casi = array();
        $casi["success"] = 404;  //No encontro información y el success = 0 indica no exitoso
        $casi["message"] = "Producto no encontrado";
        array_push($response, $casi);
        echo json_encode($response);
    }
} else {
    $casi = array();
    $casi["success"] = 400;
    $casi["message"] = "Faltan Datos entrada";
    array_push($response, $casi);
    echo json_encode($response);
}
mysqli_close($Cn);
?>

