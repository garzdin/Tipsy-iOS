//
//  KeypadViewController.swift
//  Tipsy
//
//  Created by Teodor on 01/06/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

protocol CombinationCheckDelegate: class {
    func didEnterRightCode(sender: KeypadViewController)
}

class KeypadViewController: UIViewController {
    
    var buttonArray: [Int] = []
    let correctCode = "9653"
    
    weak var delegate: CombinationCheckDelegate?

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
        self.setupButtonTags()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup button tags
    
    func setupButtonTags() {
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

    // MARK: - Combination check
    
    func checkArray() {
        if buttonArray.count == 4 {
            let codeToArray = self.correctCode.characters.map{Int(String($0))!}
            if buttonArray == codeToArray {
                self.navigationController?.popViewControllerAnimated(true)
                delegate?.didEnterRightCode(self)
            } else {
                self.dialContainer.layer.shake()
            }
            buttonArray = []
        }
    }
    
    // MARK: - Keypress mapper
    
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
}
