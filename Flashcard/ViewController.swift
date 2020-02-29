//
//  ViewController.swift
//  Flashcard
//
//  Created by Natnael Mekonnen on 2/15/20.
//  Copyright © 2020 natemek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    var correctAnswer: Int? = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AnswerLabel.isHidden = true;
        // Making the card rounded corner and adding shadows
        card.layer.cornerRadius = 20.0;
        card.layer.shadowRadius = 15.0;
        card.layer.shadowOpacity = 0.2;
        
        QuestionLabel.layer.cornerRadius = 20.0;
        AnswerLabel.layer.cornerRadius = 20.0;
        AnswerLabel.clipsToBounds = true;
        QuestionLabel.clipsToBounds = true;
        
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.cornerRadius = 20.0;
        
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.cornerRadius = 20.0;
        
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.cornerRadius = 20.0;
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (AnswerLabel.isHidden) {
            QuestionLabel.isHidden = true;
            AnswerLabel.isHidden = false;
        } else if (QuestionLabel.isHidden){
            AnswerLabel.isHidden = true;
            QuestionLabel.isHidden = false;
            btnOptionOne.isHidden = false;
            btnOptionTwo.isHidden = false;
            btnOptionThree.isHidden = false;
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        QuestionLabel.text = question;
        AnswerLabel.text = answer;
        
        /*btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        */// randomly assign answer to choice
        let r = Int.random(in: 1 ... 3)
        correctAnswer = r
        switch r {
        case 1:
            btnOptionOne.setTitle(answer, for: .normal)
            btnOptionTwo.setTitle(extraAnswerOne, for: .normal)
            btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
            
        case 2:
            btnOptionOne.setTitle(extraAnswerOne, for: .normal)
            btnOptionTwo.setTitle(answer, for: .normal)
            btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
            
        case 3:
            btnOptionOne.setTitle(extraAnswerTwo, for: .normal)
            btnOptionTwo.setTitle(extraAnswerOne, for: .normal)
            btnOptionThree.setTitle(answer, for: .normal)
            
        default:
            btnOptionOne.setTitle("Random Not Working", for: .normal)
            btnOptionTwo.setTitle("Random Not Working", for: .normal)
            btnOptionThree.setTitle("Random Not Working", for: .normal)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardController = self
        
        if(segue.identifier == "EditSegue") {
            creationController.initialQuestion = QuestionLabel.text
            creationController.initialAnswer = AnswerLabel.text
            
            //creationController.choiceArr = []
            switch correctAnswer {
            case 1:
                creationController.initialExtraOne = btnOptionTwo.currentTitle
                creationController.initialExtraTwo = btnOptionThree.currentTitle
            case 2:
                creationController.initialExtraOne = btnOptionOne.currentTitle
                creationController.initialExtraTwo = btnOptionThree.currentTitle
            case 3:
                creationController.initialExtraOne = btnOptionTwo.currentTitle
                creationController.initialExtraTwo = btnOptionOne.currentTitle
            default:
                creationController.initialExtraTwo = "Err"
            }
            /*
            creationController.initialExtraOne = btnOptionOne.currentTitle
            creationController.initialExtraThree =  btnOptionTwo.currentTitle
            //creationController.initialExtraThree = btnOptionThree.currentTitle
            //debug
            creationController.initialExtraTwo = btnOptionThree.currentTitle
            */
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        if btnOptionOne.currentTitle == AnswerLabel!.text {
            AnswerLabel.isHidden = false;
            QuestionLabel.isHidden = true;
        } else {
            btnOptionOne.isHidden = true;
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo.currentTitle == AnswerLabel!.text {
            AnswerLabel.isHidden = false;
            QuestionLabel.isHidden = true;
        } else {
            btnOptionTwo.isHidden = true;
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree.currentTitle == AnswerLabel!.text {
            AnswerLabel.isHidden = false;
            QuestionLabel.isHidden = true;
        } else {
            btnOptionThree.isHidden = true;
        }
    }
    
}

