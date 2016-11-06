//
//  GameEngine.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit

protocol Game{
    func nextQuestion()
    func endGame()
}

class GameEngine: NSObject, Game{
    var firstVC: UIViewController!
    
    init(firstVC: UIViewController){
        super.init()
        self.firstVC = firstVC
    }
    
    func nextQuestion() {
        (UIApplication().delegate as! AppDelegate).background.animateColorForQuestion()
    }
    
    func endGame() {
        (UIApplication().delegate as! AppDelegate).background.setInitialColors()
    }
    
}
