//
//  VenueDetailsViewController.swift
//  Tipsy
//
//  Created by Teodor on 01/06/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import MapKit

class VenueDetailsViewController: UIViewController {
    
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
        // Do any additional setup after loading the view.
        setupTitle()
        initializeData()
        getPinFromAddress()
    }
    
    func initializeData() {
        self.venueLabelName.text = venueName
        self.venueLabelMessage.text = venueMessage
        self.venueLabelAddress.text = venueAddress
        self.venueLabelTimes.text = venueTimes
        self.venueLabelMusic.text = venueMusic
        self.favorited = venueFavorited
    }
    
    func setupTitle() {
        let logoImage = UIImageView(frame: CGRect(x:0, y:0, width: 87, height: 37))
        logoImage.contentMode = .ScaleAspectFit
        let logo = UIImage(named: "Logo")
        logoImage.image = logo
        self.navigationItem.titleView = logoImage
    }
    
    func getPinFromAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.venueAddress) { (placemarks: [CLPlacemark]?, error: NSError?) in
            if let placemark = placemarks![0] as CLPlacemark? {
                self.venueMapView.addAnnotation(MKPlacemark(placemark: placemark))
                self.venueMapView.setRegion(MKCoordinateRegion(center: (placemark.location?.coordinate)!, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}