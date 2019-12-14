//
//  ViewController.swift
//  speedRead
//
//  Created by Yavuzhan Mekeci on 11/15/19.
//  Copyright © 2019 Yavuzhan Mekeci. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var entranceTableView: UITableView!
    
    var entranceList = [entranceListObjects]()
    var chosenCell : entranceListObjects?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        entranceTableView.dataSource = self
        entranceTableView.delegate = self
        
        //Entrance List Object
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entranceList.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = entranceList[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCell = entranceList[indexPath.row]
        if entranceList[indexPath.row] == "1"{
            self.performSegue(withIdentifier: "toMeasureSpeed", sender: nil)
        }else if entranceList[indexPath.row] == "2"{
            self.performSegue(withIdentifier: "toExercises", sender: nil)
        }else if entranceList[indexPath.row] == "3"{
            self.performSegue(withIdentifier: "toProgressPage", sender: nil)
        }else if entranceList[indexPath.row] == "4"{
            self.performSegue(withIdentifier: "toWordsData", sender: nil)
        }else if entranceList[indexPath.row] == "5"{
            self.performSegue(withIdentifier: "toPassageData", sender: nil)
        }else if entranceList[indexPath.row] == "6"{
            self.performSegue(withIdentifier: "toSettings", sender: nil)
        }else {
            print("Please select a list member.")
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMeasureSpeed"{
            let destinationVC = segue.destination as! measureSpeedPage
            
        }else if segue.identifier == "toExercises"{
            let destinationVC = segue.destination as! exercisesPage
            
        }else if segue.identifier == "toProgressPage"{
            let destinationVC = segue.identifier as! progressPage
            
        }else if segue.identifier == "toWordsData"{
            let destinationVC = segue.identifier as! wordsDataPage
            
        }else if segue.identifier == "toPassagesData"{
            let destinationVC = segue.identifier as! passageDataPage
            
        }else if segue.identifier == "toSettings"{
            let destinationVC = segue.identifier as! settingsPage
            
        }else {
            print("Please select a list member")
        }
    }
}

