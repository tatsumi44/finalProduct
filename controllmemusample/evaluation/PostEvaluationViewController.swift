//
//  PostEvaluationViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/08.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase

class PostEvaluationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate {
    
    var db: Firestore!
    
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var yearSelectTextField: UITextField!
    @IBOutlet weak var courseSelectTextField: UITextField!
    @IBOutlet weak var dayOfTheWeekTextField: UITextField!
    @IBOutlet weak var courseTimeSelectTextField: UITextField!
    @IBOutlet weak var courseEvaluationTextField: UITextField!
    @IBOutlet weak var difflenceTextField: UITextField!
    @IBOutlet weak var courseDetailTextField: UITextView!
    
    let yearArray = ["2015","2016","2017","2018"]
    let courseArray = ["経済学部","商学部","法学部","社会学部"]
    let dayOfTheWeekArray = ["月曜日","火曜日","水曜日","木曜日","金曜日"]
    let timeSelectArray = ["1限","2限","3限","4限","5限"]
    let evaluationArray = ["★","★★","★★★","★★★★","★★★★★"]
    let differentArray = ["★","★★","★★★","★★★★","★★★★★"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        let pickerView1 = UIPickerView()
        let pickerView2 = UIPickerView()
        let pickerView3 = UIPickerView()
        let pickerView4 = UIPickerView()
        let pickerView5 = UIPickerView()
        pickerView.tag = 1
        pickerView1.tag = 2
        pickerView2.tag = 3
        pickerView3.tag = 4
        pickerView4.tag = 5
        pickerView5.tag = 6
        pickerView.dataSource = self
        pickerView1 .dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        pickerView4.dataSource = self
        pickerView5.dataSource = self
        pickerView.delegate = self
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView4.delegate = self
        pickerView5.delegate = self
        yearSelectTextField.inputView = pickerView
        courseSelectTextField.inputView = pickerView1
        dayOfTheWeekTextField.inputView = pickerView2
        courseTimeSelectTextField.inputView = pickerView3
        courseEvaluationTextField.inputView = pickerView4
        difflenceTextField.inputView = pickerView5
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
       
        toolbar.setItems([doneItem], animated: true)
        yearSelectTextField.inputAccessoryView = toolbar
        courseSelectTextField.inputAccessoryView = toolbar
        dayOfTheWeekTextField.inputAccessoryView = toolbar
        courseTimeSelectTextField.inputAccessoryView = toolbar
        courseEvaluationTextField.inputAccessoryView = toolbar
        difflenceTextField.inputAccessoryView = toolbar
        courseDetailTextField.inputAccessoryView = toolbar
        
        classNameTextField.layer.borderColor = UIColor.black.cgColor
        classNameTextField.layer.borderWidth = 0.3
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
           return Int(yearArray.count)
        case 2:
           return Int(courseArray.count)
        case 3:
           return Int(dayOfTheWeekArray.count)
        case 4:
            return Int(timeSelectArray.count)
        case 5:
            return Int(evaluationArray.count)
        case 6:
            return Int(differentArray.count)
        default:
            return 0
        }
        
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return yearArray[row]
        case 2:
            return courseArray[row]
        case 3:
            return dayOfTheWeekArray[row]
        case 4:
            return timeSelectArray[row]
        case 5:
            return evaluationArray[row]
        case 6:
            return differentArray[row]
        default:
            return dayOfTheWeekArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 1:
            yearSelectTextField.text = yearArray[row]
        case 2:
            courseSelectTextField.text = courseArray[row]
        case 3:
            dayOfTheWeekTextField.text = dayOfTheWeekArray[row]
        case 4:
            courseTimeSelectTextField.text = timeSelectArray[row]
        case 5:
            courseEvaluationTextField.text = evaluationArray[row]
        case 6:
            difflenceTextField.text = differentArray[row]
        default:
            dayOfTheWeekTextField.text = dayOfTheWeekArray[row]
        }
        
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
   
    @IBAction func postButton(_ sender: UIButton) {
        db = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid{
            guard classNameTextField.text != "" else{
                print("クラスの名前を入力してください")
                return
            }
            
            guard yearSelectTextField.text != "" else{
                print("年度を打ち込んで")
                return
            }
            guard courseSelectTextField.text != "" else {
                print("コースを打ち込んで")
                return
            }
            guard  dayOfTheWeekTextField.text != "" else {
                print("曜日を打ち込んで")
                return
            }
            guard courseTimeSelectTextField.text != "" else {
                print("時限を打ち込んで")
                return
            }
            guard courseEvaluationTextField.text != "" else {
                print("評価を打ち込んで")
                return
            }
            guard difflenceTextField.text != "" else {
                print("難易度を打ち込んで")
                return
            }
            guard courseDetailTextField.text != "" else {
                print("詳細を打ち込んで")
                return
            }
            
            db.collection("courseEvaluation").addDocument(data: [
                
                "courseName": classNameTextField.text!,
                "year" : yearSelectTextField.text! ,
                "course": courseSelectTextField.text!,
                "dayOfTheWeek": dayOfTheWeekTextField.text!,
                "courseTime": courseTimeSelectTextField.text!,
                "courseEvaluation": courseEvaluationTextField.text!,
                "different": difflenceTextField.text!,
                "courseDetail": courseDetailTextField.text!,
                "postUserID": uid
                
                ])
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
