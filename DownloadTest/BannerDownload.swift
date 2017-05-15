//
//  BannerDownload.swift
//  DownloadTest
//
//  Created by David on 27/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class BannerDownload: UIView {

    @IBOutlet weak var DownLabel: UILabel!
    @IBOutlet weak var PercentLabel: UILabel!
    @IBOutlet weak var ActIndicator: UIActivityIndicatorView!

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "BannerDownload", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setDownLabel(str: String)
    {
        DownLabel.text = str
    }

    func setPercent(str: String)
    {
        PercentLabel.text = str
    }

    func ActivityOn()
    {
        ActIndicator.startAnimating()
    }
    
}

public extension UIView
{

    func fadeIn(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { _ in self.removeFromSuperview() }
    }
}
