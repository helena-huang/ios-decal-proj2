//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var knownLetters: UILabel!
    @IBOutlet weak var guessTextfield: UITextField!
    @IBOutlet weak var guessedLettersLabel: UILabel!
    @IBOutlet weak var hangmanImageView: UIImageView!
    @IBOutlet weak var newGameButton: UIBarButtonItem!
    @IBOutlet weak var startOverButton: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var gameOver = false
    var hangmanGame = Hangman()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //knownLetters.text = hangmanGame.knownString
        //backgroundImageView.image = UIImage(named: "my-hangman-img/background.png")
        //backgroundImageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        startGame(newGameButton)
        print(hangmanGame.answer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedGuess(sender: AnyObject) {
        if !gameOver && guessTextfield.text! != "" {
            hangmanGame.guessLetter(guessTextfield.text!.uppercaseString)
            print(hangmanGame.guessedLetters)
            knownLetters.text = hangmanGame.knownString
            guessedLettersLabel.text = hangmanGame.guesses()
            hangmanImageView.image = getHangmanImage()
            if hangmanGame.knownString == hangmanGame.answer {
                endGame(true)
                gameOver = true
            }
            else if hangmanGame.guessedLetters!.count == 6 {
                endGame(false)
                gameOver = true
            }
        }
    }
    
    func getHangmanImage() -> UIImage {
        let numWrongGuesses = hangmanGame.guessedLetters!.count
        switch numWrongGuesses {
        case 1: return UIImage(named: "my-hangman-img/hangman1.png")!
        case 2: return UIImage(named: "my-hangman-img/hangman2.png")!
        case 3: return UIImage(named: "my-hangman-img/hangman3.png")!
        case 4: return UIImage(named: "my-hangman-img/hangman4.png")!
        case 5: return UIImage(named: "my-hangman-img/hangman5.png")!
        case 6: return UIImage(named: "my-hangman-img/hangman6.png")!
        default: return UIImage(named: "my-hangman-img/hangman0.png")!
        }
    }
    
    func endGame(success: Bool) {
        gameOver = true
        var alertName: String
        var msg: String
        if success {
            alertName = "You win!"
            msg = "Congrats!"
        } else {
            alertName = "You lose :("
            msg = "Try again!"
        }
        let alertController = UIAlertController(title: alertName, message:
            msg + " Press Start Over to replay the same game, or New Game for a new challenge!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startGame(sender: AnyObject) {
        if sender as! NSObject == newGameButton {
            hangmanGame.start()
        } else if sender as! NSObject == startOverButton {
            hangmanGame.guessedLetters = NSMutableArray()
            hangmanGame.knownString = hangmanGame.blankAnswer
        }
        guessTextfield.text = ""
        guessedLettersLabel.text = ""
        knownLetters.text = hangmanGame.blankAnswer
        hangmanImageView.image = UIImage(named: ("my-hangman-img/hangman0.png"))
        gameOver = false
    }
}

