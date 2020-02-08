//
//  Exercise19.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/19.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit
import iOSDropDown

class Exercise19: UIViewController {

    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var playpauseBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var speedSlider: customThumbSlider!
    
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var timer = Timer()
    var array = [String]()
    var rowNumbers: Int = 5
    var customTimeStep: Float = 1.0
    var selectedExercises = [String]()
    var customColor: UIColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
    var isPlay: Bool = false
    var counter : Int = 0
    var step: Float = 0
    var TrainTime: Int = 0
    var TrainTimer = Timer()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var setString = [String]()
    var needInput: Bool = true
    var selectedWords = [String]()
    let header = "<html><header><style>span{background-color:#9BC15B;} p{font-size: 23px;padding: 1px;text-align: center;}</style></header><body><p>"
    let breakPoint = "<br>"
    let tailer = "</p></body></html>"
    var pattern: Int = 0
var tempArray = [String]()
var selectedString : String  = ""

override func viewDidLoad() {
   super.viewDidLoad()
   selectedString = UserDefaults.standard.string(forKey: "exercise_problem") ?? "First Insert your training sentences. This is the default Sentences. decline globe foggy start learning speed formula crane forming singer song string hiccup system naruto configuration axilliary screen economy desk defence often ancient polics occupy map apple computer mouse"
   
   print(selectedString)
   selectedExercises = selectedString.components(separatedBy: " ")
    self.speedSlider.tintColor = customColor
    self.speedSlider.maximumValue = 1.0
    self.speedSlider.minimumValue = 0.0
    self.speedSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

    let k = UserDefaults.standard.integer(forKey: "exercise15_level")
    print(k)
    self.speedSlider.value = Float(k)/100
    self.customTimeStep = 1 - Float(k)/100
    if self.customTimeStep < 0.03{ self.customTimeStep = 0.04}
    self.speedSlider.setValue(Float(k)/100, animated: true)
          
    step = (self.speedSlider.maximumValue - self.speedSlider.minimumValue )/100
    //
    self.rowNumbers = UserDefaults.standard.integer(forKey: "exercise15_row")
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
                
    //image
    one.isHidden = true
    two.isHidden = true
    three.isHidden = true
                           
     //dropdown
     // The list of array to display. Can be changed dynamically
     dropDown.optionArray = ["5", "6", "7", "8", "9"]
     //Its Id Values and its optional
     dropDown.optionIds = [1,2,3,4,5]
     dropDown.textAlignment = .center
     dropDown.arrowSize = 10
     dropDown.text = String(rowNumbers)
     dropDown.selectedRowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
     dropDown.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
     dropDown.arrowColor = customColor
     // The the Closure returns Selected Index and String
     dropDown.didSelect{(selectedText , index ,id) in
         self.dropDown.text = "\(selectedText)"
         self.rowNumbers = Int(selectedText) ?? 5
//             self.counter = 0 - self.rowNumbers
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

         self.counter = 0
         if timer.isValid == true {
             timer.invalidate()
             TrainTimer.invalidate()
         }
         self.needInput = true

         timer = Timer.scheduledTimer(timeInterval: TimeInterval(customTimeStep), target: self, selector: #selector(setRandomBackgroundColor), userInfo: nil, repeats: true)
         isPlay = true
         playpauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
         TrainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trainTime), userInfo: nil, repeats: true)
         
    }

    //save setting
    func saveSetting(){

        let defaults = UserDefaults.standard
        defaults.set(Int(speedSlider.value * 100), forKey: "exercise15_level")
        defaults.set(self.rowNumbers, forKey: "exercise15_row")
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
        needInput = true
        
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
        
        for _ in 1...10 {
            self.label.attributedText = preview(row: rowNumbers).htmlToAttributedString
        }
        var randomInt : Int = 0
        var str: String = ""
        randomInt = Int.random(in: 0...3)
        let intNumber = Int.random(in: 1...rowNumbers)
        for i in selectedExercises{
            if i.length == rowNumbers{
                selectedWords.append(i)
            }
        }
        selectedWords.shuffle()
        
        if randomInt == 0 {
           str=patternRow(row: intNumber, rowNumber: rowNumbers, word:selectedWords[0])
        }else if randomInt == 1{
            str=patternColumn(column: intNumber, rowNumber: rowNumbers, word: selectedWords[0])
        }else if randomInt == 2{
            str=patternSecondCross(rowNumber: rowNumbers, word:selectedWords[0])
        }else{
            str=patternMainCross(rowNumber: rowNumbers, word:selectedWords[0])
        }
                      
        self.label.attributedText = str.htmlToAttributedString
    }
    
