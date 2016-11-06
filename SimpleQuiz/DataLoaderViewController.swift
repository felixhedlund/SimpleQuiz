//
//  DataLoaderViewController.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-03.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit
import Sync
import IBAnimatable
class DataLoaderViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestionsFromJSON()
        // Do any additional setup after loading the view.
    }
    
    private func loadQuestionsFromJSON(){
        if let path = Bundle.main.path(forResource: "questions", ofType: "json"){
            do{
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                if let jsonResult: NSArray = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                {
                    print(jsonResult)
                    syncJSON(jsonArray: jsonResult)
                }
            }catch{
                print("Could not load JSON file at path: \(path)")
            }
        }
    }
    
    private func syncJSON(jsonArray: NSArray){
        Sync.changes(jsonArray as! [[String : Any]], inEntityNamed: "Question", dataStack: dataStack){ (error) in
            if let e = error{
                let alert = UIAlertController(title: "Error", message: "Could not load data", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                if let reason = e.localizedFailureReason{
                    print(reason)
                }
            }else{
                self.activityIndicator.stopAnimating()
                let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
                self.present(vc, animated: true, completion: {
                    
                })
            }
        }
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
