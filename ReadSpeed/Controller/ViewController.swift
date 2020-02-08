//
//  ViewController.swift
//  ReadSpeed
//
//  Created by mfk on 13.11.2019.
//  Copyright © 2019 mfk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        StartButton.frame = CGRect(x: view.bounds.size.width)
        
        StartButton.setTitle("Start", for: .normal)//BAŞLA
        StartButton.layer.cornerRadius = 25
        StartButton.layer.backgroundColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        StartButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        titleLbl.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
        
    }

    
    @IBAction func onClickedStart(_ sender: Any) {
        UIView.animate(withDuration: 0.6,
        animations: {
            self.StartButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.StartButton.transform = CGAffineTransform.identity
            }
        })
        performSegue(withIdentifier: "toExerciseVC", sender: nil)
    }
}

