//
//  UsuariBD.swift
//  VOTE-2021
//
//  Created by clau93 on 01/12/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//

import Foundation // importamos las funciones
import SQLite3 // importamos la base de datos Sqlite


/*
 Aqui vamos a crear nuestra clase para poder
 ver si la base de datos esta abierta o no lo esta
 */
class UsuarioBD{
    let dbPath = "nyDB.sqlite"
    var db : OpaquePointer?
    init() {
        db = openDataBase()
        CreateTable()
        
    }
    
    func openDataBase()-> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor : nil, create : false).appendingPathComponent(dbPath)
        var db : OpaquePointer? = nil
        // verificamos con un if su la base de datos se abrio
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            // Inprimimos la accion  para mas facil identificar donde esta el erro+r
            print("Error al abrir la base de datos0")
            return nil
        }
        else{
            // mandamos un mensaje si se logra abrir
            print("Base de datos abierta en \(dbPath)")
            return db // regresa la base de datos echa
            
        }
    }// llave dek open
    /*
    Esta es la funcion donde me crea la
    tabla de nuestra base de datos
    */
   func CreateTable(){
       // aqui ejecutamos nuestro query de create con nuestos campos y sus valores
       let CreateTable : String = "CREATE TABLE IF NOT EXISTS usuario(IdUsr INTEGER, nombre TEXT, correo TEXT )"
       // creamos nuestro apuntador que sera el que nos ayude aver si se logra crear
       var apuntadorTabla : OpaquePointer? = nil
       // hacemos nuestra decicion de nuestra db para ver si se logra crear la tabla
       if sqlite3_prepare_v2(db, CreateTable, -1, &apuntadorTabla, nil) == SQLITE_OK{
           // ponemos en la deccion nuestro apuntador
           if sqlite3_step(apuntadorTabla) == SQLITE_DONE{
               print("Tabla de USUARIO creada")// mensaje
           }else{
               print("No se pudo crear la tabla")// mensaje
           }
       }else{
           print("No se pudo preparar Creacion de tabla")
       }
       sqlite3_finalize(apuntadorTabla)// finaliza el apuntador la funcion
   }// llave de create
    
    //Crearemos la funcion Insert
    func Insert(idUsr: Int, nombre : String, correo: String){
        //                                                                             1  2  3
        let sentencia : String = "INSERT into usuario(IdUsr, nombre, correo) VALUES(?, ?, ?)"
        // ejecutamos nuestro query
        var apuntadorInsert : OpaquePointer? = nil
        // creamos la selecion de nuestros valores y la pocicon que tendran para validar si se agrego
        if sqlite3_prepare_v2(db, sentencia, -1, &apuntadorInsert, nil) == SQLITE_OK{
            sqlite3_bind_int(apuntadorInsert, 1, Int32(idUsr))
            sqlite3_bind_text(apuntadorInsert, 2, (nombre as NSString).utf8String, -1, nil)
            sqlite3_bind_text(apuntadorInsert, 3, (correo as NSString).utf8String, -1, nil)
            // ejecutamos nuestro if para ver si se agrego
            if sqlite3_step(apuntadorInsert)==SQLITE_DONE{
                print("Se inserto el Usuario")//mensaje
            }else{
                print("Error no se pudo insterar el Usuario")//mensaje
            }
        }else{
            print("El Insert no se pudo preparar")//mensaje
        }
        sqlite3_finalize(apuntadorInsert)// finaliza el apuntador la funcion
    }// llave de insert
    
    
    // creamos nuestra funcion consultar pero solo un producto
    // para eso recivimos los parametros de la funcion
    
    func ConsultaById(correo:  String) -> Usuario {
        // creamos nuestro query y especificamos por que campo lo vamos a buscar
        let select = "SELECT * FROM producto WHERE correo=\(correo);"
        var apuntadorSelect : OpaquePointer? = nil
        //Declaramos un arreglo vacio de productos
        var usuario : Usuario
       //validamos  lo mismo que en el select para detectar el error
        usuario = Usuario(idUsuario: 0, nom: "", cor: "")
        if sqlite3_prepare_v2(db, select, -1, &apuntadorSelect, nil) == SQLITE_OK{
            if sqlite3_step(apuntadorSelect) == SQLITE_ROW {
            let id =  sqlite3_column_int(apuntadorSelect, 0)
            let nom = String(describing: String(cString: sqlite3_column_text(apuntadorSelect,1)))
            let corr = String(describing: String(cString: sqlite3_column_text(apuntadorSelect,2)))
            usuario = Usuario(idUsuario: Int(id), nom: nom, cor: corr)
           }
        }else{
            print("El select no se pudo preparar")
        }
        sqlite3_finalize(apuntadorSelect)// finaliza la funcion
        return usuario// regresa el valor de los datos que pedimos
        
    }
    
    
    
}// llave final
