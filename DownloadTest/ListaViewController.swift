//
//  ListaViewController.swift
//  DownloadTest
//
//  Created by David on 15/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import CoreData

class ListaViewController: UITableViewController {

    var DatosCars = [CarData]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Cargamos los datos de los coches desde CoreData
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject]
            {
                
                let nombre = result.value(forKey: "nombre") as? String
                let nvideos = result.value(forKey: "nvideos") as? Int
                let id = result.value(forKey: "id") as? Int
                
                let c1 = CarData()
                
                c1.id_Coche = id!
                c1.Nombre = nombre
                c1.nVideos = nvideos!
                
                DatosCars.append(c1)
                
            }
            
            tableView.reloadData()
            
            // Añadimos los videos que tiene cada coche al array de datos
            
            for c in DatosCars
            {
                let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Videos")
                
                request1.predicate = NSPredicate.init(format: "id_car == %d", c.id_Coche)
                
                do
                {
                    
                    let results = try context.fetch(request1)
                    
                    for result in results as! [NSManagedObject]
                    {
                        
                        let video = result.value(forKey: "video_path") as? String
                        
                        c.AddVideo(str: video!)
                        
                    }
                    
                }
                catch
                {
                    
                }
                
            }
            
        }
        catch
        {
            
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DatosCars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! ListaViewCell
        
        cell.NombreCar.text = DatosCars[indexPath.row].Nombre

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 97.0
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            
            let vtView = segue.destination as! VideoTableViewController
            
            vtView.infoCoche = DatosCars[indexPath.row]
            
        }
        
        
        
        
    }
    

}
