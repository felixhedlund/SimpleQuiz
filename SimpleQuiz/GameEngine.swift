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
    
    
    func useFiftyFifty()
    func usePlusTen()
    func hasUsedFiftyFifty() -> Bool
    func hasUsedPlusTen() -> Bool
}

class GameEngine: NSObject, Game{
    var firstVC: UIViewController!
    
    var questionsLeft = 10
    var questions = [Question]()
    var currentQuestionController: QuestionViewController?
    
    var hasUsed5050 = false
    var hasUsedPlus10 = false
    init(firstVC: UIViewController){
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
        
        for _ in 0...questionsLeft - 1{
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
    
    private func addNewQuestion(){
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Question") as! QuestionViewController
        self.currentQuestionController = vc
        vc.game = self
        self.firstVC.present(vc, animated: true, completion: {
            
        })
    }
    
    func endGame() {
        (UIApplication.shared.delegate as! AppDelegate).background.setInitialColors()
    }
    
}
