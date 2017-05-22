//
//  VideoTableViewController.swift
//  DownloadTest
//
//  Created by David on 15/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import CoreData

class VideoTableViewController: UITableViewController
{
    
    var infoCoche = CarData()

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.Noti), name: NSNotification.Name(rawValue: "Noti") , object: nil)
       
    }
    
    func Noti()
    {
        print("Notificaaaaado")
        
        infoCoche.Videos.removeAll()
        
        // Cargamos los nuevos videos que aparecen
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Videos")
        
        request1.predicate = NSPredicate.init(format: "id_car == %d", infoCoche.id_Coche)
        
        do
        {
            
            let results = try context.fetch(request1)
            
            for result in results as! [NSManagedObject]
            {
                
                let video = result.value(forKey: "video_path") as? String
                
                infoCoche.AddVideo(str: video!)
                
            }
            
        }
        catch
        {
            
        }
        
        self.tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return infoCoche.Videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaVideoCell", for: indexPath) as! VideoViewCell

        cell.VideoName.text = infoCoche.Videos[indexPath.row]

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            
            let playerV = segue.destination as! PlayerViewController
            
            playerV.videoPlay = infoCoche.Videos[indexPath.row]
            
        }
        
        
    }
    

}
