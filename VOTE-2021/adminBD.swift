//
//  adminBD.swift
//  VOTE-2021
//
//  Created by Luis Alfonso Ramirez on 16/11/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//
import Foundation // importamos las funciones
import SQLite3 // importamos la base de datos Sqlite

class adminBD{
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
    }
    /*
    Esta es la funcion donde me crea la
    tabla de nuestra base de datos
    */
   func CreateTable(){
       // aqui ejecutamos nuestro query de create con nuestos campos y sus valores
       let CreateTable : String = "CREATE TABLE IF NOT EXISTS casilla(idCasilla INTEGER, NomCasilla TEXT, latitud TEXT, longitud TEXT)"
       // creamos nuestro apuntador que sera el que nos ayude aver si se logra crear
       var apuntadorTabla : OpaquePointer? = nil
       // hacemos nuestra decicion de nuestra db para ver si se logra crear la tabla
       if sqlite3_prepare_v2(db, CreateTable, -1, &apuntadorTabla, nil) == SQLITE_OK{
           // ponemos en la deccion nuestro apuntador
           if sqlite3_step(apuntadorTabla) == SQLITE_DONE{
               print("Tabla de casilla creada")// mensaje
           }else{
               print("No se pudo crear la tabla")// mensaje
           }
       }else{
           print("No se pudo preparar Creacion de tabla")
       }
       sqlite3_finalize(apuntadorTabla)// finaliza el apuntador la funcion
   }

    func Insert(idCasilla: Int, nomCasilla : String, latitud: String, longitud: String ){
        //                                                                             1  2  3
        let sentencia : String = "INSERT into producto(idCasilla, NomCasilla, latitud, longitud) VALUES(?, ?, ?, ?)"
        // ejecutamos nuestro query
        var apuntadorInsert : OpaquePointer? = nil
        // creamos la selecion de nuestros valores y la pocicon que tendran para validar si se agrego
        if sqlite3_prepare_v2(db, sentencia, -1, &apuntadorInsert, nil) == SQLITE_OK{
            sqlite3_bind_int(apuntadorInsert, 1, Int32(idCasilla))
            sqlite3_bind_text(apuntadorInsert, 2, (nomCasilla as NSString).utf8String, -1, nil)
            sqlite3_bind_text(apuntadorInsert, 3, (latitud as NSString).utf8String, -1, nil)
            sqlite3_bind_text(apuntadorInsert, 4, (longitud as NSString).utf8String, -1, nil)
            // ejecutamos nuestro if para ver si se agrego
            if sqlite3_step(apuntadorInsert)==SQLITE_DONE{
                print("Se inserto la casilla")//mensaje
            }else{
                print("Error no se pudo insterar la casilla")//mensaje
            }
        }else{
            print("El Insert np se pudo preparar")//mensaje
        }
        sqlite3_finalize(apuntadorInsert)// finaliza el apuntador la funcion
    }
    
    // nuestra funcion de consultar
    func Consulta() -> [Casilla]{
        // ejecutamos nuestro select para que nos selecione todos los datos de la tabla
        let select = "SELECT * FROM casilla;"
        var apuntadorSelect : OpaquePointer? = nil
        //Declaramos un arreglo vacio de productos
        var casillas : [Casilla] = []
        // volvemos a validar como en las demas funciones
        if sqlite3_prepare_v2(db, select, -1, &apuntadorSelect, nil) == SQLITE_OK{
            while sqlite3_step(apuntadorSelect) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(apuntadorSelect, 0)))
                let nom = String(describing: String(cString: sqlite3_column_text(apuntadorSelect, 1)))
                let lati = String(describing: String(cString: sqlite3_column_text(apuntadorSelect, 2)))
                let long = String(describing: String(cString: sqlite3_column_text(apuntadorSelect, 2)))
                casillas.append(Casilla(idCas: id, nomCas: nom, lat: lati, long: long))
            }
        }else{
            print("El select no se pudo preparar")// nos manda el mensaje si no se ejecuta
        }
        sqlite3_finalize(apuntadorSelect)// finaliza la funcion
        return casillas// regresa todos los valores de la bd
    }
    
    
}