    func getString(num: Int) -> String {
        var k = String()
        if num == 1 {k = "a"}
        if num == 2 {k = "b"}
        if num == 3 {k = "c"}
        if num == 4 {k = "d"}
        if num == 5 {k = "e"}
        if num == 6 {k = "f"}
        if num == 7 {k = "g"}
        if num == 8 {k = "h"}
        if num == 9 {k = "i"}
        if num == 10 {k = "j"}
        if num == 11 {k = "k"}
        if num == 12 {k = "l"}
        if num == 13 {k = "m"}
        if num == 14 {k = "n"}
        if num == 15 {k = "o"}
        if num == 16 {k = "p"}
        if num == 17 {k = "q"}
        if num == 18 {k = "r"}
        if num == 19 {k = "s"}
        if num == 20 {k = "t"}
        if num == 21 {k = "u"}
        if num == 22 {k = "v"}
        if num == 23 {k = "w"}
        if num == 24 {k = "x"}
        if num == 25 {k = "y"}
        if num == 26 {k = "z"}
        return k
    }
    
    func preview(row: Int) -> String{
        var characters = [String]()
        var temp : String = header
        let rangeNum : Int = row * row
        for _ in 1...(rangeNum){
            let k = Int.random(in: 1...26)
            characters.append(getString(num: k))
        }
        
        for i in 1...row{
            for j in 1...row{
                temp += characters[i * j - 1]
                if j == row {temp += breakPoint} else { temp += "&nbsp&nbsp&nbsp"}
            }
        }
        temp += tailer
        return temp
    }
    
    
    func patternRow(row: Int, rowNumber: Int, word:String)->String{
        var temp : String = header
        for i in 1...rowNumber{
            for j in 1...rowNumber{
                
                if j == row { temp += "<span>"}
                if j == row {
                    temp += word[i-1]
                } else {
                    let k = Int.random(in: 1...26)
                    temp += getString(num: k)
                }
                if j == row {temp += "</span>"}
                if j == rowNumber{ temp+=breakPoint}else{temp+="&nbsp&nbsp&nbsp"}
                
            }
        }
        temp += tailer
        return temp
    }
    
    func patternColumn(column: Int, rowNumber: Int, word: String) -> String{
        var temp: String = header
        for i in 1...rowNumber{
            for j in 1...rowNumber{
                if i == column{
                    temp+="<span>"
                    temp+=word[j-1]
                    temp+="</span>"
                }else{
                    let k = Int.random(in: 1...26)
                    temp += getString(num: k)
                }
                if j == rowNumber{ temp+=breakPoint}else{temp+="&nbsp&nbsp&nbsp"}
            }
        }
        temp+=tailer
        return temp
    }
    
    
    func patternSecondCross(rowNumber: Int, word:String)->String{
        var temp : String = header
        for i in 1...rowNumber{
            for j in 1...rowNumber{
                
                if j == rowNumber - i + 1 { temp += "<span>"}
                if j == rowNumber - i + 1 {
                    temp += word[i-1]
                } else {
                    let k = Int.random(in: 1...26)
                    temp += getString(num: k)
                }
                if j == rowNumber - i + 1 {temp += "</span>"}
                if j == rowNumber{ temp+=breakPoint}else{temp+="&nbsp&nbsp&nbsp"}
            }
        }
        temp += tailer
        return temp
    }
        
    func patternMainCross(rowNumber: Int, word:String)->String{
        var temp : String = header
        for i in 1...rowNumber{
            for j in 1...rowNumber{
                
                if j == i { temp += "<span>"}
                if j == i {
                    temp += word[i-1]
                } else {
                    let k = Int.random(in: 1...26)
                    temp += getString(num: k)
                }
                if j == i {temp += "</span>"}
                if j == rowNumber{ temp+=breakPoint}else{temp+="&nbsp&nbsp&nbsp"}
            }
        }
        temp += tailer
        return temp
    }
    
    
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "edit17", sender: self)
    }
    
}

extension String {
  var length: Int {
    return count
  }
  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }
  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }
  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }
  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                        upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }
}

