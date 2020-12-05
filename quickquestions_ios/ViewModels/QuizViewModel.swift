//
//  QuizViewModel.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 21.11.2020.
//

import FirebaseAuth
import FirebaseDatabase
import SwiftUI

final class QuizViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    var category: CategoryModel
    var selectedIndex: Int?
    var score: Int = 0
    var isCompleted: Bool = false
    
    @Published var appearedQuestions : QuestionModel?
    @Published var colorOption1: Color = Color.gray
    @Published var colorOption2: Color = Color.gray
    @Published var colorOption3: Color = Color.gray
    @Published var colorOption4: Color = Color.gray
    @Published var isAlertPresented: Bool = false
    @Published var isResultAlertPresented = false
    @Published var alertMessage: String = ""
    @Published var alertTitle: String = ""
    
    init(category: CategoryModel) {
        self.category = category
        updateQuestion()
    }
    
    func onSubmitClicked() {
        if selectedIndex != nil {
            calculatePoints()
            resetQuestion()
            updateQuestion()
        } else {
            showAlert(title: "Uyarı", message: "Lütfen bir seçim yapınız.")
        }
    }
    
    func updateQuestion() {
        if !isCompleted {
            if let question = appearedQuestions {
                let index = category.questions.firstIndex(where: {$0.id == question.id})
                if (index ?? 0) + 1 == category.questions.count {
                    isCompleted = true
                    updateScore()
                    showAlert(title: "Tebrikler", message: "\(score) puana ulaştınız.", isResultAlert: true)
                } else {
                    appearedQuestions = category.questions[(index ?? -1) + 1]
                }
            } else {
                appearedQuestions = category.questions[0]
            }
        }
    }
    
    func calculatePoints() {
        switch selectedIndex {
        case 0:
            if appearedQuestions?.answer == appearedQuestions?.option_1 {
              score += 20
            }
        case 1:
            if appearedQuestions?.answer == appearedQuestions?.option_2 {
              score += 20
            }
        case 2:
            if appearedQuestions?.answer == appearedQuestions?.option_3 {
              score += 20
            }
        case 3:
            if appearedQuestions?.answer == appearedQuestions?.option_4 {
              score += 20
            }
        default:
            break
        }
    }
    
    func resetQuestion() {
        selectedIndex = nil
        setDefaultOptionColor()
    }
    
    func onOptionClicked(index: Int) {
        switch index {
        case 0:
            selectedIndex = 0
            setColor(index: 0)
        case 1:
            selectedIndex = 1
            setColor(index: 1)
        case 2:
            selectedIndex = 2
            setColor(index: 2)
        case 3:
            selectedIndex = 3
            setColor(index: 3)
        default:
            break
        }
    }
    
    func setColor(index: Int) {
        setDefaultOptionColor()
        switch index {
        case 0:
            colorOption1 = Color.primaryColor
        case 1:
            colorOption2 = Color.primaryColor
        case 2:
            colorOption3 = Color.primaryColor
        case 3:
            colorOption4 = Color.primaryColor
        default:
            break
        }
    }
    
    func setDefaultOptionColor() {
        colorOption1 = Color.gray
        colorOption2 = Color.gray
        colorOption3 = Color.gray
        colorOption4 = Color.gray
    }
    
    func showAlert(title: String, message: String, isResultAlert: Bool = false) {
        if isResultAlert {
            isResultAlertPresented = true
        } 
        isAlertPresented = true
        alertTitle = title
        alertMessage = message
    }
    
    func hideAlert() {
        isAlertPresented = false
        isResultAlertPresented = false
        alertTitle = ""
        alertMessage = ""
    }
    
    func updateScore() {
        ref = Database.database().reference(withPath: "user")
        if let currentUser = Auth.auth().currentUser {
            ref.child(currentUser.uid).setValue(["email": currentUser.email,
                                                       "score": score])
        }
    }
}
