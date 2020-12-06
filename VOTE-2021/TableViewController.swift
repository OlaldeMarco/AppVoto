//
//  TableViewController.swift
//  VOTE-2021
//
//  Created by clau93 on 16/11/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    public var Casillas = [Casilla]()
    @IBOutlet var Tabla: UITableView!
    let jsonclass = JsonClass()
    
    @IBAction func btnCargar(_ sender: UIBarButtonItem) {
        Casillas.removeAll()
                 let datosEntrada = ["id":""] as NSMutableDictionary
                 jsonclass.arrayFromJson(url: "WSVoto/getCasillas.php", datos_enviados: datosEntrada){
                     (array_respuestas ) in
                     DispatchQueue.main.async {
                         let NoCasillas = array_respuestas?.count
                         for i in stride(from: 0, to: NoCasillas!, by: 1){
                             let casilla = array_respuestas?.object(at: i) as! NSDictionary
                             let idCas = casilla.object(forKey:"id_Casilla") as! String?
                             let nomCas = casilla.object(forKey:"nombre_Casilla") as! String?
                             let lat = casilla.object(forKey:"latitud") as! String?
                             let long = casilla.object(forKey:"longitud") as! String?
                            self.Casillas.append(Casilla(idCas: idCas!, nomCas: nomCas!, lat: lat!, long: long!))
                         }
                     }
                 }
             }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Casillas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda") as! TableViewCell

        let cas : Casilla
        cas = Casillas[indexPath.row]
        cell.lblTitulo.text = cas.nombre_Casilla
        cell.lblDescripcion.text = cas.latitud
  

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
