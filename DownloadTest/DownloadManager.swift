//
//  DownloadManager.swift
//  DownloadTest
//
//  Created by David on 22/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class DownloadManager: NSObject
{

    static let sharedInstance = DownloadManager()

    func DownloadFiles( urlArray : [String],id_c : Int ) -> Void
    {
        
        var urlArray = urlArray
        if let _url = urlArray.popLast()
        {
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            let view = BannerDownload.instanceFromNib()
            
            view.frame = CGRect.init(x: 170, y: 80, width: 390, height: 87)
            view.alpha=0.0
            
            UIApplication.shared.keyWindow?.addSubview(view)
            
            view.fadeIn()
            
            let v = view as! BannerDownload
            v.setDownLabel(str: "Descargando video...")
            v.ActivityOn()
            
            Alamofire.download(_url,to: destination).response { response in
                
                if(response.error == nil)
                {
                    print("Downloaded")
                    
                    let theFileName = URL.init(string: _url)?.lastPathComponent
                    
                    self.saveVideo(vPath: theFileName!, id_c: id_c)
                    
                    self.DownloadFiles(urlArray: urlArray,id_c: id_c)
                    
                    print(response)
                }
                
                } .downloadProgress { progress in
                    
                    let l = progress.fractionCompleted * 100
                    
                    v.setPercent(str: String.init(format: "%0.3f", l))
                    
                    if(l == 100.0)
                    {
                        view.fadeOut()
                    }
                    
                }
        }
        
    }
    
    
    func saveVideo(vPath: String, id_c : Int)
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let video = NSEntityDescription.insertNewObject(forEntityName: "Videos", into: context)
        
        video.setValue(vPath, forKey: "video_path")
        video.setValue(id_c, forKey: "id_car")
        
        do
        {
            try context.save()
            print("Video Saved")
        }
        catch
        {
            
        }
        
        
    }
    
}
