//
//  Exercise7.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/15.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit

class Exercise7: UIViewController {

    
    @IBOutlet weak var speedSlider: customThumbSlider!
    @IBOutlet weak var wordLbl1: UILabel!
        @IBOutlet weak var wordLbl2: UILabel!
        @IBOutlet weak var wordLbl3: UILabel!
        @IBOutlet weak var wordLbl4: UILabel!
        @IBOutlet weak var wordLbl5: UILabel!
        @IBOutlet weak var wordLbl6: UILabel!
        @IBOutlet weak var wordLbl7: UILabel!
        @IBOutlet weak var wordLbl8: UILabel!
        @IBOutlet weak var wordLbl9: UILabel!
        @IBOutlet weak var wordLbl10: UILabel!
        @IBOutlet weak var wordLbl11: UILabel!
        @IBOutlet weak var wordLbl12: UILabel!
        @IBOutlet weak var wordLbl13: UILabel!
        @IBOutlet weak var wordLbl14: UILabel!
        @IBOutlet weak var wordLbl15: UILabel!
        @IBOutlet weak var wordLbl16: UILabel!
        @IBOutlet weak var wordLbl17: UILabel!
        @IBOutlet weak var wordLbl18: UILabel!
        @IBOutlet weak var wordLbl19: UILabel!
        @IBOutlet weak var wordLbl20: UILabel!
        @IBOutlet weak var wordLbl21: UILabel!
        @IBOutlet weak var wordLbl22: UILabel!
        @IBOutlet weak var wordLbl23: UILabel!
        @IBOutlet weak var wordLbl24: UILabel!
        
        @IBOutlet weak var playpauseBtn: UIButton!
        @IBOutlet weak var timeLbl: UILabel!
        @IBOutlet weak var buttonContainerView: UIView!
        @IBOutlet weak var three: UIImageView!
        @IBOutlet weak var two: UIImageView!
        @IBOutlet weak var one: UIImageView!
            
            var timer = Timer()
            var array = [String]()
            var rowNumbers: Int = 1
            var customTimeStep: Float = 1.0
            var selectedExercises = [String]()
            var customColor: UIColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
            var isPlay: Bool = false
            var counter : Int = 0
            var internalCounter: Int = 0
            var step: Float = 0
            var TrainTime: Int = 0
            var TrainTimer = Timer()
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
    
            var tempArray = [String]()
           var selectedString : String  = ""
        
