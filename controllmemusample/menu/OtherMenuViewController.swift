//
//  OtherMenuViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/02/23.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase
class OtherMenuViewController: UIViewController,UITableViewDataSource {
    
    
    //異なるStorybordに画面遷移するのでこれを用いる、nameでStorybordの名前を指定
    let storybord: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
    var uid: String!
    var profielArray = [String]()
    var db: Firestore!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        imageView.image = UIImage(named: "IMG_1827.png")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = Auth.auth().currentUser
        uid = user?.uid
        db = Firestore.firestore()
        if user != nil{
            db.collection("users").document(uid).getDocument { (snap, error) in
                let data = snap?.data()
                let name = data!["name"] as? String
                let course = data!["course"] as? String
                let grade = data!["grade"] as? String
                self.profielArray = ["\(name!)さん","\(course!)学部","\(grade!)年生"]
                print(self.profielArray)
                self.mainTableView.reloadData()
            }
        }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController()
            present(nextView!, animated: true, completion: nil)
            print("ログインいるで")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profielArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = profielArray[indexPath.row]
        cell?.textLabel?.adjustsFontSizeToFitWidth = true
        return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //指定したStorybordの一番最初に画面遷移
            let nextView = storybord.instantiateInitialViewController()
            present(nextView!, animated: true, completion: nil)
            print("通っている")
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
}
