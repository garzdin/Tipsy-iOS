//
//  AlertViewController.swift
//  Tipsy
//
//  Created by Teodor on 01/06/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import FBSDKShareKit

class AlertViewController: UIViewController, FBSDKSharingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Cancle action
    
    @IBAction func cancleAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Share action
    
    @IBAction func shareAction(sender: UIButton) {
        let content = FBSDKShareLinkContent()
        content.contentDescription = "Tipsy has great offers on beer"
        content.placeID = "267091300008193"
        let dialog = FBSDKShareDialog()
        dialog.shareContent = content
        dialog.delegate = self
        dialog.fromViewController = self
        dialog.mode = .Automatic
        dialog.show()
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        
    }
}
