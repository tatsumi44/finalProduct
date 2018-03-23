//
//  ClassSarchViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/09.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit


class ClassSarchViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var classANmeTextField: UITextField!
    @IBOutlet weak var yaerTextField: UITextField!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var dayOfTheWeekTextField: UITextField!
    @IBOutlet weak var courseTimeTextField: UITextField!
    @IBOutlet weak var classEvaluationTextField: UITextField!
    @IBOutlet weak var differentTextField: UITextField!
    
    let yearArray = ["2015","2016","2017","2018"]
    let courseArray = ["経済学部","商学部","法学部","社会学部"]
    let dayOfTheWeekArray = ["月曜日","火曜日","水曜日","木曜日","金曜日"]
    let timeSelectArray = ["1限","2限","3限","4限","5限"]
    let evaluationArray = ["★","★★","★★★","★★★★","★★★★★"]
    let differentArray = ["★","★★","★★★","★★★★","★★★★★"]
    var tagArray = [[String]]()
    
    
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
        
        yaerTextField.inputView = pickerView
        courseTextField.inputView = pickerView1
        dayOfTheWeekTextField.inputView = pickerView2
        courseTimeTextField.inputView = pickerView3
        classEvaluationTextField.inputView = pickerView4
        differentTextField.inputView = pickerView5
        classANmeTextField.delegate = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        toolbar.setItems([doneItem], animated: true)
        
        yaerTextField.inputAccessoryView = toolbar
        courseTextField.inputAccessoryView = toolbar
        dayOfTheWeekTextField.inputAccessoryView = toolbar
        courseTimeTextField.inputAccessoryView = toolbar
        classEvaluationTextField.inputAccessoryView = toolbar
        differentTextField.inputAccessoryView = toolbar

        // Do any additional setup after loading the view.
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
            yaerTextField.text = yearArray[row]
        case 2:
            courseTextField.text = courseArray[row]
        case 3:
            dayOfTheWeekTextField.text = dayOfTheWeekArray[row]
        case 4:
            courseTimeTextField.text = timeSelectArray[row]
        case 5:
            classEvaluationTextField.text = evaluationArray[row]
        case 6:
            differentTextField.text = differentArray[row]
        default:
            dayOfTheWeekTextField.text = dayOfTheWeekArray[row]
        }
        
    }
    
    @objc func done() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        tagArray = [[String]]()
        
        if classANmeTextField.text?.isEmpty != true {
            tagArray.append(["courseName",classANmeTextField.text!])
        }else{
            print("授業名は空")
        }
        if yaerTextField.text?.isEmpty != true{
            tagArray.append(["year" , yaerTextField.text!])
        }else{
            print("年度は空")
        }
        if dayOfTheWeekTextField.text?.isEmpty != true{
             tagArray.append(["dayOfTheWeek", dayOfTheWeekTextField.text!])
        }else{
            print("曜日は空")
        }
        if courseTimeTextField.text?.isEmpty != true {
            tagArray.append(["courseTime", courseTimeTextField.text!])
        }else{
            print("時限は空")

        }
        if classEvaluationTextField.text?.isEmpty != true {
             tagArray.append(["courseEvaluation", classEvaluationTextField.text!])
        }else{
            print("クラス評価は空")
            
        }
        if differentTextField.text?.isEmpty != true{
            tagArray.append(["different", differentTextField.text!])
        }else{
            print("難易度はから")
        }
        if courseTextField.text?.isEmpty != true{
            tagArray.append(["course", courseTextField.text!])
        }else{
            print("学部名は空です")
        }
        print(tagArray.count)
        guard tagArray.count == 0 else {
            performSegue(withIdentifier: "nextList", sender: nil)
            return
        }
        print("何か入力してください")
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextList"{
            let searchListContoroller = segue.destination as! SearchListViewController
            searchListContoroller.tagArray = self.tagArray
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
