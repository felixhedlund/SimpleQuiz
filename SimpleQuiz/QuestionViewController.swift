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
    
    @IBOutlet weak var questionForeGround: AnimatableView!
    
    @IBOutlet weak var questionImage: AnimatableImageView!
    
    
    @IBOutlet var answers: [AnimatableButton]!
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var timerView: AnimatableView!
    @IBOutlet weak var timerHeight: NSLayoutConstraint!
    
    var game: Game!
    var timer: Timer!
    var question: Question!
    
    let startTime: TimeInterval = 15
    
    let maxTime: TimeInterval = 60
    var totalQuestionTimer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAnswers()
        self.setQuestion()
        // Do any additional setup after loading the view.
    }
    
    private func setQuestion(){
        if let imagePath = question.imagePath{
            self.questionTextView.isHidden = true
            self.questionForeGround.isHidden = true
            self.questionImage.image = UIImage(named: imagePath)
        }else{
            self.questionTextView.text = self.question.question!
        }
        
    }
    
    private func setAnswers(){
        let alternatives = NSKeyedUnarchiver.unarchiveObject(with: question.alternatives! as Data) as! [String]
        var index = 0
        for answer in alternatives{
            self.answers[index].setTitle(answer, for: .normal)
            index += 1
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        timerHeight.constant = timerContainer.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.beginTimer(totalTime: startTime)
        totalQuestionTimer = Timer.scheduledTimer(withTimeInterval: maxTime, repeats: false, block: { (timer) in
        })
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
                self.game.setQuestionUnanswered()
                self.setTotalTime()
                self.game.nextQuestion()
            }
            
        })
    }
    
    private func setTotalTime(){
        let totalTime = self.maxTime - self.totalQuestionTimer.fireDate.timeIntervalSinceNow
        self.game.timeForFinishedQuestion(timeInterval: totalTime)
        self.totalQuestionTimer.invalidate()
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
        var uncorrectAnswerArray: [Int] = [Int]()
        
        var index = 0
        for _ in self.answers{
            if isIndexCorrectAnswer(index: index){
                
            }else{
                uncorrectAnswerArray.append(index)
            }
            index += 1
        }
        
        for _ in 0...1{
            let randomInt = Int(arc4random_uniform(UInt32(uncorrectAnswerArray.count)))
            let removedAnswer = uncorrectAnswerArray.remove(at: randomInt)
            self.answers[removedAnswer].fade(.out)
        }
        
    }
    
    private func isIndexCorrectAnswer(index: Int) -> Bool{
        if index == Int(self.question.correctAlternative){
            return true
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressAnswer(_ sender: AnimatableButton) {
        self.setTotalTime()
        self.timer.invalidate()
        self.timerView.layer.removeAllAnimations()
        var index = 0
        for button in self.answers{
            if sender == button{
                if self.isIndexCorrectAnswer(index: index){
                    self.game.setQuestionCorrect()
                    self.answerWasChosen(correct: true, button: sender)
                }else{
                    self.game.setQuestionIncorrect()
                    self.answerWasChosen(correct: false, button: sender)
                }
            }
            index += 1
        }
    }
    
    private func answerWasChosen(correct: Bool, button: AnimatableButton){
        if correct{
            button.fillColor = UIColor.green
        }else{
            button.fillColor = UIColor.red
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
            self.game.nextQuestion()
        })
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
