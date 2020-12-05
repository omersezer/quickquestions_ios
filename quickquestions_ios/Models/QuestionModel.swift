//
//  QuestionModel.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 12.11.2020.
//

import Foundation

struct QuestionModel: Identifiable {
    var answer: String
    var id: String
    var question: String
    var option_1: String
    var option_2: String
    var option_3: String
    var option_4: String
    
    init(answer: String,
         id: String,
         question: String,
         option_1: String,
         option_2: String,
         option_3: String,
         option_4: String) {
        self.answer = answer
        self.id = id
        self.question = question
        self.option_1 = option_1
        self.option_2 = option_2
        self.option_3 = option_3
        self.option_4 = option_4
    }
}
