//
//  MenuViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit
import IBAnimatable
class MenuViewController: UIViewController {
    @IBOutlet weak var startGameButton: AnimatableButton!
    @IBOutlet weak var startGameLabel: AnimatableLabel!

    var gameEngine: GameEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnToMenu(){
        self.startGameButton.slide(.in, direction: .left)
        self.startGameLabel.slide(.in, direction: .right)
        self.gameEngine = nil
    }

    @IBAction func didPressStartGame(_ sender: UIButton) {
        self.startGameLabel.fade(.out)
        self.startGameButton.slideFade(.out, direction: .down){
            self.gameEngine = GameEngine(firstVC: self)
            self.gameEngine!.startGame()
        }
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
