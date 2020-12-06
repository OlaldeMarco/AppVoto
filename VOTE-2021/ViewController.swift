//
//  ViewController.swift
//  VOTE-2021
//
//  Created by Marco Antonio Olalde on 31/10/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var Casillas = [Casilla]()
    var Usuarios = [Usuario]()
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let jsonclass = JsonClass()
    let db: UsuarioBD = UsuarioBD()// manda llamar la bd
    @IBAction func btnRegistrar(_ sender: UIButton) {
        if txtNombre.text!.isEmpty || txtCorreo.text!.isEmpty || txtPassword.text!.isEmpty{
            alerta(title: "Error", message: "Faltan datos de entrada")
            txtNombre.becomeFirstResponder()
            return
        }
        else{
            let nom = txtNombre.text
            let correo = txtCorreo.text
            let password = txtPassword.text
            let datosEnviar = ["nombre": nom!, "correo": correo!,"contraseña": password!] as NSMutableDictionary
            jsonclass.arrayFromJson(url: "WSVoto/insertUsuario.php", datos_enviados: datosEnviar)
            {
                (array_respuesta) in
                DispatchQueue.main.async {
                    let arregloDatos = array_respuesta?.object(at: 0) as! NSDictionary
                    if let suc = arregloDatos.object(forKey: "succes") as! String?{
                        if suc == "200"{
                            let db: UsuarioBD = UsuarioBD()// manda llamar la bd
                            // insertar informacion del usuario  en sqlite
                            db.Insert(idUsr: 0, nombre: nom!, correo: correo!)
                            self.alerta(title: "agrego", message: "")
                            self.performSegue(withIdentifier: "segue1", sender: self)
                            
                       }
                    }
                    self.txtNombre.text = ""
                    self.txtCorreo.text = ""
                    self.txtPassword.text = ""
            }
        }
      }
        
    self.performSegue(withIdentifier: "segue1", sender: self)

 }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1"{
            let TVCasilla = segue.destination as! TableViewController
            TVCasilla.Casillas = self.Casillas
            
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let idp = (txtCorreo.text!)
        let prod : Usuario = db.ConsultaById(correo: idp)
      
        alerta(title: "usurio", message: prod.nombre)
        self.performSegue(withIdentifier: "segue1", sender: self)
        
        
        // lanzar una busqueda en la tabla de usuario de sqlite
    }
    
    func alerta (title: String, message: String){
        //Crea una alerta
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Agrega un boton
        alert.addAction(UIAlertAction(title: "Aceptar",style: UIAlertAction.Style.default, handler: nil))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
}

