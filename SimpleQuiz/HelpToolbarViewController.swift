//
//  HelpToolbarViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit

protocol HelpToolbarDelegate{
    func didPressFiftyFifty()
    func didPressPlusTen()
}

class HelpToolbarViewController: UIViewController {
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var fiftyFiftyButton: UIBarButtonItem!
    @IBOutlet weak var plusTenButton: UIBarButtonItem!
    var delegate: HelpToolbarDelegate!
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if game.hasUsedFiftyFifty(){
            fiftyFiftyButton.isEnabled = false
        }
        if game.hasUsedPlusTen(){
            plusTenButton.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func didPressFiftyFifty(_ sender: Any) {
        fiftyFiftyButton.isEnabled = false
        self.delegate.didPressFiftyFifty()
        game.useFiftyFifty()
    }
    @IBAction func didPressPlusTen(_ sender: Any) {
        plusTenButton.isEnabled = false
        delegate.didPressPlusTen()
        game.usePlusTen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