            override func viewDidLoad() {
               super.viewDidLoad()
               selectedString = UserDefaults.standard.string(forKey: "exercise_problem") ?? "First Insert your training sentences. This is the default Sentences. decline globe foggy start learning speed formula crane forming singer song string hiccup system naruto configuration axilliary screen economy desk defence often ancient polics occupy map apple computer mouse"
               
               print(selectedString)
               tempArray = selectedString.components(separatedBy: " ")
               for i in tempArray{
                    for j in 1...i.count{
                        let k: Int = Int.random(in: 0...1)
                        if k == 1 {
                            let kk: Int = Int.random(in: 0...9)
                            selectedExercises.append(String(kk))
                        } else{
                            selectedExercises.append(i[j-1])
                        }
                    }
                }
                //
               self.speedSlider.tintColor = customColor
               self.speedSlider.maximumValue = 1.0
               self.speedSlider.minimumValue = 0.0
               self.speedSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

               let k = UserDefaults.standard.integer(forKey: "exercise6_level")
               print(k)
               self.speedSlider.value = Float(k)/100
               self.customTimeStep = 1 - Float(k)/100
               if self.customTimeStep < 0.03{ self.customTimeStep = 0.04}
               self.speedSlider.setValue(Float(k)/100, animated: true)
                                      

                                       
               step = (self.speedSlider.maximumValue - self.speedSlider.minimumValue )/100
                                      //
                //
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
          //            playpauseBtn.layer.masksToBounds = false
              playpauseBtn.layer.shadowRadius = CGFloat(size / 3)
              playpauseBtn.layer.shadowOpacity = 1
              //
              timeLbl.textColor = #colorLiteral(red: 0.5086903165, green: 0.627606281, blue: 0.2984172636, alpha: 1)
                //label
                wordLbl1.layer.cornerRadius = 8
                wordLbl2.layer.cornerRadius = 8
                wordLbl3.layer.cornerRadius = 8
                wordLbl4.layer.cornerRadius = 8
                wordLbl5.layer.cornerRadius = 8
                wordLbl6.layer.cornerRadius = 8
                wordLbl7.layer.cornerRadius = 8
                wordLbl8.layer.cornerRadius = 8
                wordLbl9.layer.cornerRadius = 8
                wordLbl10.layer.cornerRadius = 8
                wordLbl11.layer.cornerRadius = 8
                wordLbl12.layer.cornerRadius = 8
                wordLbl13.layer.cornerRadius = 8
                wordLbl14.layer.cornerRadius = 8
                wordLbl15.layer.cornerRadius = 8
                wordLbl16.layer.cornerRadius = 8
                wordLbl17.layer.cornerRadius = 8
                wordLbl18.layer.cornerRadius = 8
                wordLbl19.layer.cornerRadius = 8
                wordLbl20.layer.cornerRadius = 8
                wordLbl21.layer.cornerRadius = 8
                wordLbl22.layer.cornerRadius = 8
                wordLbl23.layer.cornerRadius = 8
                wordLbl24.layer.cornerRadius = 8
                
                
                wordLbl1.layer.masksToBounds = true
                wordLbl2.layer.masksToBounds = true
                wordLbl3.layer.masksToBounds = true
                wordLbl4.layer.masksToBounds = true
                wordLbl5.layer.masksToBounds = true
                wordLbl6.layer.masksToBounds = true
                wordLbl7.layer.masksToBounds = true
                wordLbl8.layer.masksToBounds = true
                wordLbl9.layer.masksToBounds = true
                wordLbl10.layer.masksToBounds = true
                wordLbl11.layer.masksToBounds = true
                wordLbl12.layer.masksToBounds = true
                wordLbl13.layer.masksToBounds = true
                wordLbl14.layer.masksToBounds = true
                wordLbl15.layer.masksToBounds = true
                wordLbl16.layer.masksToBounds = true
                wordLbl17.layer.masksToBounds = true
                wordLbl18.layer.masksToBounds = true
                wordLbl19.layer.masksToBounds = true
                wordLbl20.layer.masksToBounds = true
                wordLbl21.layer.masksToBounds = true
                wordLbl22.layer.masksToBounds = true
                wordLbl23.layer.masksToBounds = true
                wordLbl24.layer.masksToBounds = true
                
                //timeLabel
                timeLbl.textColor = customColor
               
                //image
                one.isHidden = true
                two.isHidden = true
                three.isHidden = true
                        
                if !isPlay {
                       self.animating()
                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                           self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.customTimeStep), target: self, selector: #selector(self.setRandomBackgroundColor), userInfo: nil, repeats: true)
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
                      
           
           //save setting
           func saveSetting(){
               
               let defaults = UserDefaults.standard
               defaults.set(Int(speedSlider.value * 100), forKey: "exercise6_level")
    //           defaults.set(self.rowNumbers, forKey: "exercise5_row")
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
                        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.customTimeStep), target: self, selector: #selector(self.setRandomBackgroundColor), userInfo: nil, repeats: true)
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

            
            
            @IBAction func speedSlider(_ sender: UISlider) {
               if timer.isValid == true {
                  timer.invalidate()
                  TrainTimer.invalidate()
              }
              
              customTimeStep = 1.0 - speedSlider.value
              if customTimeStep < 0.03{ customTimeStep = 0.04}
              timer = Timer.scheduledTimer(timeInterval: TimeInterval(customTimeStep), target: self, selector: #selector(setRandomBackgroundColor), userInfo: nil, repeats: true)
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
                
                if internalCounter == 0 {
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl1.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl2.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl3.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl4.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl5.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl6.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl7.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl8.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl9.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl10.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl11.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl12.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl13.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl14.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl15.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl16.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl17.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl18.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl19.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl20.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl21.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl22.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl23.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    if counter >= selectedExercises.count - 5 {self.counter = -3}
                    self.counter = self.counter + 3
                    self.wordLbl24.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2]
                    
                         
                    //
                        
                    self.wordLbl1.backgroundColor = customColor
                    self.wordLbl24.backgroundColor = .clear
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 1 {
                    self.wordLbl1.backgroundColor = .clear
                    self.wordLbl2.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 2 {
                    
                    self.wordLbl2.backgroundColor = .clear
                    self.wordLbl3.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 3{
                    
                    self.wordLbl3.backgroundColor = .clear
                    self.wordLbl4.backgroundColor = customColor
                   
                    internalCounter = internalCounter + 1
                }else if internalCounter == 4 {
                    
                    self.wordLbl4.backgroundColor = .clear
                    self.wordLbl5.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 5 {
                    
                    self.wordLbl5.backgroundColor = .clear
                    self.wordLbl6.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 6 {
                    
                    self.wordLbl6.backgroundColor = .clear
                    self.wordLbl7.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 7 {
                    
                    self.wordLbl7.backgroundColor = .clear
                    self.wordLbl8.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 8 {
                    
                    self.wordLbl8.backgroundColor = .clear
                    self.wordLbl9.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 9 {
                    
                    self.wordLbl9.backgroundColor = .clear
                    self.wordLbl10.backgroundColor = customColor
                   
                    internalCounter = internalCounter + 1
                }else if internalCounter == 10 {
                    
                    self.wordLbl10.backgroundColor = .clear
                    self.wordLbl11.backgroundColor = customColor
                    
                    internalCounter = internalCounter + 1
                }else if internalCounter == 11{
                    
                    self.wordLbl11.backgroundColor = .clear
                    self.wordLbl12.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 12{
                    
                    self.wordLbl12.backgroundColor = .clear
                    self.wordLbl13.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 13{
                    
                    self.wordLbl13.backgroundColor = .clear
                    self.wordLbl14.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 14{
                    
                    self.wordLbl14.backgroundColor = .clear
                    self.wordLbl15.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 15{
                    
                    self.wordLbl15.backgroundColor = .clear
                    self.wordLbl16.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 16{
                    
                    self.wordLbl16.backgroundColor = .clear
                    self.wordLbl17.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 17{
                    
                    self.wordLbl17.backgroundColor = .clear
                    self.wordLbl18.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 18{
                    
                    self.wordLbl18.backgroundColor = .clear
                    self.wordLbl19.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 19{
                    
                    self.wordLbl19.backgroundColor = .clear
                    self.wordLbl20.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 20{
                    
                    self.wordLbl20.backgroundColor = .clear
                    self.wordLbl21.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 21{
                    
                    self.wordLbl21.backgroundColor = .clear
                    self.wordLbl22.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else if internalCounter == 22{
                    
                    self.wordLbl22.backgroundColor = .clear
                    self.wordLbl23.backgroundColor = customColor
                    internalCounter = internalCounter + 1
                }else {
                    
                    self.wordLbl23.backgroundColor = .clear
                    self.wordLbl24.backgroundColor = customColor
                    internalCounter = 0
                }
            }
            
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "edit7", sender: self)
    }
    
}
