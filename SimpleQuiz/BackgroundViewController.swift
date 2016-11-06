//
//  BackgroundViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit
import IBAnimatable

protocol BackgroundViewColorChangeDelegate{
    func setInitialColors()
    func animateColorForQuestion()
}

class BackgroundViewController: UIViewController, BackgroundViewColorChangeDelegate {
    @IBOutlet var triangles: [AnimatableView]!
    
    var quizColors: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).background = self
        setQuizColors()
        // Do any additional setup after loading the view.
    }
    
    private func setQuizColors(){
        quizColors = [UIColor.quizRed, UIColor.quizBlue, UIColor.quizGreen, UIColor.quizOrange, UIColor.quizYellow]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInitialColors() {
        self.animateBackgroundWithColor(UIColor.white)
        self.animateTrianglesWithColor(UIColor.quizBlue)
    }
    
    func animateColorForQuestion(){
        let randomInt = Int(arc4random_uniform(5))
        let color1 = self.quizColors!.object(at: randomInt) as! UIColor
        self.quizColors.removeObject(at: randomInt)
        self.animateTrianglesWithColor(color1)
        
        
        let newRandom = Int(arc4random_uniform(4))
        let color2 = self.quizColors!.object(at: newRandom) as! UIColor
        self.animateBackgroundWithColor(color2)
        
        self.setQuizColors()
    }
    
    private func animateBackgroundWithColor(_ color: UIColor){
        UIView.animate(withDuration: 1.0, delay: 0.0, options:[UIViewAnimationOptions.curveEaseIn], animations: {
            self.view.backgroundColor = color
        }, completion:nil)
    }
    
    private func animateTrianglesWithColor(_ color: UIColor){
        UIView.animate(withDuration: 1.0, delay: 0.0, options:[UIViewAnimationOptions.curveEaseIn], animations: {
            for triangle in self.triangles{
                triangle.fillColor = color
            }
        }, completion:nil)
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
