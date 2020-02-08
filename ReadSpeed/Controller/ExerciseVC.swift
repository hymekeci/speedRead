//
//  ExerciseVC.swift
//  ReadSpeed
//
//  Created by mfk on 13.11.2019.
//  Copyright © 2019 mfk. All rights reserved.
//

import UIKit

class ExerciseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
      
    
    @IBOutlet weak var describeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIBarButtonItem!
   

    var lblExercise : String = "EXERCISE"
    var trainContent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trainContent = ["Follow words vertically.", "Follow words vertically in two columns.", "Follow words vertically in three columns.","Follow double words in two columns.","Follow triple words in two columns.","Follow triple letters in two columns.","Follow words in square pattern.","Catch the flying words.","Follow first and last words.","Follow middle words.","Read in blocks.","Read passages in blocks.","Catch the flashing words.","Catch the triple flashing words.","Find words in puzzle.","Make your score."]
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
//        let k = UserDefaults.standard.integer(forKey: "exercise2_level")
//        print(k)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell") as? contentCell else {return UITableViewCell()}
        cell.exerciseTitleLbl.text = "\(lblExercise) \(indexPath.row  + 1)"
        cell.exerciseContentLbl.text = trainContent[indexPath.row]
        let k = UserDefaults.standard.integer(forKey: "exercise\(indexPath.row + 1)_level")
        cell.levelLbl.text = String(k)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
//            performSegue(withIdentifier: "toDetailsVC1", sender: nil)
            performSegue(withIdentifier: "toDetailsVC2", sender: nil)
            break
        case 1:
            performSegue(withIdentifier: "toDetailsVC3", sender: nil)
            break
        case 2:
            performSegue(withIdentifier: "toDetailsVC4", sender: nil)
        case 3:
            performSegue(withIdentifier: "toDetailsVC5", sender: nil)
        case 4:
            performSegue(withIdentifier: "toDetailsVC6", sender: nil)
        case 5:
            performSegue(withIdentifier: "toDetailsVC7", sender: nil)
        case 6:
            performSegue(withIdentifier: "toDetailsVC11", sender: nil)
        case 7:
            performSegue(withIdentifier: "toDetailsVC12", sender: nil)
        case 8:
            performSegue(withIdentifier: "toDetailsVC13", sender: nil)
        case 9:
            performSegue(withIdentifier: "toDetailsVC14", sender: nil)
        case 10:
            performSegue(withIdentifier: "toDetailsVC15", sender: nil)
        case 11:
            performSegue(withIdentifier: "toDetailsVC16", sender: nil)
        case 12:
            performSegue(withIdentifier: "toDetailsVC17", sender: nil)
        case 13:
            performSegue(withIdentifier: "toDetailsVC18", sender: nil)
        case 14:
            performSegue(withIdentifier: "toDetailsVC19", sender: nil)
        case 15:
            performSegue(withIdentifier: "toDetailsVC20", sender: nil)
        default:
            break
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetailsVC"{
//            let destinationVC = segue.destination as! ExerciseDetailViewController
//            destinationVC.selectedExercise = chosenExercise
//        }
    }
    
}
