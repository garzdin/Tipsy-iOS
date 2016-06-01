//
//  KeypadViewController.swift
//  Tipsy
//
//  Created by Teodor on 01/06/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

extension CALayer {
    
    func shake(duration: NSTimeInterval = NSTimeInterval(0.5)) {
        
        let animationKey = "shake"
        removeAnimationForKey(animationKey)
        
        let kAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        kAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        kAnimation.duration = duration
        
        var needOffset = CGRectGetWidth(frame) * 0.15,
        values = [CGFloat]()
        
        let minOffset = needOffset * 0.1
        
        repeat {
            
            values.append(-needOffset)
            values.append(needOffset)
            needOffset *= 0.5
        } while needOffset > minOffset
        
        values.append(0)
        kAnimation.values = values
        addAnimation(kAnimation, forKey: animationKey)
    }
}

class KeypadViewController: UIViewController {
    
    var buttonArray: [Int] = []
    let correctCode = "9653"

    @IBOutlet var dialContainer: UIView!
    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    @IBOutlet var buttonFour: UIButton!
    @IBOutlet var buttonFive: UIButton!
    @IBOutlet var buttonSix: UIButton!
    @IBOutlet var buttonSeven: UIButton!
    @IBOutlet var buttonEight: UIButton!
    @IBOutlet var buttonNine: UIButton!
    @IBOutlet var buttonZero: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonOne.tag = 1
        buttonTwo.tag = 2
        buttonThree.tag = 3
        buttonFour.tag = 4
        buttonFive.tag = 5
        buttonSix.tag = 6
        buttonSeven.tag = 7
        buttonEight.tag = 8
        buttonNine.tag = 9
        buttonZero.tag = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkArray() {
        if buttonArray.count == 4 {
            let codeToArray = self.correctCode.characters.map{Int(String($0))!}
            if buttonArray == codeToArray {
                // Right combination
            } else {
                self.dialContainer.layer.shake()
            }
            
            buttonArray = []
        }
    }
    
    @IBAction func keypadPress(sender: UIButton) {
        switch sender.tag {
        case 1: buttonArray.append(1); checkArray()
            break
        case 2: buttonArray.append(2); checkArray()
            break
        case 3: buttonArray.append(3); checkArray()
            break
        case 4: buttonArray.append(4); checkArray()
            break
        case 5: buttonArray.append(5); checkArray()
            break
        case 6: buttonArray.append(6); checkArray()
            break
        case 7: buttonArray.append(7); checkArray()
            break
        case 8: buttonArray.append(8); checkArray()
            break
        case 9: buttonArray.append(9); checkArray()
            break
        case 0: buttonArray.append(0); checkArray()
            break
        default: checkArray()
            break
        }
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
