//
//  PlayerViewController.swift
//  DownloadTest
//
//  Created by David on 15/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: AVPlayerViewController
{

    var videoPlay : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent(videoPlay)

        let player = AVPlayer(url: myurl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
