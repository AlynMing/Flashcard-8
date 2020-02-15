//
//  ViewController.swift
//  Flashcard
//
//  Created by Natnael Mekonnen on 2/15/20.
//  Copyright © 2020 natemek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AnswerLabel.isHidden = true;
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (AnswerLabel.isHidden) {
            QuestionLabel.isHidden = true;
            AnswerLabel.isHidden = false;
        } else if (QuestionLabel.isHidden){
            AnswerLabel.isHidden = true;
            QuestionLabel.isHidden = false;
        }
    }
    
}

