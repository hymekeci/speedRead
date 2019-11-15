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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onClickedStart(_ sender: Any) {
        performSegue(withIdentifier: "toExerciseVC", sender: nil)
    }
}

