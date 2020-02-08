//
//  Exercise20.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/20.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit
import iOSDropDown
import ReactiveKit

class Exercise20: UIViewController,UITextFieldDelegate  {

    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var formatDropDownn: DropDown!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var playpauseBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var buttonViewContainer: UIView!
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var stateContainerView: UIView!
    @IBOutlet weak var trueLbl: UILabel!
    @IBOutlet weak var trueNum: UILabel!
    @IBOutlet weak var falseLbl: UILabel!
    @IBOutlet weak var falseNum: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var resultString: UILabel!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var problemLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var inputTxt: UITextField!
    
    
    
    
    var timer = Timer()
    var array = [String]()
    var rowNumbers: Int = 1
    var customTimeStep: Float = 1.0
    var selectedExercises = [String]()
    var customColor: UIColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
    var isPlay: Bool = false
    var step: Float = 0
    var TrainTime: Int = 0
    var TrainTimer = Timer()
    
    var isString: Bool = true // text , number
    var isClick: Bool = true // checkBtn click
    var selectedNumberExercise = [Int]()
    var successNum: Int = 0
    var failNum: Int = 0
            
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
     
    var bottomLine = CALayer()
    var selectedString : String  = ""
           
       override func viewDidLoad() {
           super.viewDidLoad()
           selectedString = UserDefaults.standard.string(forKey: "exercise_problem") ?? "First Insert your training sentences. This is the default Sentences. decline globe foggy start learning speed formula crane forming singer song string hiccup system naruto configuration axilliary screen economy desk defence often ancient polics occupy map apple computer mouse"
          
           print(selectedString)
          selectedExercises = selectedString.components(separatedBy: " ")
        for _ in 1...50{
            let k = Int.random(in: 1000...9999)
            print(k)
            self.selectedNumberExercise.append(k)
        }
                
        inputTxt.delegate = self
        self.hideKeyboardWhenTappedAround()

        //
        self.speedSlider.tintColor = customColor
        self.speedSlider.maximumValue = 1.0
        self.speedSlider.minimumValue = 0.0
        self.speedSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

        let k = UserDefaults.standard.integer(forKey: "exercise16_level")
        print(k)
        self.speedSlider.value = Float(k)/100
        self.customTimeStep = 1 - Float(k)/100
        if customTimeStep < 0.03{ customTimeStep = 0.04}
        if self.customTimeStep > 0.8 {self.customTimeStep = 0.8}
        self.speedSlider.setValue(Float(k)/100, animated: true)
              
        step = (self.speedSlider.maximumValue - self.speedSlider.minimumValue )/100
        //
        self.rowNumbers = UserDefaults.standard.integer(forKey: "exercise16_row")
        if self.rowNumbers == 0 {self.rowNumbers = 1}
        dropDown.text = String(self.rowNumbers)
        //
        self.isString = UserDefaults.standard.bool(forKey: "exercise16_isString")
        if self.isString {formatDropDownn.text = "Text"}else{ formatDropDownn.text = "Number"}
        
        //
        playpauseBtn.translatesAutoresizingMaskIntoConstraints = false
        playpauseBtn.centerYAnchor.constraint(equalTo: buttonViewContainer.centerYAnchor).isActive = true
        playpauseBtn.centerXAnchor.constraint(equalTo: buttonViewContainer.centerXAnchor).isActive = true
        playpauseBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playpauseBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        playpauseBtn.layer.cornerRadius = 25
        playpauseBtn.imageView?.contentMode = .scaleAspectFill
        playpauseBtn.layer.backgroundColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        playpauseBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            
        //button shadow
        let size = 50 //playpauseBtn.frame.width
        playpauseBtn.layer.shadowColor = UIColor.black.cgColor
        playpauseBtn.layer.shadowOffset = CGSize(width: 0, height: size / 6)
    //            playpauseBtn.layer.masksToBounds = false
        playpauseBtn.layer.shadowRadius = CGFloat(size / 3)
        playpauseBtn.layer.shadowOpacity = 1
        //
        timeLbl.textColor = #colorLiteral(red: 0.5086903165, green: 0.627606281, blue: 0.2984172636, alpha: 1)
            
        //label
        wordLbl.layer.cornerRadius = 8
        wordLbl.layer.masksToBounds = true

        //image
        one.isHidden = true
        two.isHidden = true
        three.isHidden = true
          
                      
         //dropdown
          
        // The list of array to display. Can be changed dynamically
        dropDown.optionArray = ["1", "2", "3", "4"]
        //Its Id Values and its optional
        dropDown.optionIds = [1,2,3,4]
        dropDown.textAlignment = .center
        dropDown.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        dropDown.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
          dropDown.arrowColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        // The the Closure returns Selected Index and String
        dropDown.didSelect{(selectedText , index ,id) in
            self.dropDown.text = "\(selectedText)"
            self.rowNumbers = Int(selectedText) ?? 1
            self.saveSetting()
//            self.dropDownWillDisappear()
            
        }
        dropDown.isSearchEnable = false
        dropDown.arrowSize = 10
        dropDown.checkMarkEnabled = false
        
        formatDropDownn.optionArray = ["Text", "Number"]
        formatDropDownn.optionIds = [1,2]
        formatDropDownn.textAlignment = .center
        formatDropDownn.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        formatDropDownn.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        formatDropDownn.arrowColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        formatDropDownn.didSelect{(selectedText, index, id) in
            self.formatDropDownn.text = "\(selectedText)"
            self.saveSetting()
            if selectedText == "Text"{
                self.isString = true
            }else {
                self.isString = false
            }
//           print("I am here")
        }
        formatDropDownn.isSearchEnable = false
        formatDropDownn.arrowSize = 10
        formatDropDownn.checkMarkEnabled = false
        
        //
        checkBtn.setTitle("NEW WORD", for: .normal)
        checkBtn.addTarget(self, action: #selector(change), for: .touchUpInside)
        checkBtn.isEnabled = false
        checkBtn.layer.cornerRadius = 5
        
        //
        trueLbl.isHidden = true
        trueNum.isHidden = true
        falseLbl.isHidden = true
        falseNum.isHidden = true
        resultLbl.isHidden = true
        resultString.isHidden = true
        problemLbl.text = ""
        //
        inputTxt.placeholder = "Press play to enable.."
        inputTxt.isEnabled = false
        bottomLine.frame = CGRect(x: 0.0, y: inputTxt.frame.height - 1, width: inputTxt.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        inputTxt.borderStyle = UITextField.BorderStyle.none
        inputTxt.layer.addSublayer(bottomLine)

        if !isPlay {
            self.animating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.isPlay = true
                self.inputTxt.placeholder = "Call for a word.."
                self.checkBtn.setTitle("NEW WORD", for: .normal)
                self.checkBtn.isEnabled = true
                self.playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                self.TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.trainTime), userInfo: nil, repeats: true)
            }
        }else{
            isPlay = false
            playpauseBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            TrainTimer.invalidate()
        }
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TrainTimer.invalidate()
    }

    
    func animating(){
       UIView.animate(withDuration: 0.2,
          animations: {
           self.three.isHidden = false
            self.three.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
       }, completion: { _ in
           UIView.animate(withDuration: 0.2, animations: {
            self.three.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
           self.three.isHidden = true
       }, completion: {_ in
           UIView.animate(withDuration: 0.2,
              animations: {
                   self.two.isHidden = false
            self.two.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
          },
          completion: { _ in
           UIView.animate(withDuration: 0.2, animations: {
                   self.two.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
                   self.two.isHidden = true
                   }, completion: {_ in
                       UIView.animate(withDuration: 0.2,
                         animations: {
                          self.one.isHidden = false
                            self.one.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                         },
                         completion: { _ in
                             UIView.animate(withDuration: 0.2) {
                              self.one.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
                              self.one.isHidden = true
                          }
                      })
                   })
               })
           })
       })
    }

    //save setting
    func saveSetting(){
        
        let defaults = UserDefaults.standard
        defaults.set(Int(speedSlider.value * 100), forKey: "exercise16_level")
        defaults.set(self.rowNumbers, forKey: "exercise16_row")
    //        defaults.setColor(color: customColor, forKey: "color")
        defaults.set(self.isString, forKey: "exercise16_isString")
        
    }
           
            
    @IBAction func playpauseBtnPressed(_ sender: Any) {
            
        playpauseBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        UIView.animate(withDuration: 2.0, delay: 0,                  usingSpringWithDamping: CGFloat(0.20),initialSpringVelocity: CGFloat(6.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.playpauseBtn.transform = CGAffineTransform.identity
            }, completion: { Void in()  }
        )
        
        
        if !isPlay {
            self.animating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.isPlay = true
                self.inputTxt.placeholder = "Call for a word.."
                self.checkBtn.setTitle("NEW WORD", for: .normal)
                self.checkBtn.isEnabled = true
                self.playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                self.TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.trainTime), userInfo: nil, repeats: true)
            }
        }else{
            isPlay = false
            self.inputTxt.placeholder = "Press play to enable.."
            self.checkBtn.isEnabled = false
            playpauseBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            TrainTimer.invalidate()
        }
            
    }

       
            
    @IBAction func speedSlider(_ sender: UISlider) {
        
        customTimeStep = 1.0 - speedSlider.value
        if customTimeStep < 0.03{ customTimeStep = 0.04}
        if self.customTimeStep > 0.8 {self.customTimeStep = 0.8}
        self.saveSetting()
               
    }
    
    @objc func trainTime(){
       TrainTime = TrainTime + 1
       let kMinute = filteredTime(num: Int(TrainTime/60))
       let kSecond = filteredTime(num: Int(TrainTime%60))
       self.timeLbl.text = kMinute + " : " + kSecond
    }

    func filteredTime(num: Int) -> String{
        var k : String = ""
        if String(num).count  == 1 {
           k = "0" + String(num)
        }else{
           k = String(num)
        }
        return k
    }
    
    @objc func change(){
    
        if isClick {
            isClick = false
            checkBtn.setTitle("CHECK", for: .normal)
            inputTxt.isEnabled = true
            inputTxt.text = ""
            problemLbl.text = ""
            testAction()
            bottomLine.frame = CGRect(x: 0.0, y: inputTxt.frame.height - 5, width: inputTxt.frame.width, height: 1.0)
            bottomLine.backgroundColor = customColor.cgColor
            inputTxt.borderStyle = UITextField.BorderStyle.none
            inputTxt.layer.addSublayer(bottomLine)
            resultLbl.isHidden = true
            resultString.isHidden = true
            
        } else {
            isClick = true
            checkBtn.setTitle("NEW WORD", for: .normal)
            inputTxt.isEnabled = false
//            problemLbl.text = ""
//            inputTxt.text = ""
            bottomLine.frame = CGRect(x: 0.0, y: inputTxt.frame.height - 1, width: inputTxt.frame.width, height: 1.0)
            bottomLine.backgroundColor = UIColor.lightGray.cgColor
            inputTxt.borderStyle = UITextField.BorderStyle.none
            inputTxt.layer.addSublayer(bottomLine)
//            self.testAction()
            resultLbl.isHidden = false
            resultString.isHidden = false

            if problemLbl.text == inputTxt.text {
                successNum = successNum + 1
                
                trueLbl.isHidden = false
                trueNum.isHidden = false
                resultLbl.text = "CONGRATS!"
                trueLbl.textColor = customColor
                trueNum.textColor = customColor
                resultLbl.textColor = customColor//.green
                resultString.text = problemLbl.text
                resultString.textColor = customColor//.green
                trueNum.text = String(successNum)
                trueLbl.text = "True"
                
            }else{
                failNum = failNum + 1
                falseLbl.isHidden = false
                falseNum.isHidden = false
                falseNum.text = String(failNum)
                falseLbl.text = "False"
                resultLbl.text = "FALSE"
                resultLbl.textColor = .red
                resultString.text = problemLbl.text
                resultString.textColor = .red
            }
        }
    }
     
            
    func testAction() {
        self.wordLbl.text = ""
        if !isString {
            self.wordLbl.text = String(Int.random(in: 1000...9999)) + " "
        }
        
        for i in 1...rowNumbers{
            if isString{
                let j = Int.random(in: 0...selectedExercises.count - 1)
                self.wordLbl.text! += selectedExercises[j]
                if i != rowNumbers{
                    self.wordLbl.text! += " "
                }
            }else{
                let j = Int.random(in: 1000...9999)
                self.wordLbl.text! += String(j)
                if i != rowNumbers{
                    self.wordLbl.text! += " "
                }
            }
        }
        
        
        UIView.transition(with: self.wordLbl, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
            self.wordLbl.textColor = UIColor.black
        },
        completion: {_ in
            UIView.transition(with: self.wordLbl, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
                self.wordLbl.textColor = .clear
            },completion: nil)
        })
        
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
//            UIView.transition(with: self.wordLbl, duration: TimeInterval(1 - self.customTimeStep), options: .transitionCrossDissolve, animations: {
//                self.wordLbl.textColor = UIColor.black
//            },
//            completion: {_ in
//                UIView.transition(with: self.wordLbl, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
//                    self.wordLbl.textColor = .clear
//                },completion: nil)
//            })
//        })
      
    }
    
    
    //keyboard hide
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when   'return' key pressed. return NO to ignore.
      {
         textField.resignFirstResponder()
         return true;
      }

    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        inputTxt.resignFirstResponder()
        self.view.endEditing(true)
    }

    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "edit17", sender: self)
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
