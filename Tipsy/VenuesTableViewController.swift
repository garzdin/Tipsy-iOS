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

class VenuesTableViewController: UITableViewController, FBSDKSharingDelegate {
    
    var venues: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                print(user.displayName)
            } else {
                
            }
        }
        getData()
    }
    
    func setupTitle() {
        let logoImage = UIImageView(frame: CGRect(x:0, y:0, width: 87, height: 37))
        logoImage.contentMode = .ScaleAspectFit
        let logo = UIImage(named: "Logo")
        logoImage.image = logo
        self.navigationItem.titleView = logoImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "venueDetails" {
            let viewController: VenueDetailsViewController = segue.destinationViewController as! VenueDetailsViewController
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
            }
        }
        // Pass the selected object to the new view controller.
    }
    
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

    @IBAction func logoutAction(sender: UIBarButtonItem) {
        FBSDKLoginManager().logOut()
        try! FIRAuth.auth()?.signOut()
        UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        
    }
    
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
}
