//
//  TicTacToeViewController.swift
//  Games
//
//  Created by period6 on 4/7/21.
//  Copyright © 2021 period6. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    @IBOutlet weak var labelEight: UILabel!
    @IBOutlet weak var labelNine: UILabel!
    @IBOutlet var turnLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var xWinLabel: UILabel!
    @IBOutlet weak var oWinLabel: UILabel!
    
    var myLabel = ""
    var allLabels : [UILabel] = [ ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
    turnLabel.text = "X"
        
        allLabels = [ labelOne , labelTwo, labelThree, labelFour, labelFive , labelSix , labelSeven, labelEight , labelNine ]
    }

    
    @IBAction func resetButton(_ sender: Any) {
       reset()
    }
    
    func alertFunc ( winner : UILabel ) {
        let alert = UIAlertController (title: "\(winner.text ?? "") Wins", message: nil, preferredStyle: .alert)
         let resetButton = UIAlertAction (title: "Reset Game", style: .default ) {(action) in self.reset() }
        let continueButton = UIAlertAction (title: "Continue", style: .default, handler: nil)
            alert.addAction(continueButton)
            alert.addAction( resetButton )
            present (alert , animated: true , completion: nil)
    }
        
    
    
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let selectedPoint = sender.location(in: myView)
        for label in allLabels {
            if label.frame.contains(selectedPoint) {
                placeInLabel(myLabel: label)
            }
    }
        checkForWinner()
    }
    
    
    
    func reset( ) {
        labelOne.text = ""
        labelTwo.text = ""
        labelThree.text = ""
        labelFour.text = ""
        labelFive.text = ""
        labelSix.text = ""
        labelSeven.text = ""
        labelEight.text = ""
        labelNine.text = ""
        turnLabel.text = "X"
    }

     func checkForWinner() {
        
         if labelOne.text == labelTwo.text && labelTwo.text == labelThree.text  && labelOne.text != ""
         { alertFunc(winner: labelOne) }
            
       if labelFour.text == labelFive.text && labelFive.text == labelSix.text  && labelFour.text != ""
       { alertFunc(winner: labelFour) }
          
        if labelSeven.text == labelEight.text && labelEight.text == labelNine.text  && labelSeven.text != ""
        { alertFunc(winner: labelSeven) }
            
            if labelOne.text == labelFour.text && labelFour.text == labelSeven.text  && labelOne.text != ""
            {  alertFunc(winner: labelOne) }
                
                if labelTwo.text == labelFive.text && labelFive.text == labelEight.text  && labelTwo.text != ""
                { alertFunc(winner: labelTwo) }
                    
                    if labelThree.text == labelSix.text && labelSix.text == labelNine.text  && labelThree.text != ""
                    { alertFunc(winner: labelThree)  }
              if labelOne.text == labelFive.text && labelFive.text == labelNine.text  && labelOne.text != ""
              { alertFunc(winner: labelOne)  }
    if labelThree.text == labelFive.text && labelFive.text == labelSeven.text  && labelThree.text != ""
    { alertFunc(winner: labelThree) }
       
    }
 
     func placeInLabel (myLabel : UILabel  ){
           
            if myLabel.text == "" {
            if turnLabel.text == "X" {
                myLabel.text = turnLabel.text
                turnLabel.text = "O"
                }   else {
                myLabel.text = turnLabel.text
                turnLabel.text = "X"
                }
        }
    }





}
