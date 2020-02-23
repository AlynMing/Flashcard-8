//
//  CreationViewController.swift
//  Flashcard
//
//  Created by Natnael Mekonnen on 2/22/20.
//  Copyright © 2020 natemek. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController: ViewController!
    
    @IBOutlet weak var qTextField: UITextField!
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var choiceOne: UITextField!
    @IBOutlet weak var choiceTwo: UITextField!
    @IBOutlet weak var choiceThree: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialExtraOne: String?
    var initialExtraTwo: String?
    var initialExtraThree: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        qTextField.text = initialQuestion
        aTextField.text = initialAnswer
        
        choiceOne.text = initialExtraOne
        choiceTwo.text = initialExtraTwo
        choiceThree.text = initialExtraThree
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let qText = qTextField.text
        let aText = aTextField.text
        
        let extraOne = choiceOne.text
        let extraTwo = choiceTwo.text
        //let extraThree = choiceThree.text
        
        if (qText == "" || aText == "") {
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(alert, animated: true)
        } else {
            flashcardController.updateFlashcard(question: qText!, answer: aText!, extraAnswerOne: extraOne, extraAnswerTwo: extraTwo)
            dismiss(animated: true)
        }
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
