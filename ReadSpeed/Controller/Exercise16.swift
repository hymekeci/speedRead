//
//  Exercise16.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/18.
//  Copyright © 2020 mfk. All rights reserved.
//

import iOSDropDown
import UIKit
import TextAttributes

class Exercise16: UIViewController {

    
    @IBOutlet weak var speedSlider: customThumbSlider!
    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var wordLbl1: UILabel!
    
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var playpauseBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    
     
    var timer = Timer()
    var array = [String]()
    var rowNumbers: Int = 1
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
    var selectedSentences = String()
    var setString = [String]()
    var needInput: Bool = true
    var idx : Int = 0
    let header = "<html><header><style>span{background-color:#9BC15B;} p{font-size: 18px;padding: 1px;text-align: center;}</style></header><body><p>"
    let breakPoint = "<br>"
    let tailer = "</p></body></html>"
   var selectedString : String  = ""
   
   override func viewDidLoad() {
       super.viewDidLoad()
       selectedString = UserDefaults.standard.string(forKey: "exercise_problem") ?? "First Insert your training sentences. This is the default Sentences. This is the cardinal sin in bidding. Don't just cut and paste a response and recycle it for every project you bid on. It looks spammy and it sends a message to the employer that you didn't care enough about their project to write an original bid. In the example above, it's obvious from a glance that the bid is generic. It doesn't mention any project details or how the freelancer's skills apply. Copy-paste bids like this are an immediate turn-off for employers.Bad bids are overly formal. Note the, in the example above. Being professional and respectful is important, but being overly formal comes across as stiff and impersonal. It also repeats the first mistake of bidding, which is making your bid appear cut and pasted. Bad bids are self-focused. Read through the example above again and note how many times the bidder mentions himself versus how many times he actually addresses the project posting. There's no reference to the project itself, only to the bidder. Bad bids are overly general When they post a project, employers want to know that they can find a freelancer with specific skills relevant to the task. They want to see experience with projects similar to theirs. Note how the example above has none of that. The bidder mentions, Relevant Skills and Experience, but doesn't go into detail about what those skills are. There's no mention of previous projects, no mention of the current proposal, no mention of deadlines and no mention of how the task will be completed. Bad bids come from unprofessional looking profiles Profiles without actual photos (cartoon characters don't count) immediately look less professional. Take the time to upload a quality photo of yourself. It helps potential employers form a connection to you.In addition to a photo, you project trustworthiness if you take the time to verify your email and phone number, connect your Facebook and verify your payment method. These potential employers that there's an actual person behind the profile.What details should I include in a bid? Here is a bid with a high chance of success:Hi John,I will summarize all the lectures and provide you with clear, concise notes. I am a PhD writer with 5 years of experience. I have worked on several similar projects compiling presentation slides and lecture notes into a single set of notes, and can deliver quality notes to tight deadlines. You can see an example of one of those projects in my portfolio here. I can generally compile up to 10 pages of lecture notes per day. I'm interested to hear more about the project and about subject matter of the lectures. If you award me the project I'd be very happy to discuss this further and get started for you as soon as possible.Thanks! Steve So what makes this a good bid? Let's look closer. Personalized response. Note how the bidder addressed the employer by name. Right away, this sends a signal to the mployer that you've actually read the project posting and aren't just blanketing every project with a copy-paste response. Moreover, as simple as using someone's name seems, it forms a human connection. Information about the project. Include details from the original project listing to show you've read it horoughly. Remember that this project is very important to the person who posted it. They wouldn't have taken the time to seek out a freelancer otherwise. Including details about the project in your bid shows employers that their project is important to you as well.How your skills are relevant to the project Be specific about how your skill set lends itself to the project. Mention previous similar projects you've worked on and what you've been able to deliver. If you're hired to produce a logo for a company, it's not enough simply to say you know how to use Photoshop, Illustrator. Talk about your previous experience designing logos, and some of the companies you've designed them for.The deadline you can commit to Give the employer an idea of the timeframe you can finish the project in. While some projects may not be as time sensitive, it's still wise to address how quickly you can deliver. This shows the employer that you are prioritizing their project. The caveat here? Don't overcommit. Only commit to deadlines on which you realistically deliver.A link to past work If you've done similar work before make to upload it to your portfolio and provide the employer with link. The best way they have to gauge your abilities is to see what you've actually delivered in the past.Some questions about the projectTry to ask one or two questions specific to the project. This serves two purposes. First, it shows the employer you've thoroughly read the project description. Second, it increases your chances of receiving a reply. Leave your question open-ended so you can start a dialogue with the employer."
      
       print(selectedString)
      selectedExercises = selectedString.components(separatedBy: " ")

        
        
  
      self.speedSlider.tintColor = customColor
      self.speedSlider.maximumValue = 1.0
      self.speedSlider.minimumValue = 0.0
      self.speedSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

      let k = UserDefaults.standard.integer(forKey: "exercise12_level")
      print(k)
      self.speedSlider.value = Float(k)/100
      self.customTimeStep = 1 - Float(k)/100
      if self.customTimeStep < 0.03{ self.customTimeStep = 0.04}
      self.speedSlider.setValue(Float(k)/100, animated: true)
            
      step = (self.speedSlider.maximumValue - self.speedSlider.minimumValue )/100
    
//    //label
//    let padding = screenHeight / 75
//    wordLbl1.topAnchor.constraint(equalTo: view.topAnchor, constant:  screenHeight / 4 + 40).isActive = true
//    wordLbl1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    wordLbl1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
//    wordLbl1.layer.cornerRadius = 8
//    wordLbl1.sizeToFit()
//    wordLbl1.layer.masksToBounds = true
//
       //
       self.rowNumbers = UserDefaults.standard.integer(forKey: "exercise12_row")
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
       defaults.set(Int(speedSlider.value * 100), forKey: "exercise12_level")
       defaults.set(self.rowNumbers, forKey: "exercise12_row")
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
        
        
        
        
        switch rowNumbers {
        case 1:
            if needInput{
                self.setString.removeAll()
                var temp : String = ""
                for _ in 1...12{
                    temp = ""
                    while temp.count < 30{
                        if self.idx == selectedExercises.count{
                            break
                        }else{
                            if temp == "" {
                                temp = self.selectedExercises[idx]
                            }else{
                                temp = temp + "&nbsp" + self.selectedExercises[idx]
                            }
                            self.idx = self.idx + 1
                        }
                    }
                    self.setString.append(temp)
                    print(setString.count)
                    needInput = false
                    counter = 0
                }
            }else{
                if counter >= setString.count - 1{
                    needInput = true; counter = 0;
                }else{
                    var str: String = header
                    for i in 0...setString.count - 1{
                        if (i==counter){ str+="<span>" }
                        str += setString[i]
                        if (i==counter){ str+="</span>"}
                        str += breakPoint
                        if setString[i] == "" {
                            needInput = true; counter = 0
                        }
                    }
                    str += tailer
                    self.wordLbl1.attributedText = str.htmlToAttributedString
                    counter += 1
                }
            }
        case 2:
           if needInput{
                self.setString.removeAll()
                var temp : String = ""
                for _ in 0...23{
                    temp = ""
                    while temp.count < 14{
                        if self.idx == selectedExercises.count{
                            break
                        }else{
                            if temp == "" {
                                temp = self.selectedExercises[idx]
                            }else{
                                temp = temp + "&nbsp" + self.selectedExercises[idx]
                            }
                            self.idx = self.idx + 1
                        }
                    }
                    self.setString.append(temp)
                    print(setString.count)
                    needInput = false
                    counter = 0
                }
           }else{
                if counter >= setString.count - 2 {
                    needInput = true; counter = 0;
                }else{
                    var str: String = header
                    for i in stride(from: 0, to:setString.count - 2, by: 2){
                        if counter%2 == 0{
                            if (i==counter){ str+="<span>" }
                            str += setString[i]
                            if (i==counter){ str+="</span>"}
                            str += "&nbsp" + setString[i + 1]
                            str += breakPoint
                        }else{
                            str += setString[i] + "&nbsp"
                            if (i==counter - 1){ str+="<span>" }
                            str +=  setString[i + 1]
                            if (i==counter - 1){ str+="</span>"}
                            str += breakPoint
                        }
                        if setString[i] == ""{
                            needInput = true; counter = 0
                        }
                    }
                    str += tailer
                    self.wordLbl1.attributedText = str.htmlToAttributedString
                    counter += 1
                }
            }
        case 3:
            if needInput{
                 self.setString.removeAll()
                 var temp : String = ""
                 for _ in 0...35{
                     temp = ""
                     while temp.count < 4{
                         if self.idx == selectedExercises.count{
                             break
                         }else{
                             if temp == "" {
                                 temp = self.selectedExercises[idx]
                             }else{
                                 temp = temp + "&nbsp" + self.selectedExercises[idx]
                             }
                             self.idx = self.idx + 1
                         }
                     }
                     self.setString.append(temp)
                     print(setString.count)
                     needInput = false
                     counter = 0
                 }
            }else{
                 if counter >= setString.count - 3 {
                     needInput = true; counter = 0;
                         
                 }else{
                     var str: String = header
                     for i in stride(from: 0, to:setString.count - 3, by: 3){
                        if counter%3 == 0{
                            if (i==counter){ str+="<span>" }
                            str += setString[i]
                            if (i==counter){ str+="</span>"}
                            str += "&nbsp" + setString[i + 1]
                            str += "&nbsp" + setString[i + 2]
                            str += breakPoint
                            
                        }else if counter%3 == 1{
                            str += setString[i] + "&nbsp"
                            if (i==counter - 1){ str+="<span>" }
                            str += setString[i + 1]
                            if (i==counter - 1){ str+="</span>"}
                            str += "&nbsp" + setString[i + 2]
                            str += breakPoint
                             
                        }else{
                            str += setString[i]
                            str += "&nbsp" + setString[i + 1] + "&nbsp"
                            if (i==counter - 2){ str+="<span>" }
                            str += setString[i + 2]
                            if (i==counter - 2){ str+="</span>"}
                            str += breakPoint
                        }
                        if setString[i] == " "{
                            needInput = true; counter = 0
                            print("needInput = true; counter = 0")

                        }
                    }
                    str += tailer
                    self.wordLbl1.attributedText = str.htmlToAttributedString
                    counter += 1
                 }
             }
        case 4:
            if needInput{
                 self.setString.removeAll()
                 var temp : String = ""
                 for _ in 0...47{
                     temp = ""
                     while temp.count < 5{
                         if self.idx == selectedExercises.count{
                             break
                         }else{
                             if temp == "" {
                                 temp = self.selectedExercises[idx]
                             }else{
                                 temp = temp + "&nbsp" + self.selectedExercises[idx]
                             }
                             self.idx = self.idx + 1
                         }
                     }
                     self.setString.append(temp)
                     print(setString.count)
                     needInput = false
                     counter = 0
                 }
            }else{
                 if counter >= setString.count - 4 {
                     needInput = true; counter = 0;
                 }else{
                     var str: String = header
                     for i in stride(from: 0, to:setString.count - 4, by: 4){
                        if counter%4 == 0{
                            if (i==counter){ str+="<span>" }
                            str += setString[i]
                            if (i==counter){ str+="</span>"}
                            str += "&nbsp" + setString[i + 1]
                            str += "&nbsp" + setString[i + 2]
                            str += "&nbsp" + setString[i + 3]
                            str += breakPoint
                        }else if counter%4 == 1{
                            str += setString[i] + "&nbsp"
                            if (i==counter - 1){ str+="<span>" }
                            str += setString[i + 1]
                            if (i==counter - 1){ str+="</span>"}
                            str += "&nbsp" + setString[i + 2]
                            str += "&nbsp" + setString[i + 3]
                            str += breakPoint
                             
                        }else if counter%4 == 2{
                            str += setString[i]
                            str += "&nbsp" + setString[i + 1] + "&nbsp"
                            if (i==counter - 2){ str+="<span>" }
                            str += setString[i + 2]
                            if (i==counter - 2){ str+="</span>"}
                            str += "&nbsp" + setString[i + 3]
                            str += breakPoint
                        }else{
                            str += setString[i]
                            str += "&nbsp" + setString[i + 1]
                            str += "&nbsp" + setString[i + 2] + "&nbsp"
                            if (i==counter - 3){ str+="<span>" }
                            str += setString[i + 3]
                            if (i==counter - 3){ str+="</span>"}
                            str += breakPoint
                        }
                        if setString[i] == ""{
                            needInput = true; counter = 0
                            print("needInput = true; counter = 0")
                        }
                    }
                 
                    str += tailer
                    self.wordLbl1.attributedText = str.htmlToAttributedString
                    counter += 1
             
                }
             }
        default:
            break
        }
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "edit16", sender: self)
    }
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
