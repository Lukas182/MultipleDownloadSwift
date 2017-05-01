//
//  CarData.swift
//  DownloadTest
//
//  Created by David on 22/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class CarData: NSObject
{

    var id_Coche = Int()
    var Nombre : String! // Nombre del Coche
    var Videos : [String] = [] // Direcciones de memoría donde estan almacenados los videos
    var nVideos = Int()
    
    func SetNVideos(i: Int)
    {
        nVideos = i
    }
    
    func SetNombre(str : String)
    {
        Nombre = str
    }
    
    func SetId(i : Int)
    {
        id_Coche = i
    }

    func AddVideo(str : String)
    {
        Videos.append(str)
    }
    

    
}
