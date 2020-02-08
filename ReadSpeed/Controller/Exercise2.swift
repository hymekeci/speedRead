//
//  Exercise2.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/17.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit
import iOSDropDown
import Dropdowns


class Exercise2: UIViewController {

    @IBOutlet weak var problemPicker: UIBarButtonItem!
    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var speedSlider: UISlider!
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
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var playpauseBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
        
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    

    
        
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
    var selectedString: String  = ""




    override func viewDidLoad() {
        super.viewDidLoad()
        selectedString = UserDefaults.standard.string(forKey: "exercise_problem") ?? "First Insert your training sentences. This is the default Sentences. decline globe foggy start learning speed formula crane forming singer song string hiccup system naruto configuration axilliary screen economy desk defence often ancient polics occupy map apple computer mouse"
        print(selectedString)
        if selectedString == "" {selectedString = "First Insert your training sentences. This is the default Sentences. decline globe foggy start learning speed formula crane forming singer song string hiccup system naruto configuration axilliary screen economy desk defence often ancient polics occupy map apple computer mouse"}
        selectedExercises = selectedString.components(separatedBy: " ")

        self.speedSlider.tintColor = customColor
        self.speedSlider.maximumValue = 1.0
        self.speedSlider.minimumValue = 0.0
        self.speedSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

        let k = UserDefaults.standard.integer(forKey: "exercise1_level")
        print(k)
        self.speedSlider.value = Float(k)/100
        self.customTimeStep = 1 - Float(k)/100
        if self.customTimeStep < 0.03{ self.customTimeStep = 0.04}
        self.speedSlider.setValue(Float(k)/100, animated: true)
           
        step = (self.speedSlider.maximumValue - self.speedSlider.minimumValue )/100
            
        //
        self.rowNumbers = UserDefaults.standard.integer(forKey: "exercise1_row")
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
    //            playpauseBtn.layer.masksToBounds = false
        playpauseBtn.layer.shadowRadius = CGFloat(size / 3)
        playpauseBtn.layer.shadowOpacity = 1
        //
        timeLbl.textColor = #colorLiteral(red: 0.5086903165, green: 0.627606281, blue: 0.2984172636, alpha: 1)

        
        
        //label
        let padding = screenHeight / 75
        wordLbl1.topAnchor.constraint(equalTo: view.topAnchor, constant:  screenHeight / 4).isActive = true
        wordLbl1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLbl2.topAnchor.constraint(equalTo: wordLbl1.bottomAnchor, constant:padding).isActive = true
        wordLbl3.topAnchor.constraint(equalTo: wordLbl2.bottomAnchor, constant:padding).isActive = true
        wordLbl4.topAnchor.constraint(equalTo: wordLbl3.bottomAnchor, constant:padding).isActive = true
        wordLbl5.topAnchor.constraint(equalTo: wordLbl4.bottomAnchor, constant:padding).isActive = true
        wordLbl6.topAnchor.constraint(equalTo: wordLbl5.bottomAnchor, constant:padding).isActive = true
        wordLbl7.topAnchor.constraint(equalTo: wordLbl6.bottomAnchor, constant:padding).isActive = true
        wordLbl8.topAnchor.constraint(equalTo: wordLbl7.bottomAnchor, constant:padding).isActive = true
        wordLbl9.topAnchor.constraint(equalTo: wordLbl8.bottomAnchor, constant:padding).isActive = true
        wordLbl10.topAnchor.constraint(equalTo: wordLbl9.bottomAnchor, constant:padding).isActive = true
        wordLbl11.topAnchor.constraint(equalTo: wordLbl10.bottomAnchor, constant:padding).isActive = true
        wordLbl12.topAnchor.constraint(equalTo: wordLbl11.bottomAnchor, constant:padding).isActive = true
        
        
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
        dropDown.arrowSize = 10
        dropDown.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        dropDown.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        dropDown.arrowColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
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
    //        saveSetting()
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
    
    print("work")
    self.internalCounter = 0
    if timer.isValid == true {
        timer.invalidate()
        TrainTimer.invalidate()
    }

   
    timer = Timer.scheduledTimer(timeInterval: TimeInterval(customTimeStep), target: self, selector: #selector(setRandomBackgroundColor), userInfo: nil, repeats: true)
    isPlay = true
    playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trainTime), userInfo: nil, repeats: true)
    
    
    
}


