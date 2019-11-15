//
//  ExerciseDetailViewController.swift
//  ReadSpeed
//
//  Created by mfk on 13.11.2019.
//  Copyright © 2019 mfk. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
   
    
    var selectedExercise:Exercise?
    var timer = Timer()
    var array = [String]()
    var counter = 0
    var uzunluk = 0
    var score = 0
    var hiz = 0.5
    
    
    @objc func setRandomBackgroundColor() {

        
        let rangeOfColoredString = (selectedExercise?.text.joined(separator: ",") as! NSString).range(of: (selectedExercise?.text[counter])!)
        
        // Create the attributedString.
        let attributedString = NSMutableAttributedString(string:(selectedExercise?.text.joined(separator: ","))!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.red],
                                       range: rangeOfColoredString)
        textLabel.attributedText = attributedString
        counter += 1
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        if counter == (selectedExercise?.text.count)! {
            timer.invalidate()
            textLabel.text = "Süre Bitti!"
        }
        
//        textLabel.text?.randomElement()
//        textLabel.text = selectedExercise?.text.randomElement()
//        let colors = [
//                    UIColor(red: 233/255, green: 203/255, blue: 198/255, alpha: 1),
//                    UIColor(red: 38/255, green: 188/255, blue: 192/255, alpha: 1),
//                    UIColor(red: 253/255, green: 221/255, blue: 164/255, alpha: 1),
//                    UIColor(red: 235/255, green: 154/255, blue: 171/255, alpha: 1),
//                    UIColor(red: 87/255, green: 141/255, blue: 155/255, alpha: 1)
//                ]
//        let randomColor = Int(arc4random_uniform(UInt32 (colors.count)))
//
//        textLabel.textColor = colors[randomColor]
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0
        hiz = 1.0
//            (selectedExercise?.text.count)! - 1
        
        titleLabel.text = selectedExercise?.title
        textLabel.text = selectedExercise?.text.joined(separator: ",")
        scoreLabel.text = "Score: \(score)"
        
        timer = Timer.scheduledTimer(timeInterval: hiz, target: self, selector: #selector(setRandomBackgroundColor), userInfo: nil, repeats: true)
        self.setRandomBackgroundColor()
    }
    @IBAction func speedSlider(_ sender: UISlider) {
        hiz = Double(sender.value)
    }
    

}














//        for item in selectedExercise!.text {
//            // create attributed string
//            counter = 10
//            let myString = item
//            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
//            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
//            // set attributed text on a UILabel
//
//            textLabel.attributedText = myAttrString
//            counter -= 1
//            textLabel.text = selectedExercise?.text.joined(separator: ",")
//            if counter == 0{
//                timer.invalidate()
//
//            }
//        }


//
//        let denemes = selectedExercise?.text.joined(separator: ",")
//        let attributedString = NSMutableAttributedString(string: denemes!)
//
//        // 2
//        let firstAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.blue,
//            .backgroundColor: UIColor.yellow,
//            .underlineStyle: 1]
//        let secondAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.red,
//            .backgroundColor: UIColor.blue,
//            .strikethroughStyle: 1]
//        let thirdAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.green,
//            .backgroundColor: UIColor.black,
//            ]
//
//
//        for (index, element) in (selectedExercise?.text.enumerated())! {
//            let mal = element.components(separatedBy: " ")
//            uzunluk = mal.count
//        }
//
//
//
//        // 3
//        attributedString.addAttributes(secondAttributes, range: NSRange(location: 0, length: uzunluk))
//        attributedString.addAttributes(thirdAttributes, range: NSRange(location: uzunluk, length: uzunluk))
//        attributedString.addAttributes(firstAttributes, range: NSRange(location: (2*uzunluk), length: uzunluk))
//
//
//
//        // 4
//        textLabel.attributedText = attributedString
//        counter -= 1

//        for i in 0 ..< movies.count {
//            // Create the attributedString.
//            let attributedString = NSMutableAttributedString(string:(selectedExercise?.text.joined(separator: ","))!)
//            attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.red],
//                                           range: rangeOfColoredString)
//            textLabel.attributedText = attributedString
//        }





//
////        let colors = [
////            UIColor(red: 233/255, green: 203/255, blue: 198/255, alpha: 1),
////            UIColor(red: 38/255, green: 188/255, blue: 192/255, alpha: 1),
////            UIColor(red: 253/255, green: 221/255, blue: 164/255, alpha: 1),
////            UIColor(red: 235/255, green: 154/255, blue: 171/255, alpha: 1),
////            UIColor(red: 87/255, green: 141/255, blue: 155/255, alpha: 1)
////        ]
////        let randomColor = Int(arc4random_uniform(UInt32 (colors.count)))
//
//
////        let ilk = textLabel.text!.components(separatedBy: " ")
//for i in textLabel.text!.components(separatedBy: " "){
//    ////            textLabel.textColor = colors[randomColor]
//    //            //let stringRepresentation = textLabel.text!.components(separatedBy: " ").description
//    //           let range = (textLabel.text! as NSString).range(of: i)
//    //
//    //            let attributedText = NSMutableAttributedString.init(string: textLabel.text!)
//    //            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
//    //            textLabel.attributedText = attributedText
//    // create attributed string
//    let myString = i
//    let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
//    let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
//    // set attributed text on a UILabel
//    textLabel.attributedText = myAttrString
//
//    counter -= 1
//
//    if counter == 0 {
//        textLabel.textColor = UIColor(named: "black")
//    }
//}
//        
