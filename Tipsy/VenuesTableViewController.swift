//
//  VenuesTableViewController.swift
//  Tipsy
//
//  Created by Teodor on 31/05/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class VenuesTableViewController: UITableViewController, FBSDKSharingDelegate, CombinationCheckDelegate, DrinksCountDelegate {
    
    var venues: [AnyObject] = []
    var drinks: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitle()
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup logo title
    
    func setupTitle() {
        let logoImage = UIImageView(frame: CGRect(x:0, y:0, width: 87, height: 37))
        logoImage.contentMode = .ScaleAspectFit
        let logo = UIImage(named: "Logo")
        logoImage.image = logo
        self.navigationItem.titleView = logoImage
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as! VenueTableViewCell
        if let venueName = self.venues[indexPath.row]["name"] as? String {
            cell.venueNameLabel.text = venueName
        }
        if let venueMessage = self.venues[indexPath.row]["message"] as? String {
            cell.venueLabelMessage.text = venueMessage
        }
        if let venueAddress = self.venues[indexPath.row]["address"] as? String {
            cell.venueLabelAddress.text = venueAddress
        }
        if let venueOpening = self.venues[indexPath.row]["openingTime"] as? String, venueClosing = self.venues[indexPath.row]["closingTime"] as? String {
            cell.venueLabelTimes.text = "\(venueOpening) - \(venueClosing)"
        }
        if let venueMusic  = self.venues[indexPath.row]["musicType"] as? String {
            cell.venueLabelMusic.text = venueMusic
        }
        if let venueFavorited = self.venues[indexPath.row]["favoriteStatus"] as? Bool {
            cell.favorited = venueFavorited
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 263.0
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "venueDetails" {
            let viewController: VenueDetailsViewController = segue.destinationViewController as! VenueDetailsViewController
            viewController.delegate = self
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let venueName = self.venues[indexPath.row]["name"] as? String {
                    viewController.venueName = venueName
                }
                if let venueMessage = self.venues[indexPath.row]["message"] as? String {
                    viewController.venueMessage = venueMessage
                }
                if let venueAddress = self.venues[indexPath.row]["address"] as? String {
                    viewController.venueAddress = venueAddress
                }
                if let venueOpening = self.venues[indexPath.row]["openingTime"] as? String, venueClosing = self.venues[indexPath.row]["closingTime"] as? String {
                    viewController.venueTimes = "\(venueOpening) - \(venueClosing)"
                }
                if let venueMusic  = self.venues[indexPath.row]["musicType"] as? String {
                    viewController.venueMusic = venueMusic
                }
                if let venueFavorited = self.venues[indexPath.row]["favoriteStatus"] as? Bool {
                    viewController.venueFavorited = venueFavorited
                }
                viewController.drinks = self.drinks
            }
        }
        if segue.identifier == "cardToKeypad" {
            let viewController: KeypadViewController = segue.destinationViewController as! KeypadViewController
            viewController.delegate = self
        }
    }
    
    // MARK: - Get data
    
    func getData() {
        if let path = NSBundle.mainBundle().pathForResource("Data", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                if let venuesDict = dict["venues"] as? [AnyObject] {
                    for venue in venuesDict {
                        self.venues.append(venue)
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Logout action

    @IBAction func logoutAction(sender: UIBarButtonItem) {
        FBSDKLoginManager().logOut()
        try! FIRAuth.auth()?.signOut()
        UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
    }
    
    // MARK: - Get drink action
    
    @IBAction func getDrinkAction(sender: UIButton) {
        if drinks >= 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let alertDialog = storyboard.instantiateViewControllerWithIdentifier("AlertViewController")
            alertDialog.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            alertDialog.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(alertDialog, animated: true, completion: nil)
        }
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
    
    // MARK: - Did enter right key code from keypad
    
    func didEnterRightCode(sender: KeypadViewController) {
        self.drinks += 1
    }
    
    // MARK: - Update drinks count from details view
    
    func didUpdateDrinksCount(sender: VenueDetailsViewController, count: Int) {
        self.drinks = count
    }
}
