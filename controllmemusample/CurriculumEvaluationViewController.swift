//
//  CurriculumEvaluationViewController.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/08.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit

class CurriculumEvaluationViewController: UIViewController,UITableViewDataSource {
   
    
    
    @IBOutlet weak var mainTable: UITableView!
    
    @IBOutlet weak var postButtonItem: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        postButtonItem.tintColor = UIColor.orange
        mainTable.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "テスト"
        return cell
    }
    
    
    @IBAction func postButton(_ sender: UIBarButtonItem) {
    }
    


}
