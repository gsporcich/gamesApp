//
//  PongViewController.swift
//  Games
//
//  Created by period6 on 5/17/21.
//  Copyright © 2021 period6. All rights reserved.
//

import UIKit

class PongViewController: UIViewController , UICollisionBehaviorDelegate {
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var bluePaddle: UIView!
    @IBOutlet weak var orangePaddle: UIView!
    
    var paddles : [UIView] = []
    var dynamicAnimator : UIDynamicAnimator!
    var pushBehavior : UIPushBehavior!
    var collisionBehavior : UICollisionBehavior!
    var ballBehavior : UIDynamicItemBehavior!
    @IBOutlet weak var startButton: UIButton!
    var paddleBehavior : UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballView.layer.masksToBounds = true
        ballView.layer.cornerRadius = ballView.bounds.width/2
        paddles = [ bluePaddle , orangePaddle]
       
        // Do any additional setup after loading the view.
    }
    
    func dynamicBehavior() {
        let number = Double.random(in: -1.0..<1.0)
        dynamicAnimator = UIDynamicAnimator(referenceView: view )
        pushBehavior = UIPushBehavior (items: [ballView], mode: .instantaneous)
        pushBehavior.active = true
        pushBehavior.pushDirection = CGVector (dx: number , dy: number)
        pushBehavior.magnitude = 1.0
        dynamicAnimator.addBehavior(pushBehavior)
        collisionBehavior = UICollisionBehavior(items: [ballView] + paddles)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        ballBehavior = UIDynamicItemBehavior (items: [ballView])
        ballBehavior.elasticity = 1.0
        ballBehavior.friction = 0.0
        ballBehavior.resistance = -0.05
        dynamicAnimator.addBehavior(ballBehavior)
        
        paddleBehavior = UIDynamicItemBehavior (items: paddles )
        paddleBehavior.density = 1000000000000.0
        paddleBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(paddleBehavior)

    }
    @IBAction func startButton(_ sender: Any) {
        dynamicBehavior()
        startButton.isHidden = true
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        bluePaddle.center = CGPoint (x: bluePaddle.center.x , y: sender.location(in: view).y)
    }
    @IBAction func panGesture2(_ sender: UIPanGestureRecognizer) {
        orangePaddle.center = CGPoint (x: orangePaddle.center.x , y: sender.location(in: view).y)

    }
    
      func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint ) {

    if p.x <= bluePaddle.center.x {
    dynamicAnimator.removeAllBehaviors()
         print("it works B")
        }
        if p.x >= orangePaddle.center.x {
           dynamicAnimator.removeAllBehaviors()
                print("it works O")
       }
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


