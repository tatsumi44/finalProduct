//
//  FirstViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/02/23.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage
import NVActivityIndicatorView
import Instructions

class FirstViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CoachMarksControllerDataSource,CoachMarksControllerDelegate  {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    
    var db1: Firestore!
    var db: DatabaseReference!
    var getmainArray = [StorageReference]()
    var getcontents: String!
    var productArray = [Product]()
    var imagePathArray = [String]()
    var cellOfNum: Int!
    var photoCount: Int!
    let sectionID: Int = 1
    var posArray = [CGFloat]()
    let coachMarksController = CoachMarksController()
    let pointOfInterest = UIView()
    let pointOfInterest1 = UIView()
    let pointOfInterest2 = UIView()
    let pointOfInterest3 = UIView()
    let pointOfInterest4 = UIView()
    var firstViewIntroduction: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        posArray = appDelegate.posArray
        self.coachMarksController.dataSource = self
        print(posArray)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil{
            print("ユーザーいるよ")
            
        }else{
            print("戻ろうか")
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController()
            present(nextView!, animated: true, completion: nil)
        }
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.photoCount = appDelegate.photoCount
        print("これは\(self.photoCount)")
        self.mainCollectionView.reloadData()
        productArray = [Product]()
        getmainArray = [StorageReference]()
        imagePathArray = [String]()
        let storage = Storage.storage().reference()
        db1 = Firestore.firestore()
        db1.collection("1").getDocuments { (snap, error) in
            if let error = error{
                print("Error getting documents: \(error)")
            }else{
                for document in snap!.documents {
                    let image1 = document.data()["imagePath"]! as? [String]
                    print(image1![0])
                    print(String(describing: type(of: image1![0])))
                    
                    self.productArray.append(Product(productName: "\(document.data()["productName"] as! String)", productID: "\(document.documentID)", price: "\(document.data()["price"] as! String)", imageArray: image1!, detail: "\(document.data()["detail"] as! String)", uid: "\(document.data()["uid"] as! String)",place: "\(document.data()["place"] as! String)"))
                    
                    self.imagePathArray.append(image1![0])
                    
                }
                print(self.productArray)
                for path in self.imagePathArray{
                    let ref = storage.child("image/goods/\(path)")
                    self.getmainArray.append(ref)
                }
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.productArray = self.productArray
                print("いいね")
                print(self.getmainArray)
                self.mainCollectionView.reloadData()
            }
        }
        //        self.coachMarksController.overlay.color = UIColor.init(red: 243, green: 152, blue: 0, alpha: 0.01)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        db1 = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid{
            db1.collection("users").document(uid).getDocument(completion: { (snap, error) in
                if let error = error{
                    print("\(error)")
                }else{
                  let data = snap?.data()
                    self.firstViewIntroduction = data!["firstViewIntroduction"] as! Bool
                    if self.firstViewIntroduction == false{
                        self.coachMarksController.start(on: self)
                    }
                }
            })
        }
        
        //        self.coachMarksController.overlay.color = UIColor.blue
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let uid = Auth.auth().currentUser?.uid{
            if self.firstViewIntroduction == false{
                self.coachMarksController.stop(immediately: true)
                self.firstViewIntroduction = true
                db1.collection("users").document(uid).updateData(["firstViewIntroduction" : true])
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getmainArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.frame.size.width = mainCollectionView.frame.size.width/2-5.0
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        let nameLabel = cell.contentView.viewWithTag(2) as! UILabel
        let priceLabel = cell.contentView.viewWithTag(3) as! UILabel
        let placeLabel = cell.contentView.viewWithTag(4) as! UILabel
        nameLabel.text = productArray[indexPath.row].productName
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        priceLabel.text = productArray[indexPath.row].price
        placeLabel.text = productArray[indexPath.row].place
        //getmainArrayにあるpathをurl型に変換しimageViewに描画
        getmainArray[indexPath.row].downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print("\(error)")
            } else {
                print(url!)
                //imageViewに描画、SDWebImageライブラリを使用して描画
                imageView.sd_setImage(with: url!, completed: nil)
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize1:CGFloat = mainCollectionView.frame.size.width/2-5.0
        let cellSize2: CGFloat = mainCollectionView.frame.size.height/2
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize1, height: cellSize2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        cellOfNum = indexPath.row
        appDelegate.cellOfNum = self.cellOfNum
        appDelegate.sectionID = self.sectionID
    }
    
    //Instructionsライブラリを使うために必須
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        let coachViews1 = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        let coachViews2 = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        let coachViews3 = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        let coachViews4 = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        coachViews.bodyView.hintLabel.text = "この画面では商品の取引や投稿を行うよ"
        coachViews.bodyView.nextLabel.text = "OK"
        coachViews1.bodyView.hintLabel.text = "この画面では取引相手とのチャットや自分の投稿を管理することができるよ"
        coachViews1.bodyView.nextLabel.text = "OK"
        coachViews2.bodyView.hintLabel.text = "この画面ではイベントの投稿をすることができるよ"
        coachViews2.bodyView.nextLabel.text = "OK"
        coachViews3.bodyView.hintLabel.text = "この画面では授業の評価を見たり、投稿することができるよ"
        coachViews3.bodyView.nextLabel.text = "OK"
        coachViews4.bodyView.hintLabel.text = "このボタンを押すと自分の持っているノート、過去問、レジュメを投稿することができるよ"
        coachViews4.bodyView.nextLabel.text = "OK"
        let coachViewArray = [coachViews,coachViews1,coachViews2,coachViews3,coachViews4]
        
        //        coachViews.bodyView.backgroundColor = UIColor.orange
        return (bodyView: coachViewArray[index].bodyView, arrowView: coachViewArray[index].arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        pointOfInterest.frame = CGRect(x: 0, y: posArray[1], width: posArray[2]/5, height: posArray[3])
        pointOfInterest1.frame = CGRect(x: posArray[2]/5, y: posArray[1], width: posArray[2]/5, height: posArray[3])
        pointOfInterest2.frame = CGRect(x: posArray[2]/5 * 2, y: posArray[1], width: posArray[2]/5, height: posArray[3])
        pointOfInterest3.frame = CGRect(x: posArray[2]/5 * 3, y: posArray[1], width: posArray[2]/5, height: posArray[3])
        
            pointOfInterest4.frame = CGRect(x: 300, y:0, width: 70, height: 60)
        
        
        
        let pointOfInterestArray = [pointOfInterest,pointOfInterest1,pointOfInterest2,pointOfInterest3,pointOfInterest4]
        //        pointOfInterest.backgroundColor = UIColor.orange
        return coachMarksController.helper.makeCoachMark(for: pointOfInterestArray[index])
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 5
    }
    
    
}
