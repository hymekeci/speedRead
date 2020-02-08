//
//  editContent.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/25.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit


class editContent: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var contentTxt: UITextView!
    
    var oldProblem: String = ""
    var customColor: UIColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTxt.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        saveBtn.layer.cornerRadius = saveBtn.frame.height/2
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.borderWidth = 2
        saveBtn.layer.borderColor = customColor.cgColor
        saveBtn.layer.backgroundColor = customColor.cgColor
        self.contentTxt.delegate = self
        contentTxt.layer.borderColor = UIColor.lightGray.cgColor
        contentTxt.layer.cornerRadius = 8
//        contentTxt.text = ""
        print("oldProblem----------> :\(oldProblem)")
        // Do any additional setup after loading the view.
        self.contentTxt.text = oldProblem
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(self.contentTxt.text, forKey: "exercise_problem")
        dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when   'return' key pressed. return NO to ignore.
      {
         textField.resignFirstResponder()
         return true;
      }

    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        self.contentTxt.resignFirstResponder()
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