//save setting
func saveSetting(){
    
    let defaults = UserDefaults.standard
    defaults.set(Int(speedSlider.value * 100), forKey: "exercise1_level")
    defaults.set(self.rowNumbers, forKey: "exercise1_row")
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
            switch rowNumbers {
            case 1:
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl1.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl2.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl3.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl4.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl5.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl6.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl1.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl7.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl8.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl9.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl10.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl11.text = self.selectedExercises[self.counter]
                if counter == selectedExercises.count - 1 {self.counter = -1}
                self.counter = self.counter + 1
                self.wordLbl12.text = self.selectedExercises[self.counter]
                
            case 2:
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl1.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl2.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl3.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl4.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl5.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl6.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl7.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl8.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl9.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl10.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl11.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                if counter >= selectedExercises.count - 3 {self.counter = -2}
                self.counter = self.counter + 2
                self.wordLbl12.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1]
                
            case 3:
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
                
            case 4:
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl1.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl2.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl3.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl4.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl5.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl6.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl7.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl8.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl9.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl10.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl11.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
                if counter >= selectedExercises.count - 7 {self.counter = -4}
                self.counter = self.counter + 4
                self.wordLbl12.text = self.selectedExercises[self.counter] + " " + self.selectedExercises[self.counter + 1] + " " + self.selectedExercises[self.counter + 2] + " " + self.selectedExercises[self.counter + 3]
               
            default:
                break
            }
            self.wordLbl1.backgroundColor = customColor
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 1 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = customColor
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 2 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = customColor
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 3{
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = customColor
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 4 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = customColor
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 5 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = customColor
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 6 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = customColor
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 7 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = customColor
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 8 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = customColor
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 9 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = customColor
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else if internalCounter == 10 {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = customColor
            self.wordLbl12.backgroundColor = .clear
            internalCounter = internalCounter + 1
        }else {
            self.wordLbl1.backgroundColor = .clear
            self.wordLbl2.backgroundColor = .clear
            self.wordLbl3.backgroundColor = .clear
            self.wordLbl4.backgroundColor = .clear
            self.wordLbl5.backgroundColor = .clear
            self.wordLbl6.backgroundColor = .clear
            self.wordLbl7.backgroundColor = .clear
            self.wordLbl8.backgroundColor = .clear
            self.wordLbl9.backgroundColor = .clear
            self.wordLbl10.backgroundColor = .clear
            self.wordLbl11.backgroundColor = .clear
            self.wordLbl12.backgroundColor = customColor
            internalCounter = 0
        }
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "edit2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit2" {
            var problem : String = ""
            for i in selectedExercises{
                problem += i + " "
            }
            print("problem: ----------- \(problem)")
            guard let vc = segue.destination as? editContent else {return}
            vc.oldProblem = problem
        }
    }
    
    
    
    
}

extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
        color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }

    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
        colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
}







//        let rangeOfColoredString = (selectedExercise?.text.joined(separator: ",") as! NSString).range(of: (selectedExercise?.text[counter])!)
            
            // Create the attributedString.
//            let attributedString = NSMutableAttributedString(string:(selectedExercise?.text.joined(separator: ","))!)
//        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: rangeOfColoredString)
//            textLabel.attributedText = attributedString
//            counter += 1
//            score += 1
////            scoreLabel.text = "Score: \(score)"
//            self.speedSlider.setValue(hiz, animated: true)
//
//            if counter == (selectedExercise?.text.count)! {
//                timer.invalidate()
//                hiz = Float((selectedExercise?.text.count)! - 1)
//                textLabel.text = "Time Over!"//"Süre Bitti!"//time is up
//            }






