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
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true;
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        AnswerLabel.isHidden = false;
        QuestionLabel.isHidden = true;
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true;
    }
}

