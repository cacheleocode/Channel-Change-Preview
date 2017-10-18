//
//  ChannelViewController.swift
//  Channel Change Preview
//
//  Created by DOMINGUEZ, LEO on 10/17/17.
//  Copyright © 2017 DOMINGUEZ, LEO. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var logoView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // logoView.frame.origin.x = 200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func doShow() {
        print("now what")
        
        /*
        UIView.animate(withDuration: 0.3, animations: {
            self.logoView?.frame.origin.x = 852
        }, completion: nil)
         */
    }
    
    func doHide() {
        /*
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0.0
        }, completion: nil)
        */
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
