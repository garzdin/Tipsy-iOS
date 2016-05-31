//
//  ViewController.swift
//  Tipsy
//
//  Created by Teodor on 30/05/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var loginButton: FBSDKLoginButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGradient()
        loginButtonVisibility()
        self.loginButton.delegate = self
    }
    
    func setupGradient() {
        let topColor = UIColor(red: 104.0/255.0, green: 0.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 60.0/255.0, green: 0.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [CGFloat] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    func loginButtonVisibility() {
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if user != nil {
                self.loginButton.hidden = true
            } else {
                self.activityIndicator.hidden = true
                self.activityIndicator.stopAnimating()
                self.loginButton.hidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        self.loginButton.hidden = true
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if let token = FBSDKAccessToken.currentAccessToken() {
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(token.tokenString)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out.") 
    }
}

