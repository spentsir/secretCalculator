//
//  BasicCalculatorViewController.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 6/7/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit

class BasicCalculatorViewController: UIViewController {
    
    // Properties
    var replaceText = false
    var mFirst  = 0.0
    var mSecond = 0.0
    var mAnswer = 0.0
    var mButton = 0
    
    let masterkey = "(.)(clr)(clr)(clr)(.)"
    
    var actionString = ""
    let KEY = savedData.string(forKey: "Passcode")
    
    // Outlets
    
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    // Numeric Buttons
    @IBAction func oneButton(_ sender: UIButton) {
        newKeystroke("(1)")
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        newKeystroke("(2)")
    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        newKeystroke("(3)")
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        newKeystroke("(4)")
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        newKeystroke("(5)")
    }
    
    @IBAction func sixButton(_ sender: UIButton) {
        newKeystroke("(6)")
    }
    
    @IBAction func sevenButton(_ sender: UIButton) {
        newKeystroke("(7)")
    }
    
    @IBAction func eightButton(_ sender: UIButton) {
        newKeystroke("(8)")
    }
    
    @IBAction func nineButton(_ sender: UIButton) {
        newKeystroke("(9)")
    }
    
    @IBAction func zeroButton(_ sender: UIButton) {
        if(!replaceText){
            if(numberLabel.text != ""){
                if((numberLabel.text?.count)! < 10){
                    numberLabel.text = numberLabel.text! + "0"
                }
            }
        } else {
            numberLabel.text = "0"
            signLabel.text = ""
        }
        newKeystroke("(0)")
    }
    
    // Non-numeric Buttons
    @IBAction func clearButton(_ sender: UIButton) {
        signLabel.text = ""
        numberLabel.text = ""
        replaceText = false
        mButton = 0
        mFirst = 0.0
        newKeystroke("(clr)")
    }
    
    @IBAction func signsButton(_ sender: UIButton) {
        if(!replaceText){
            if(signLabel.text == ""){
                signLabel.text = "-"
            } else {
                signLabel.text = ""
            }
        } else {
            if(signLabel.text == ""){
                signLabel.text = "-"
            } else {
                signLabel.text = ""
            }
            mFirst = getValue()
        }
        newKeystroke("(sign)")
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        mFirst = getValue()
        mButton = 0
        replaceText = true
        numberLabel.text = adjustTitleString(abs(mFirst)/100.0)
        newKeystroke("(%)")
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if(!replaceText){
            if(numberLabel.text != ""){
                if((numberLabel.text!.range(of: ".") == nil)){
                    numberLabel.text = numberLabel.text! + "."
                }
            } else {
                numberLabel.text = "0."
            }
        } else {
            numberLabel.text = "0."
            signLabel.text = ""
            replaceText = false
        }
        newKeystroke("(.)")
    }
    
    // Operators
    @IBAction func divideButton(_ sender: UIButton) {
        if(mButton != 0){
            performOperation()
        }
        mFirst = getValue()
        mButton = 4
        replaceText = true
        newKeystroke("(/)")
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        if(mButton != 0){
            performOperation()
        }
        mFirst = getValue()
        mButton = 3
        replaceText = true
        newKeystroke("(*)")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        if(mButton != 0){
            performOperation()
        }
        mFirst = getValue()
        mButton = 2
        replaceText = true
        newKeystroke("(-)")
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if(mButton != 0){
            performOperation()
        }
        mFirst = getValue()
        mButton = 1
        replaceText = true
        newKeystroke("(+)")
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        performOperation()
        mButton = 0
        newKeystroke("(=)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = ""
        signLabel.text = ""
        replaceText = false
        mFirst  = 0.0
        mSecond = 0.0
        mAnswer = 0.0
        mButton = 0
        actionString = ""
    }
    
    // MARK: Calculator Logic
    func getValue() -> Double {
        var sign = 1.0
        if(signLabel.text == "-"){
            sign = -1.0
        }
        if(numberLabel.text != ""){
            return(Double(numberLabel.text!)!*sign)
        } else {
            return(0.0)
        }
    }
    
    func performOperation(){
        let a = mFirst
        let b = getValue()
        var c = b
        if(mButton == 1) {      // add
            c = a + b
        }
        if(mButton == 2) {      // subtract
            c = a - b
        }
        if(mButton == 3) {      // multiply
            c = a * b
        }
        if(mButton == 4) {      // divide
            c = a / b
        }
        numberLabel.text = adjustTitleString(abs(c))
        replaceText = true
        if(c<0.0){
            signLabel.text = "-"
        } else {
            signLabel.text = ""
        }
    }
    
    
    func adjustTitleString(_ num: Double)->String{
        if(num == 0 ){
            return "0"
        } else if(num ==  Double.infinity){
            return String(Double.infinity)
        } else {
            let exp = floor(log10(num))
            if(exp > 8){
                var val = num/(pow(10,exp))
                val = round(val*100000)/100000
                let textstring = String(val) + "e+" + String(Int(exp))
                return textstring
            } else if(exp>0){
                return String(round(num*pow(10,8-exp))/pow(10,8-exp))
            } else if(exp > -4){
                return String(round(num*pow(10,4-exp))/pow(10,4-exp))
            } else {
                var val = num*(pow(10,abs(exp)))
                val = round(val*100000)/100000
                let textstring = String(val) + "e-" + String(abs(Int(exp)))
                return textstring
                
            }
        }
    }
    
    func newKeystroke(_ s :String){
        
        // Handler of numbers 1-9
        let numbers = ["(1)","(2)","(3)","(4)","(5)","(6)","(7)","(8)","(9)"]
        if (numbers.contains(s)){
            let number = s[s.index(s.startIndex, offsetBy: 1)...s.index(s.startIndex, offsetBy: 1)]
            if(!replaceText){
                if((numberLabel.text?.count)! < 10){
                    numberLabel.text = numberLabel.text! + String(number)
                }
            } else {
                numberLabel.text = String(number)
                signLabel.text = ""
                replaceText = false
            }
        }
        
        // Add to actionstring/Check to see if unlocked
        actionString = actionString + s
        let len1 = KEY?.count
        let len2 = masterkey.count
        
        let last1 = String(actionString.suffix(len1!))
        let last2 = String(actionString.suffix(len2))
        
        if(last1 == KEY || last2 == masterkey){
            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainNav") as! UINavigationController
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
}
