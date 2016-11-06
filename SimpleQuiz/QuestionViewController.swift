//
//  QuestionViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit
import IBAnimatable
class QuestionViewController: UIViewController, HelpToolbarDelegate {
    @IBOutlet weak var questionTextView: AnimatableTextView!
    @IBOutlet var answers: [AnimatableButton]!
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var timerView: AnimatableView!
    @IBOutlet weak var timerHeight: NSLayoutConstraint!
    
    var game: Game!
    var timer: Timer!
    var question: Question!
    
    let startTime: TimeInterval = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        timerHeight.constant = timerContainer.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.beginTimer(totalTime: startTime)
    }
    
    private func beginTimer(totalTime: TimeInterval){
        print("Begin Timer with time: \(totalTime)")
        self.timer = Timer.scheduledTimer(withTimeInterval: totalTime, repeats: false, block: { (timer) in
           
        })
        
        
        self.timerHeight.constant = 0
        UIView.animate(withDuration: totalTime, animations: {
            self.view.layoutIfNeeded()
        }, completion: {
            (value: Bool) in
            if value == true{
                self.game.nextQuestion()
            }
            
        })
    }
    
    func didPressPlusTen() {
        self.timerView.layer.removeAllAnimations()
        let timeLeft = timer.fireDate.timeIntervalSinceNow
        let newTimeLeft = timeLeft + 10
        self.timer.invalidate()
        
        let fullHeight = self.timerContainer.frame.height
        let newHeight = (fullHeight / CGFloat(self.startTime))*CGFloat(newTimeLeft)
        
        self.timerHeight.constant = newHeight
        self.view.layoutIfNeeded()
        self.beginTimer(totalTime: newTimeLeft)
    }
    
    func didPressFiftyFifty() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressAnswer(_ sender: AnimatableButton) {
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? HelpToolbarViewController{
            destination.game = self.game
            destination.delegate = self
        }
    }
    

}
