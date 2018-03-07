//
//  OtherMenuViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/02/23.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase
class OtherMenuViewController: UIViewController,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = Auth.auth().currentUser
        uid = user?.uid
        db = Firestore.firestore()
        let ref = Storage.storage().reference()
        //db接続
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
        db.collection("users").document(uid).getDocument { (snap, error) in
            if let error = error{
                print("error")
            }else{
                let data = snap?.data()
                
                if let profilePath = data!["profilePath"]{
                    ref.child("image").child("profile").child(profilePath as! String).downloadURL { url, error in
                        if let error = error {
                            // Handle any errors
                        } else {
                            //imageViewに描画、SDWebImageライブラリを使用して描画
                            self.imageView.sd_setImage(with: url!, completed: nil)
                        }
                    }
                }else{
                    print("nil")
                }
               
            }
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
    
    
    @IBAction func choiceLibraly(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
    
        let date = NSDate()
        //時間を文字列に整形
        let format = DateFormatter()
        format.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        //整形した文字列を画像のpathに整形
        let datePath = format.string(from: date as Date)
        
        db.collection("users").document(uid).updateData(["profilePath" : "\(datePath)_\(uid!).jpg"]) { (error) in
            if let error = error{
                print("error")
                
            }else{
                let data: Data = UIImageJPEGRepresentation(image!, 0.1)!
                //ストレージの保存先のpathを指定
                let ref = Storage.storage().reference()
                let imagePath = ref.child("image").child("profile").child("\(datePath)_\(self.uid!).jpg")
                let uploadTask = imagePath.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata.downloadURL
                    print(downloadURL)
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
