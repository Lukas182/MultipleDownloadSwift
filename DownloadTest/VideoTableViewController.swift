//
//  VideoTableViewController.swift
//  DownloadTest
//
//  Created by David on 15/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController
{
    
    var infoCoche = CarData()

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
