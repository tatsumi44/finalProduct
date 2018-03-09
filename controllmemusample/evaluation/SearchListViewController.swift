//
//  SearchListViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/09.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase

class SearchListViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var mainTable: UITableView!
    var tagArray = [[String]]()
    var db: Firestore!
    var contentsNum: Int!
    var evaluationArray = [Evaluation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        evaluationArray = [Evaluation]()
        print(tagArray[0][0])
        print(tagArray[0][1])
        db = Firestore.firestore()
        switch tagArray.count {
        case 1:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                        print(self.evaluationArray)
                    }
                    self.mainTable.reloadData()
                }
            })
            
        case 2:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").whereField("\(tagArray[1][0])", isEqualTo: "\(tagArray[1][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                    }
                    self.mainTable.reloadData()
                }
            })
        case 3:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").whereField("\(tagArray[1][0])", isEqualTo: "\(tagArray[1][1])").whereField("\(tagArray[2][0])", isEqualTo: "\(tagArray[2][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                    }
                    self.mainTable.reloadData()
                }
            })
        case 4:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").whereField("\(tagArray[1][0])", isEqualTo: "\(tagArray[1][1])").whereField("\(tagArray[2][0])", isEqualTo: "\(tagArray[2][1])").whereField("\(tagArray[3][0])", isEqualTo: "\(tagArray[3][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                    }
                    self.mainTable.reloadData()
                }
            })
        case 5:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").whereField("\(tagArray[1][0])", isEqualTo: "\(tagArray[1][1])").whereField("\(tagArray[2][0])", isEqualTo: "\(tagArray[2][1])").whereField("\(tagArray[3][0])", isEqualTo: "\(tagArray[3][1])").whereField("\(tagArray[4][0])", isEqualTo: "\(tagArray[4][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                    }
                    self.mainTable.reloadData()
                }
            })
        case 6:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").whereField("\(tagArray[1][0])", isEqualTo: "\(tagArray[1][1])").whereField("\(tagArray[2][0])", isEqualTo: "\(tagArray[2][1])").whereField("\(tagArray[3][0])", isEqualTo: "\(tagArray[3][1])").whereField("\(tagArray[4][0])", isEqualTo: "\(tagArray[4][1])").whereField("\(tagArray[5][0])", isEqualTo: "\(tagArray[5][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                    }
                    self.mainTable.reloadData()
                }
            })
        case 7:
            db.collection("courseEvaluation").whereField("\(tagArray[0][0])", isEqualTo: "\(tagArray[0][1])").whereField("\(tagArray[1][0])", isEqualTo: "\(tagArray[1][1])").whereField("\(tagArray[2][0])", isEqualTo: "\(tagArray[2][1])").whereField("\(tagArray[3][0])", isEqualTo: "\(tagArray[3][1])").whereField("\(tagArray[4][0])", isEqualTo: "\(tagArray[4][1])").whereField("\(tagArray[5][0])", isEqualTo: "\(tagArray[5][1])").whereField("\(tagArray[6][0])", isEqualTo: "\(tagArray[6][1])").getDocuments(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                    for document in (snap?.documents)!{
                        let data = document.data()
                        self.evaluationArray.append(Evaluation(className: data["courseName"] as! String, course: data["course"] as! String, year: data["year"] as! String, courseTime: data["courseTime"] as! String, dayOfTheWeek: data["dayOfTheWeek"] as! String, courseEvaluation: data["courseEvaluation"] as! String, different: data["different"] as! String, coursedetail: data["courseDetail"] as! String, postuid: data["postUserID"] as! String))
                    }
                    self.mainTable.reloadData()
                }
            })
            
        default:
            return
        }
        print(evaluationArray)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaluationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = evaluationArray[indexPath.row].className
        return cell
    }
    
}
