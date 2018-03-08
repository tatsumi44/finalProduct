//
//  PostEvaluationViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/08.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit

class PostEvaluationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var yearSelectTextField: UITextField!
    @IBOutlet weak var courseSelectTextField: UITextField!
    @IBOutlet weak var dayOfTheWeekTextField: UITextField!
    @IBOutlet weak var courseTimeSelectTextField: UITextField!
    @IBOutlet weak var courseEvaluationTextField: UITextField!
    @IBOutlet weak var difflenceTextField: UITextField!
    @IBOutlet weak var courseDetailTextField: UITextView!
    
    let yearArray = ["2018","2017","2016","2015"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        pickerView.delegate = self as? UIPickerViewDelegate
        yearSelectTextField.inputView = pickerView

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
        return yearArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearSelectTextField.text = yearArray[row]
    }
   
    
    
    @IBAction func postButton(_ sender: UIButton) {
    }
    


}
