//
//  ViewController.swift
//  Flashcard
//
//  Created by Natnael Mekonnen on 2/15/20.
//  Copyright © 2020 natemek. All rights reserved.
//

import UIKit
import SAConfettiView

struct Flashcard {
    var question: String
    var answer: String
    var extraAnswerOne: String!
    var extraAnswerTwo: String!
}

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var CardCounterLabel: UILabel!
    
    var correctAnswerPosition: Int? = 2
    var confettiView: SAConfettiView!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    var currentCardNumber = 0
    var totalNumberOfCards = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Confetti View
        
        confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .Diamond
        view.addSubview(confettiView)
        self.view.sendSubviewToBack(confettiView)
        confettiView.intensity = 0.8
        
        // Do any additional setup after loading the view.
        // Setting up the default flashcard
        readSavedFlashcards()
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Ethiopia?", answer: "Addis Ababa", extraAnswerOne: "Dire Dawa", extraAnswerTwo: "Bahir Dar")
        } else {
            updateFlashcard(flashcard: flashcards[currentIndex])
        }
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
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo)
        flashcards.append(flashcard)
        currentIndex = flashcards.count - 1
        // Logging to console
        print("😎 Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        print("Our current index is \(currentIndex)")
        
        updateFlashcard(flashcard: flashcard)
        saveAllFlashcardsToDisk()
    }
    
    func updateFlashcard(flashcard: Flashcard) {
        updateNextPrevButtons()
        QuestionLabel.text = flashcard.question;
        AnswerLabel.text = flashcard.answer;
        
        totalNumberOfCards = flashcards.count
        currentCardNumber = currentIndex + 1
        CardCounterLabel.text = String(currentCardNumber) + " of " + String(totalNumberOfCards);
        
        // randomly assign answer to choice
        correctAnswerPosition = Int.random(in: 1 ... 3)
        switch correctAnswerPosition {
        case 1:
            btnOptionOne.setTitle(flashcard.answer, for: .normal)
            btnOptionTwo.setTitle(flashcard.extraAnswerOne, for: .normal)
            btnOptionThree.setTitle(flashcard.extraAnswerTwo, for: .normal)
            
        case 2:
            btnOptionOne.setTitle(flashcard.extraAnswerOne, for: .normal)
            btnOptionTwo.setTitle(flashcard.answer, for: .normal)
            btnOptionThree.setTitle(flashcard.extraAnswerTwo, for: .normal)
            
        case 3:
            btnOptionOne.setTitle(flashcard.extraAnswerTwo, for: .normal)
            btnOptionTwo.setTitle(flashcard.extraAnswerOne, for: .normal)
            btnOptionThree.setTitle(flashcard.answer, for: .normal)
            
        default:
            btnOptionOne.setTitle("Random Not Working", for: .normal)
            btnOptionTwo.setTitle("Random Not Working", for: .normal)
            btnOptionThree.setTitle("Random Not Working", for: .normal)
        }
        
        AnswerLabel.isHidden = true;
        QuestionLabel.isHidden = false;
        btnOptionOne.isHidden = false;
        btnOptionTwo.isHidden = false;
        btnOptionThree.isHidden = false;
        if confettiView.isActive() {
            confettiView.stopConfetti()
        }
    }
    
    /*
     * This function is called whenever a button leads into the segue view and initializes the
     * textfields in the creation view according to type of button is tapped.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardController = self
        
        /* Only when it is the edit segue, it will pass in the current question, answer, and
         * choices accordingly.
         */
        if(segue.identifier == "EditSegue") {
            creationController.initialQuestion = QuestionLabel.text
            creationController.initialAnswer = AnswerLabel.text
            creationController.initialFlashcard = flashcards[currentIndex]
            creationController.isEditingFlashcard = true
            
            /* Since the choice will be shuffled, to identify, the corrrect answer position is
             * stored in the variable so the text field will be assigned accordingly
             */
            switch correctAnswerPosition {
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
        }
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map{ (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("🎉 Flashcard saved to UserDefaults")
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func deleteCurrentFlashcard() {
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        updateFlashcard(flashcard: flashcards[currentIndex])
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        animateCardOut()
        
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        animateCardOutReverse()
//        animateCardIn()
//        // Increase index count
//        currentIndex = currentIndex - 1
//        // Update the labels
//        updateFlashcard(flashcard: flashcards[currentIndex])
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                            self.card.transform = CGAffineTransform.identity.translatedBy(x: -350.0, y: 0.0)
                       }, completion: { finished in
                            // Increase index count
                            self.currentIndex = self.currentIndex + 1
                            // Update the labels
                            self.updateFlashcard(flashcard: self.flashcards[self.currentIndex])
                            // Run other animation
                            self.animateCardIn()
                        })
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 350, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutReverse() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 350, y: 0)
        }, completion: { finished in
            // Decrease index count
            self.currentIndex = self.currentIndex - 1
            // Update the labels
            self.updateFlashcard(flashcard: self.flashcards[self.currentIndex])
            // Run other animation
            self.animateCardInReverse()
        })
    }
    
    func animateCardInReverse() {
        card.transform = CGAffineTransform.identity.translatedBy(x: -350, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
        if (confettiView.isActive()) {
            confettiView.stopConfetti()
        }
    }
    
    func flipFlashcard() {
        UIView.transition(with: card,
                          duration: 0.3,
                          options: .transitionFlipFromRight,
                          animations: {
                            if (self.AnswerLabel.isHidden) {
                                self.QuestionLabel.isHidden = true;
                                self.AnswerLabel.isHidden = false;
                            } else if (self.QuestionLabel.isHidden){
                                self.AnswerLabel.isHidden = true;
                                self.QuestionLabel.isHidden = false;
                                self.btnOptionOne.isHidden = false;
                                self.btnOptionTwo.isHidden = false;
                                self.btnOptionThree.isHidden = false;
                            }
                          })

        
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        if btnOptionOne.currentTitle == AnswerLabel!.text {
            if !confettiView.isActive() {
                confettiView.startConfetti()
            }
            flipFlashcard()
        } else {
            btnOptionOne.isHidden = true;
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo.currentTitle == AnswerLabel!.text {
            if !confettiView.isActive() {
                confettiView.startConfetti()
            }
            flipFlashcard()
        } else {
            btnOptionTwo.isHidden = true;
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree.currentTitle == AnswerLabel!.text {
            if !confettiView.isActive() {
                confettiView.startConfetti()
            }
            flipFlashcard()
        } else {
            btnOptionThree.isHidden = true;
        }
    }
    
}

