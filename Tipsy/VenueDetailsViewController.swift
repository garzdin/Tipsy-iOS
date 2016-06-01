//
//  VenueDetailsViewController.swift
//  Tipsy
//
//  Created by Teodor on 01/06/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import MapKit
import FBSDKShareKit

class VenueDetailsViewController: UIViewController, FBSDKSharingDelegate {
    
    var drinks: Int = 0
    
    var venueName: String = ""
    var venueMessage: String = ""
    var venueAddress: String = ""
    var venueTimes: String = ""
    var venueMusic = ""
    var venueFavorited: Bool = false

    var favorited: Bool = false
    @IBOutlet var venueLabelName: UILabel!
    @IBOutlet var venueLabelMessage: UILabel!
    @IBOutlet var venueLabelAddress: UILabel!
    @IBOutlet var venueLabelTimes: UILabel!
    @IBOutlet var venueLabelMusic: UILabel!
    @IBOutlet var venueMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeData()
        self.getPinFromAddress()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Initialize data
    
    func initializeData() {
        self.venueLabelName.text = venueName
        self.venueLabelMessage.text = venueMessage
        self.venueLabelAddress.text = venueAddress
        self.venueLabelTimes.text = venueTimes
        self.venueLabelMusic.text = venueMusic
        self.favorited = venueFavorited
    }
    
    // MARK: - Geocode reverse address
    
    func getPinFromAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.venueAddress) { (placemarks: [CLPlacemark]?, error: NSError?) in
            if let placemark = placemarks![0] as CLPlacemark? {
                self.venueMapView.addAnnotation(MKPlacemark(placemark: placemark))
                self.venueMapView.setRegion(MKCoordinateRegion(center: (placemark.location?.coordinate)!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
            }
        }
    }
    
    // MARK: - Favorite action

    @IBAction func favoriteAction(sender: UIButton) {
        if(favorited) {
            favorited = false
            sender.setImage(UIImage(named: "NotFavorited"), forState: .Normal)
        } else {
            favorited = true
            sender.setImage(UIImage(named: "Favorited"), forState: .Normal)
        }
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
        self.drinks += 1
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
