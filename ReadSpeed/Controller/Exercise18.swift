//
//  Exercise18.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/19.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit
import iOSDropDown
import VerticalSlider

class Exercise18: UIViewController {

    @IBOutlet weak var dropDown: DropDown!
//    @IBOutlet weak var spacingSlider: VerticalSlider!
    @IBOutlet weak var speedSlider: customThumbSlider!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordLbl2: UILabel!
    @IBOutlet weak var wordLbl3: UILabel!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var playpauseBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var backgroundImgView: UIImageView!

    
   @IBOutlet weak var myPropoLeftEdgeConstraint: NSLayoutConstraint!
    
    var timer = Timer()
    var array = [String]()
    var rowNumbers: Int = 1
    var customTimeStep: Float = 0.25
    var selectedExercises = [String]()
    var customColor: UIColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
    var isPlay: Bool = false
    var counter : Int = 0
    var internalCounter: Int = 0
    var step: Float = 0
    var TrainTime: Int = 0
    var TrainTimer = Timer()
    var isShow : Bool = true
    var oldString: String = ""
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var spacing: CGFloat = 44.5//20
    var kTimer = Timer()
    var topY: CGFloat = 20
    var bottomY: CGFloat = 20
    
  var selectedString : String  = ""
           
   override func viewDidLoad() {
       super.viewDidLoad()
       selectedString = UserDefaults.standard.string(forKey: "exercise_problem") ?? "First Insert your training sentences. This is the default Sentences. decline globe foggy start learning speed formula crane forming singer song string hiccup system naruto configuration axilliary screen economy desk defence often ancient polics occupy map apple computer mouse"
      
       print(selectedString)
      selectedExercises = selectedString.components(separatedBy: " ")  //
        self.speedSlider.tintColor = customColor
        self.speedSlider.maximumValue = 1.0
        self.speedSlider.minimumValue = 0.0
        self.speedSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

        let k = UserDefaults.standard.integer(forKey: "exercise14_level")
        print(k)
        self.speedSlider.value = Float(k)/100
        self.customTimeStep = 1 - Float(k)/100
        if self.customTimeStep < 0.03{ self.customTimeStep = 0.04}
        self.speedSlider.setValue(Float(k)/100, animated: true)
           
        step = (self.speedSlider.maximumValue - self.speedSlider.minimumValue )/100
        //
        self.rowNumbers = UserDefaults.standard.integer(forKey: "exercise14_row")
        if self.rowNumbers == 0 {self.rowNumbers = 1}
        dropDown.text = String(self.rowNumbers)
        //
        playpauseBtn.translatesAutoresizingMaskIntoConstraints = false
        playpauseBtn.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor).isActive = true
        playpauseBtn.centerXAnchor.constraint(equalTo: buttonContainerView.centerXAnchor).isActive = true
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
        playpauseBtn.layer.shadowRadius = CGFloat(size / 3)
        playpauseBtn.layer.shadowOpacity = 1
        //
        timeLbl.textColor = #colorLiteral(red: 0.5086903165, green: 0.627606281, blue: 0.2984172636, alpha: 1)

//        //
//        spacingSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        spacingSlider.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        spacingSlider.heightAnchor.constraint(equalToConstant: screenHeight*3/5).isActive = true
//        spacingSlider.tintColor = customColor
//        spacingSlider.thumbTintColor = customColor
//        spacingSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight/2 - spacingSlider.frame.height/2).isActive = true
//        spacingSlider.minimumValue = Float(spacing)
//        spacingSlider.maximumValue = Float(screenHeight/5)
//        self.spacingSlider.addTarget(self, action: #selector(spacingSliderChanged), for: .valueChanged)

        
        //label
        wordLbl.layer.cornerRadius = 8
        wordLbl.layer.masksToBounds = true

        wordLbl2.layer.cornerRadius = 8
        wordLbl2.layer.masksToBounds = true
        
        wordLbl3.layer.masksToBounds = true
        wordLbl3.layer.cornerRadius = 8
        
        wordLbl.textColor = .clear
        wordLbl3.textColor = .clear
        wordLbl2.textColor = .clear

        //image
        one.isHidden = true
        two.isHidden = true
        three.isHidden = true
                 
         // The list of array to display. Can be changed dynamically
         dropDown.optionArray = ["1", "2", "3", "4"]
         //Its Id Values and its optional
         dropDown.optionIds = [1,2,3,4]
         dropDown.textAlignment = .center
         dropDown.arrowSize = 10
         dropDown.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         dropDown.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        dropDown.arrowColor = customColor
         // The the Closure returns Selected Index and String
         dropDown.didSelect{(selectedText , index ,id) in
             self.dropDown.text = "\(selectedText)"
             self.rowNumbers = Int(selectedText) ?? 1
             self.counter = 0 - self.rowNumbers
             self.saveSetting()
             self.dropDownWillDisappear()
         }
         dropDown.isSearchEnable = false
         dropDown.arrowSize = 10
         dropDown.checkMarkEnabled = false
         dropDown.arrowColor = customColor
    
         

