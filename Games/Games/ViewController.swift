//
//  ViewController.swift
//  Games
//
//  Created by period6 on 4/5/21.
//  Copyright © 2021 period6. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UICollisionBehaviorDelegate {
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var paddleView: UIView!
    var dynamicAnimator : UIDynamicAnimator!
    var pushBehavior : UIPushBehavior!
    var collisionBehavior : UICollisionBehavior!
    @IBOutlet weak var brick1: UIView!
    @IBOutlet weak var brick2: UIView!
    @IBOutlet weak var brick3: UIView!
    @IBOutlet weak var brick4: UIView!
    @IBOutlet weak var brick5: UIView!
    @IBOutlet weak var brick6: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var modeSelect: UISegmentedControl!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var brickcount = 6
    var allBricks : [UIView] = []
    var ballBehavior : UIDynamicItemBehavior!
    var paddleBehavior : UIDynamicItemBehavior!
    var brickBehavior : UIDynamicItemBehavior!
    override func viewDidLoad() {
        super.viewDidLoad()
            ballView.layer.masksToBounds = true
                 ballView.layer.cornerRadius = ballView.bounds.width/2
                 allBricks = [ brick1 , brick2 , brick3 , brick4 , brick5 , brick6 ]
                 paddleView.isHidden = true
                 ballView.isHidden = true
                
    }
    @IBAction func startButton(_ sender: UIButton) {
   
        ballView.center = CGPoint(x: 180, y: 360)
        brickcount = 6
        let sound = AVSpeechSynthesizer()
        let utter = AVSpeechUtterance(string: "Good Luck")
        sound.speak(utter)
        for brick in allBricks {
            brick.isHidden = false
        }
        paddleView.isHidden = false
        ballView.isHidden = false
        sender.isHidden = true
        modeSelect.isHidden = true
        dynamicBehavior()
                collisionBehavior.collisionDelegate = self
        
    }
    
    @IBAction func modeSelect(_ sender: UISegmentedControl) {
        for brick in allBricks {
            switch sender.selectedSegmentIndex {
            case 0: brick.backgroundColor = UIColor.blue ;
            case 1: brick.backgroundColor = UIColor.purple ;
            case 2: brick.backgroundColor = UIColor.red ;
        default:
            break
        }
        }
    }
    
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        paddleView.center = CGPoint(x: sender.location(in: view).x, y: paddleView.center.y)
        dynamicAnimator.updateItem(usingCurrentState: paddleView)
    }
    func dynamicBehavior () {
        dynamicAnimator = UIDynamicAnimator(referenceView: view )
        pushBehavior = UIPushBehavior (items: [ballView], mode: .instantaneous)
        pushBehavior.active = true
        pushBehavior.pushDirection = CGVector (dx: 0.5 , dy: 0.5)
        pushBehavior.magnitude = 1.0
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [ballView, paddleView] + allBricks)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        ballBehavior = UIDynamicItemBehavior (items: [ballView])
        ballBehavior.elasticity = 1.0
        ballBehavior.friction = 0.0
        ballBehavior.resistance = -0.05
        dynamicAnimator.addBehavior(ballBehavior)
        
        paddleBehavior = UIDynamicItemBehavior (items: [paddleView])
        paddleBehavior.density = 1000000000000.0
        paddleBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(paddleBehavior)
        
        brickBehavior = UIDynamicItemBehavior (items: allBricks)
        brickBehavior.density = 10000.0
        brickBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(brickBehavior)
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        for brick in allBricks {
            if item1.isEqual(ballView) && item2 .isEqual(brick) {
                if brick.backgroundColor == UIColor.blue {   brick.isHidden = true
                                          collisionBehavior.removeItem(brick)
                                          brickcount = brickcount - 1
                }
                if brick.backgroundColor == UIColor.purple {
                    brick.backgroundColor = UIColor.blue
                    print("works2")
                }
                if brick.backgroundColor == UIColor.red {
                    brick.backgroundColor = UIColor.purple
                    print("works")
                }

               
                    if brickcount == 0 {
                    alert(result: "you win")
                        startButton.isHidden = false
                        modeSelect.isHidden = false
                        ballView.isHidden = true
                        paddleView.isHidden = false
                        dynamicAnimator.removeAllBehaviors() }
                

            }
        }
     
    }
    func alert ( result : String) {
        let alert = UIAlertController (title: "\(result)", message: "", preferredStyle: .alert)
        let resetButton = UIAlertAction (title: "Play again ", style: .default) { (action) in
            for brick in self.allBricks {
                brick.isHidden = false
                brick.backgroundColor = UIColor.blue
            }
        }
        alert.addAction(resetButton)
        present( alert , animated: true , completion: nil)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint ) {
        if p.y > paddleView.center.y {
            alert( result: "you lose")
            dynamicAnimator.removeAllBehaviors()
            startButton.isHidden = false
            modeSelect.isHidden = false
                ballView.isHidden = true
            }
        }
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        
    }



