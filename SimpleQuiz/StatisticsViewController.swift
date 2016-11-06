//
//  StatisticsViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    var game: GameEngine!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressBackToMenu(_ sender: Any) {
        self.dismiss(animated: true){
            self.game.returnToMenu()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return game.correctQuestions.count
        case 1:
            return game.incorrectQuestions.count
        case 2:
            return game.unansweredQuestions.count
        case 3:
            return 3
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Correct Questions"
        case 1:
            return "Incorrect Questions"
        case 2:
            return "Unanswered Questions"
        case 3:
            return "Other Statistics"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Statistic", for: indexPath) as! StatisticTableViewCell
        switch indexPath.section{
        case 0:
            let questionNr = game.correctQuestions[indexPath.row]
            cell.leftLabel.text = "Question Nr: \(questionNr)"
            cell.rightLabel.text = "Time: \(self.roundFromTimeInterval(time:game.timeIntervals[questionNr])) s"
        case 1:
            let questionNr = game.incorrectQuestions[indexPath.row]
            cell.leftLabel.text = "Question Nr: \(questionNr)"
            cell.rightLabel.text = "Time: \(self.roundFromTimeInterval(time:game.timeIntervals[questionNr])) s"
        case 2:
            let questionNr = game.unansweredQuestions[indexPath.row]
            cell.leftLabel.text = "Question Nr: \(questionNr)"
            cell.rightLabel.text = "Time: \(self.roundFromTimeInterval(time:game.timeIntervals[questionNr])) s"
        case 3:
            switch indexPath.row{
            case 0:
                cell.leftLabel.text = "Average time"
                cell.rightLabel.text = "\(self.averageAnswerTime()) s"
            case 1:
                cell.leftLabel.text = "Fastest time"
                cell.rightLabel.text = "\(self.fastestTime()) s"
            case 2:
                cell.leftLabel.text = "Slowest time"
                cell.rightLabel.text = "\(self.slowestTime()) s"
            default:
                print("")
            }
        default:
            print("")
        }
        return cell
    }
    
    private func slowestTime() -> Double{
        var time: Double = 0
        for t: Double in self.game.timeIntervals{
            if t > time{
                time = t
            }
        }
        return roundFromTimeInterval(time: time)
    }
    
    private func fastestTime() -> Double{
        var time: Double = Double.greatestFiniteMagnitude
        for t: Double in self.game.timeIntervals{
            if t < time{
                time = t
            }
        }
        return roundFromTimeInterval(time: time)
    }
    
    private func averageAnswerTime() -> Double{
        var time: Double = 0
        for t: Double in self.game.timeIntervals{
            time += t
        }
        time = time/(Double(self.game.timeIntervals.count))
        return roundFromTimeInterval(time: time)
    }
    
    private func roundFromTimeInterval(time: TimeInterval) -> Double{
        return Double(Int(time*100))/100
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
