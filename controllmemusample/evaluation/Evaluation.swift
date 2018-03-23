//
//  Evaluation.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/03/08.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit

class Evaluation {
    var className: String!
    var course: String!
    var year: String!
    var courseTime: String!
    var dayOfTheWeek: String!
    var courseEvaluation: String!
    var different: String!
    var coursedetail: String!
    var postuid: String!
    
    init(className: String,course: String,year: String,courseTime: String,dayOfTheWeek: String,courseEvaluation: String,different: String,coursedetail: String,postuid: String) {
        
        self.className = className
        self.course = course
        self.year = year
        self.courseTime = courseTime
        self.dayOfTheWeek = dayOfTheWeek
        self.courseEvaluation = courseEvaluation
        self.different = different
        self.coursedetail = coursedetail
        self.postuid = postuid
        
    }
    
    
}
