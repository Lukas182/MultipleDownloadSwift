//
//  ViewController.swift
//  DownloadTest
//
//  Created by David on 22/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import CoreData
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var ViewPlay: UIView!
    var player : AVPlayer?
    
    var DatosCars = [CarData]()
    let queue1:DispatchQueue = DispatchQueue(label: "com.david.queue1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")

        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            if(results.count == 0)
            {
                print("No Data")
                
                // Creo un coche nuevo
                
                let ca = NSEntityDescription.insertNewObject(forEntityName: "Car", into: context)
                
                ca.setValue("AudiTT", forKey: "nombre")
                ca.setValue(1, forKey: "id")
                ca.setValue(2, forKey: "nvideos")
                
                do
                {
                    try context.save()
                    print("Almaceno un dato de prueba")
                }
                catch
                {
                    
                }
            }
            else
            {
                print("Hay data")
                
                /*for result in results as! [NSManagedObject]
                {
                    
                    let nombre = result.value(forKey: "nombre") as? String
                    let nvideos = result.value(forKey: "nvideos") as? Int
                    let id = result.value(forKey: "id") as? Int
                    
                    self.ComprobarVideosCoche(id_c: id!, nv: nvideos!,nom: nombre!)
                    
                }*/
                
            }
        }
        catch
        {
            
        }
        
    }
    
    @IBAction func CheckUp(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        
        request.returnsObjectsAsFaults = false

        
        do
        {
            let results = try context.fetch(request)
            
            if results.count>0
            {
                for result in results as! [NSManagedObject]
                {
                    
                    let nombre = result.value(forKey: "nombre") as? String
                    let nvideos = result.value(forKey: "nvideos") as? Int
                    let id = result.value(forKey: "id") as? Int
                    
                    self.ComprobarVideosCoche(id_c: id!, nv: nvideos!,nom: nombre!)
                    
                }
            }
        }
        catch
        {
            
        }
    }
    
    func ComprobarVideosCoche(id_c: Int, nv: Int,nom: String)
    {
        
        // Comprobamos si estan descargados todos los videos de ese coche
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Videos")
        
        request.predicate = NSPredicate.init(format: "id_car == %d", id_c)
        
        do
        {
            let results = try context.fetch(request)
            
            if( nv > results.count)
            {
                var nVideosADescargar = nv - results.count
                
                nVideosADescargar = nVideosADescargar - 1
                
                var urlArray : [String] = [String]()
                
                urlArray.append("http://www.html5videoplayer.net/videos/toystory.mp4")
                urlArray.append("https://www.quirksmode.org/html5/videos/big_buck_bunny.mp4")
                urlArray.append("http://techslides.com/demos/sample-videos/small.mp4")
                
                self.queue1.sync
                {
                    DownloadManager.sharedInstance.DownloadFiles(urlArray: urlArray,id_c: id_c)
                }
                
            }
            else
            {
                print("Videos actualizados")
                
                //:D
                
                print(results.count)
                
                
                let path = (results[2] as AnyObject).value(forKey: "video_path") as? String
                
                let fm = FileManager.default
                let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let myurl = docsurl.appendingPathComponent(path!)
                
                let player = AVPlayer(url: myurl)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.view.bounds
                self.view.layer.addSublayer(playerLayer)
                player.play()
                
                /*
                for result in results as! [NSManagedObject]
                {
                    
                    //let path = result.value(forKey: "video_path") as? String
                    
                    /*
                    let fm = FileManager.default
                    let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let myurl = docsurl.appendingPathComponent(path!)
                    
                    let player = AVPlayer(url: myurl)
                    let playerLayer = AVPlayerLayer(player: player)
                    playerLayer.frame = self.view.bounds
                    self.view.layer.addSublayer(playerLayer)
                    player.play()
                     */
                    
                }
                */
                
            }
        }
        catch
        {
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}

