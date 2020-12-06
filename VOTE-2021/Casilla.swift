//
//  Casilla.swift
//  VOTE-2021
//
//  Created by clau93 on 30/11/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//

import Foundation
class Casilla{
    // creamos nuestro array donde se almaceneran nuestros datr
    var id_Casilla : String
    var nombre_Casilla : String
    var latitud  : String
    var longitud : String
    
    init(idCas: String,nomCas: String, lat: String, long: String) {
        self.id_Casilla = idCas
        self.nombre_Casilla = nomCas
        self.latitud = lat
        self.longitud = long

        
    }
}
