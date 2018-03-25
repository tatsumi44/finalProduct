//
//  EventViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/06.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mainTable: UITableView!
    var db: Firestore!
    var eventArray = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        db = Firestore.firestore()
        eventArray = [Event]()
        db.collection("event").getDocuments { (snap, error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                for document in (snap?.documents)!{
                    let data = document.data()
                    self.eventArray.append(Event(postUserID: data["postUser"] as! String, EventID: document.documentID, eventDate: data["eventDate"] as! String, eventTitle: data["eventTitle"] as! String, evetDetail: data["eventDetail"] as! String))
                }
               
                self.mainTable.reloadData()
                
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        print("C")
        
//        cell?.textLabel!.numberOfLines = 0
        let titleLabel = cell?.contentView.viewWithTag(1) as! UILabel
        let dateLabel = cell?.contentView.viewWithTag(2) as! UILabel
        let detailLabel = cell?.contentView.viewWithTag(3) as! UILabel
        let nameLabel = cell?.contentView.viewWithTag(4) as! UILabel
        detailLabel.numberOfLines = 0
        
        
        titleLabel.sizeToFit()
        detailLabel.sizeToFit()
        dateLabel.sizeToFit()
        nameLabel.sizeToFit()
        titleLabel.text = self.eventArray[indexPath.row].eventTitle
        detailLabel.text = self.eventArray[indexPath.row].evetDetail
        dateLabel.text = self.eventArray[indexPath.row].eventDate
        db.collection("users").document(eventArray[indexPath.row].postUserID).getDocument { (snap, error) in
            if let error = error{
                print("\(error)")
            }else{
                let data = snap?.data()
                nameLabel.text = data!["name"] as? String
            }
        }
//        nameLabel.text = "辰巳"
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postEvent(_ sender: Any) {
    }
    
}
