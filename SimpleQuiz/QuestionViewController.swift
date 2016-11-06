//
//  QuestionViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit
import IBAnimatable
class QuestionViewController: UIViewController {
    @IBOutlet weak var questionTextView: AnimatableTextView!
    @IBOutlet var answers: [AnimatableButton]!
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var timerView: AnimatableView!
    @IBOutlet weak var timerHeight: NSLayoutConstraint!
    
    var game: Game!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        timerHeight.constant = timerContainer.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.timerHeight.constant = 0
        self.timerView.startColor = UIColor.black
        self.timerView.endColor = UIColor.white
        UIView.animate(withDuration: 15, animations: {
            self.view.layoutIfNeeded()
            self.timerView.startColor = UIColor.black
            self.timerView.endColor = UIColor.white
        }, completion: {
            (value: Bool) in
            self.game.nextQuestion()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressAnswer(_ sender: AnimatableButton) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
