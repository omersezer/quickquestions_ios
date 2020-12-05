//
//  CategoryModel.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 12.11.2020.
//

import SwiftUI

//struct CategoryModel: Codable {
//    var id: String
//    var name: String
//    var questions: [QuestionModel]
//}

class CategoryModel: Identifiable {
    var id: String
    var name: String
    var questions: [QuestionModel]
    var backgroundColor: Color

    init(id: String, name: String, questions: [QuestionModel]) {
        self.id = id
        self.name = name
        self.questions = questions
        self.backgroundColor = Color.random
    }
}
