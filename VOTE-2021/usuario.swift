//
//  Usuario.swift
//  VOTE-2021
//
//  Created by clau93 on 01/12/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//

import Foundation
class Usuario{
    // creamos nuestro array donde se almaceneran nuestros datr
    var idUsr: Int
    var nombre : String
    var correo  : String
    
    init(idUsuario: Int,nom: String, cor: String) {
        self.idUsr = idUsuario
        self.nombre = nom
        self.correo = cor
        
    }
}
