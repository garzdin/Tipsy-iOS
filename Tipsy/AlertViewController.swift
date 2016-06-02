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
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var cancleButton: UIButton!
    @IBOutlet var shareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeaderView()
        self.setupCancleButton()
        self.setupShareButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup header view
    
    func setupHeaderView() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.headerView.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.TopRight), cornerRadii: CGSizeMake(5, 5)).CGPath
        self.headerView.layer.mask = maskLayer
    }
    
    // MARK: - Setup cancle button
    
    func setupCancleButton() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.cancleButton.bounds, byRoundingCorners: UIRectCorner.BottomLeft, cornerRadii: CGSizeMake(5, 5)).CGPath
        self.cancleButton.layer.mask = maskLayer
    }
    
    // MARK: - Setup share button
    
    func setupShareButton() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.shareButton.bounds, byRoundingCorners: UIRectCorner.BottomRight, cornerRadii: CGSizeMake(5, 5)).CGPath
        self.shareButton.layer.mask = maskLayer
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
