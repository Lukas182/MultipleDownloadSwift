//
//  DataManager.swift
//  DownloadTest
//
//  Created by David on 6/5/17.
//  Copyright © 2017 David. All rights reserved.
//

// Obtención de JSON y codificación y decodificación

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

class DataManager: NSObject
{

    static let sharedInstance = DataManager()
    
    func GetJSon() -> JSON
    {
        // Suponemos que mediante Alamofire accedemos al Servicio web y capturamos el String JSON con codificación SHA1
        
        
        let json: JSON  = ["Coche": "1","Nombre": "Hiunday FXT"]
        /*
        do
        {
            
           
            
        }
        catch
        {
            
        }
        */        
        
        
        return json
    }

    
    
}