         if !isPlay {
             self.animating()
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.setRandomBackgroundColor), userInfo: nil, repeats: true)
                 self.isPlay = true
                 self.playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                 self.TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.trainTime), userInfo: nil, repeats: true)
             }
         }else{
             timer.invalidate()
             isPlay = false
             playpauseBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
             TrainTimer.invalidate()
         }

    }

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
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

           
    //
    func dropDownWillDisappear(){
        
        self.internalCounter = 0
        if timer.isValid == true {
            timer.invalidate()
            TrainTimer.invalidate()
        }
       
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(setRandomBackgroundColor), userInfo: nil, repeats: true)
        isPlay = true
        playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trainTime), userInfo: nil, repeats: true)
       
    }


    //save setting
    func saveSetting(){
        
        let defaults = UserDefaults.standard
        defaults.set(Int(speedSlider.value * 100), forKey: "exercise14_level")
        defaults.set(self.rowNumbers, forKey: "exercise14_row")
    //        defaults.setColor(color: customColor, forKey: "color")       
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
                self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.setRandomBackgroundColor), userInfo: nil, repeats: true)
                self.isPlay = true
                self.playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                self.TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.trainTime), userInfo: nil, repeats: true)
            }
        }else{
            timer.invalidate()
            isPlay = false
            playpauseBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            TrainTimer.invalidate()
        }

    }
    
//    @objc func spacingSliderChanged(){
//
//        self.spacing = CGFloat(spacingSlider.value)
//        DispatchQueue.main.async {
//            self.wordLbl2.frame.origin = CGPoint(x: 120, y: self.screenHeight/2 - self.spacing - 75)
//            self.wordLbl3.frame.origin = CGPoint(x: 120, y: self.screenHeight/2 + self.spacing + 25)
//        }
//    }

    
    @IBAction func speedSlider(_ sender: UISlider) {
        
        if timer.isValid == true {
            timer.invalidate()
            TrainTimer.invalidate()
        }
        //TimeInterval(customTimeStep)
        customTimeStep = (1.0 - speedSlider.value)*1.25 + 0.25
        if customTimeStep < 0.03{ customTimeStep = 0.04}
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(setRandomBackgroundColor), userInfo: nil, repeats: true)
        isPlay = true
        playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trainTime), userInfo: nil, repeats: true)
           
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


    @objc func setRandomBackgroundColor() {
        
        wordLbl.text = ""
        wordLbl2.text = ""
        wordLbl3.text = ""
        
//        self.spacingSliderChanged()

        
        for i in 1...rowNumbers{
            
            let k = Int.random(in: 0...self.selectedExercises.count-1)
            let kk = Int.random(in: 0...self.selectedExercises.count-1)
            let kkk = Int.random(in: 0...self.selectedExercises.count-1)
            
            self.wordLbl.text! += self.selectedExercises[k]
            self.wordLbl2.text! += self.selectedExercises[kk]
            self.wordLbl3.text! += self.selectedExercises[kkk]
            if i != rowNumbers{
                self.wordLbl.text! += " "
                self.wordLbl2.text! += " "
                self.wordLbl3.text! += " "
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
        
        UIView.transition(with: self.wordLbl3, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
            self.wordLbl3.textColor = UIColor.darkGray
        },
        completion: {_ in
            UIView.transition(with: self.wordLbl3, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
                self.wordLbl3.textColor = .clear
            },completion: nil)
        })
        
        UIView.transition(with: self.wordLbl2, duration: TimeInterval(self.customTimeStep),  options: .transitionCrossDissolve, animations: {
            self.wordLbl2.textColor = UIColor.darkGray
        },
        completion: {_ in
            UIView.transition(with: self.wordLbl2, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
                self.wordLbl2.textColor = .clear
            },completion: nil)
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(customTimeStep) + TimeInterval(0.1), execute: {
            UIView.transition(with: self.wordLbl, duration: TimeInterval(1 - self.customTimeStep), options: .transitionCrossDissolve, animations: {
                self.wordLbl.textColor = UIColor.black
            },
            completion: {_ in
                UIView.transition(with: self.wordLbl, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
                    self.wordLbl.textColor = .clear
                },completion: nil)
            })

            UIView.transition(with: self.wordLbl3, duration: TimeInterval(1 - self.customTimeStep), options: .transitionCrossDissolve, animations: {
                self.wordLbl3.textColor = UIColor.darkGray
            },
            completion: {_ in
                UIView.transition(with: self.wordLbl3, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
                    self.wordLbl3.textColor = .clear
                },completion: nil)
            })

            UIView.transition(with: self.wordLbl2, duration: TimeInterval(1 - self.customTimeStep),  options: .transitionCrossDissolve, animations: {
                self.wordLbl2.textColor = UIColor.darkGray
            },
            completion: {_ in
                UIView.transition(with: self.wordLbl2, duration: TimeInterval(self.customTimeStep), options: .transitionCrossDissolve, animations: {
                    self.wordLbl2.textColor = .clear
                },completion: nil)
            })
        })
          

//        self.wordLbl2.frame.origin = CGPoint(x: 120, y: topY)
//        self.wordLbl3.frame.origin = CGPoint(x: 120, y: bottomY)

    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "edit18", sender: self)
    }
    
}


extension UILabel {
    func startBlink() {
      UIView.animate(withDuration: 0.8,//Time duration
        delay:0.0,
        options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
        animations: { self.alpha = 0 },
        completion: nil)
    }

    func stopBlink() {
          layer.removeAllAnimations()
          alpha = 1
    }
}
