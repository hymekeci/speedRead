//
//  ExerciseVC.swift
//  ReadSpeed
//
//  Created by mfk on 13.11.2019.
//  Copyright © 2019 mfk. All rights reserved.
//

import UIKit

class ExerciseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseArray=[Exercise]()
    var chosenExercise : Exercise?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let firstText = Exercise(exerciseTitle: "Çalıkuşu", exerciseText: ["Feride", "küçük yaşta", "anne ve babasını kaybeder.", "Teyzesinin", "korumasıyla", "bir Fransız yatılı", "okulunda okur.", "Yaramazlıkları yüzünden arkadaşları", "okulda", "ona 'Çalıkuşu' adını takarlar.", "yaz tatillerini", "teyzesinin köşkünde", "geçirir.Teyzesinin", "yakışıklı oğlu", "Kamuran ile"," birbirlerini", "severler ve nişanlanırlar. Feride, düğün günü, bir kadının getirdiği mektuptan Kamuran'ın lsviçre'de iken Münevver adında hasta bir kızla ilişkisi olduğunu, ona evlenme sözü verdiğini öğrenir öğrenmez, her şeyi yüzüstü bırakıp kaçar. Feride, Anadolu'nun çeşitli yerlerinde (Zeyniler Köyü, Bursa, Çanakkale ... )"])
        let secondText = Exercise(exerciseTitle: "Simyacı", exerciseText: ["Yüreğinin", "sesini", "dinleyerek gezgin olma isteyen ve dünyanın", "farklı yerlerinde yaşarsa mutlu olabileceğine inanan Santiago’nun gördüğü bir rüya ve babasının da telkinleri ile İspanya’dan kalkıp Mısır Piramitlerinin eteklerinde olduğuna", "inandığı hazinesini aramaya gitmesidir.  Endülüslü çobanın çıktığı bu yolculuk fiziki âlemde Mısırdaki Piramitlere doğru", "içsel âlemde ise kendini ve mutluluğu arayıp bulmak şeklinde", "olmaktadır.Santiago’nun bu yolculuğu İslam tasavvufundan izler taşıyan felsefi", "bir yolculuğa da dönüşmektedir."])
        let thirdText = Exercise(exerciseTitle: "Dönüşüm", exerciseText: ["Gregor Samsa", "bir sabah bunaltıcı düşlerden", "uyandığında kendini dev bir böceğe", "dönüşmüş olarak bulur. İlk başta gördüklerinin", "gerçek olduğunu inanmak istemez ancak yatağından", "kalkmak isteyince buna inanmak zorunda kalır.", "O artık dev bir böcektir. Her sabah işe gitmek", "için bindiği tren saat altıda hareket etmektedir; ", "bu yüzden en geç saat beşte uyanmak", "zorundadır. Ancak saate baktığında saatin hemen hemen yedi olduğunu görür.", "Kalkmak istemektedir ama artık ona yardımcı olacak kuvvetli bacaklarının yerinde birbirinden bağımsız hareket ediyormuş gibi görünen onlarca bacakçık bulunmaktadır."])
        let forthText = Exercise(exerciseTitle: "1984", exerciseText: ["2. Dünya Savaşı’ndan sonra yeniden kurulan bir", "dünyanın 1984 yılını anlatan", "romanda Winston Smith’in", "sisteme karşı kendi", "içinde ayaklanmasını ve bu ayaklanma", "için destek arayışını görmekteyiz.", "Winston Smith’in bu arayış içerisinde güvendiği kişilerin", "en başından bu yana sistemin savunucusu olması ve Winston Smith’in tuzağa çekilmesi sonucu türlü işkenceler ile Winston Smith’i de sisteme ayak uyduran ve sistemden memnun olan birine dönüştürülmesi ile karşı karşıya kalırız."])
        let fifthText = Exercise(exerciseTitle: "1Q84", exerciseText: ["Kitabın ana hikayesi",  "en önemli karakter olan kadınlara şiddet uygulayan", "erkekleri öldüren seri katil Aomame", "etrafında dönüyor. Aomame çocuk yurdunda büyümüş", "bağlılık gerektiren uzun süreli", "ilişkiler yerine günlük ilişkiler yaşayan", "kalbinde Tengo’yu taşıyan bir kadın. Diğer ana karakterse Aomame’nin çocukluk aşkı Tengo. Kablolu TV aboneliği satmayı hayatının", "merkezine taşımış bir baba tarafından büyütülmüş, annesi  hakkında çok az bilen", "her konuda özellikle de matematik alanında dahilik seviyesinde başarılıyken okulda matematik öğretmeni olmayı seçen", "hayatının aşkı Aomame’yi bekleyen bir adam."])
        
        exerciseArray.append(firstText)
        exerciseArray.append(secondText)
        exerciseArray.append(thirdText)
        exerciseArray.append(forthText)
        exerciseArray.append(fifthText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = exerciseArray[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenExercise = exerciseArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! ExerciseDetailViewController
            destinationVC.selectedExercise = chosenExercise
        }
    }
    
}
