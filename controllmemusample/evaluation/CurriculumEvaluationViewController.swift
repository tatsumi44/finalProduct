//
//  CurriculumEvaluationViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/08.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase
class CurriculumEvaluationViewController: UIViewController,UITableViewDataSource {
   
    
    
    @IBOutlet weak var mainTable: UITableView!
    
    @IBOutlet weak var postButtonItem: UIBarButtonItem!
    var evaluationArray = [Evaluation]()
    var db: Firestore!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        postButtonItem.tintColor = UIColor.orange
        mainTable.dataSource = self
//        mainTable.rowHeight = 200
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        evaluationArray = [Evaluation]()
        db = Firestore.firestore()
        db.collection("courseEvaluation").getDocuments { (snap, error) in
            if let error = error{
                print("\(error)")
            }else{
                for document in (snap?.documents)!{
                    let data = document.data()
                    self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                }
                self.mainTable.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaluationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let courseName = cell.contentView.viewWithTag(1) as! UILabel
        let year = cell.contentView.viewWithTag(2) as! UILabel
        let course = cell.contentView.viewWithTag(3) as! UILabel
        let dayOfTheWeek = cell.contentView.viewWithTag(4) as! UILabel
        let courseTime = cell.contentView.viewWithTag(5) as! UILabel
        let courseEvaluation = cell.contentView.viewWithTag(6) as! UILabel
        let different = cell.contentView.viewWithTag(7) as! UILabel
        let coursedetail = cell.contentView.viewWithTag(8) as! UILabel
        
        courseName.text = evaluationArray[indexPath.row].className
        year.text = evaluationArray[indexPath.row].year
        course.text = evaluationArray[indexPath.row].course
        dayOfTheWeek.text = evaluationArray[indexPath.row].dayOfTheWeek
        courseTime.text = evaluationArray[indexPath.row].courseTime
        courseEvaluation.text = "授業評価　\(evaluationArray[indexPath.row].courseEvaluation!)"
        courseEvaluation.textColor = UIColor.red
        different.text = "難易度　\(evaluationArray[indexPath.row].different!)"
        different.textColor = UIColor.red
        coursedetail.text = evaluationArray[indexPath.row].coursedetail
        
        return cell
    }
    
    
    @IBAction func postButton(_ sender: UIBarButtonItem) {
    }
    


}
