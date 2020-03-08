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
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraChoiceOne: UITextField!
    @IBOutlet weak var extraChoiceTwo: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialExtraOne: String?
    var initialExtraTwo: String?
    var initialFlashcard: Flashcard!
    var isEditingFlashcard: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        
        extraChoiceOne.text = initialExtraOne
        extraChoiceTwo.text = initialExtraTwo
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        let extraOne = extraChoiceOne.text
        let extraTwo = extraChoiceTwo.text
        
        if (questionText == "" || answerText == "") {
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(alert, animated: true)
        } else {
            if isEditingFlashcard {
                isEditingFlashcard = false
                initialFlashcard.question = questionText!
                initialFlashcard.answer = answerText!
                initialFlashcard.extraAnswerOne = extraOne
                initialFlashcard.extraAnswerTwo = extraTwo
                
                flashcardController.updateFlashcard(flashcard: initialFlashcard)
            } else {
                flashcardController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraOne, extraAnswerTwo: extraTwo)
            }
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
