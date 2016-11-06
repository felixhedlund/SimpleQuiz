//
//  GameEngine.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit
import CoreData
protocol Game{
    func nextQuestion()
    func endGame()
    func startGame()
    
    
    func timeForFinishedQuestion(timeInterval: TimeInterval)
    func setQuestionUnanswered()
    func setQuestionCorrect()
    func setQuestionIncorrect()
    
    
    func useFiftyFifty()
    func usePlusTen()
    func hasUsedFiftyFifty() -> Bool
    func hasUsedPlusTen() -> Bool
    
    func returnToMenu()
}

class GameEngine: NSObject, Game{
    var firstVC: MenuViewController!
    
    var totalQuestions = 3
    var currentQuestion = -1
    var questions = [Question]()
    var currentQuestionController: QuestionViewController?
    var timeIntervals = [TimeInterval]()
    
    var unansweredQuestions = [Int]()
    var correctQuestions = [Int]()
    var incorrectQuestions = [Int]()
    
    var hasUsed5050 = false
    var hasUsedPlus10 = false
    init(firstVC: MenuViewController){
        super.init()
        self.firstVC = firstVC
    }
    
    func startGame() {
        let fetchRequest = NSFetchRequest<Question>(entityName: "Question")
        do{
            let questions = try dataStack.mainContext.fetch(fetchRequest)
            self.addQuestionsToArray(allQuestions: questions)
            self.nextQuestion()
        }catch{
            fatalError("Could not load questions")
        }
    }
    
    func addQuestionsToArray(allQuestions: [Question]){
        let mutableQuestionArray = NSMutableArray(array: allQuestions)
        
        for _ in 0...totalQuestions - 1{
            let randomInt = Int(arc4random_uniform(UInt32(mutableQuestionArray.count)))
            questions.append(mutableQuestionArray.object(at: randomInt) as! Question)
            mutableQuestionArray.removeObject(at: randomInt)
        }
    }
    
    func nextQuestion() {
        (UIApplication.shared.delegate as! AppDelegate).background.animateColorForQuestion()
        if let c = currentQuestionController{
            c.dismiss(animated: true, completion: {
                self.addNewQuestion()
            })
        }else{
            addNewQuestion()
        }
    }
    
    func timeForFinishedQuestion(timeInterval: TimeInterval) {
        self.timeIntervals.append(timeInterval)
    }
    
    func useFiftyFifty(){
        self.hasUsed5050 = true
    }
    
    func usePlusTen() {
        self.hasUsedPlus10 = true
    }
    
    func hasUsedFiftyFifty() -> Bool{
        return self.hasUsed5050
    }
    
    func hasUsedPlusTen() -> Bool{
        return self.hasUsedPlus10
    }
    
    func setQuestionCorrect() {
        self.correctQuestions.append(self.currentQuestion)
    }
    
    func setQuestionIncorrect() {
        self.incorrectQuestions.append(self.currentQuestion)
    }
    
    func setQuestionUnanswered() {
        self.unansweredQuestions.append(self.currentQuestion)
    }
    
    private func addNewQuestion(){
        if self.currentQuestion == self.totalQuestions - 1{
            self.endGame()
        }else{
            let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Question") as! QuestionViewController
            self.currentQuestionController = vc
            vc.game = self
            
            currentQuestion += 1
            vc.question = self.questions[currentQuestion]
            
            
            self.firstVC.present(vc, animated: true, completion: {
                
            })
        }
        
    }
    
    func returnToMenu() {
        self.firstVC.returnToMenu()
    }
    
    
    func endGame() {
        (UIApplication.shared.delegate as! AppDelegate).background.setInitialColors()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Statistics") as! StatisticsViewController
        vc.game = self
        self.firstVC.present(vc, animated: true, completion: {
        })

    }
    
}
