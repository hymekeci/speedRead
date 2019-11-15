
import Foundation

class Exercise {

    var title : String
    var text : [String] = []

    init(exerciseTitle:String, exerciseText:[String]) {
        title = exerciseTitle
        text = exerciseText
    }
}
