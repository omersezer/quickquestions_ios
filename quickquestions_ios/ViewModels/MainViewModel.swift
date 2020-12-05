//
//  MainViewModel.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 8.11.2020.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

final class MainViewModel: ObservableObject {
    
    @Published var isPresentedLoginView: Bool = false
    @Published var isPresentedQuizView: Bool = false
    @Published var isAlertPresented: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var categories: [CategoryModel] = [CategoryModel]()
    @Published var myScore: Int = 0
    @Published var selectedCategory: Int = 0
    
    var ref: DatabaseReference!
    var users: [UserModel] = []
    
    init() {
        ref = Database.database().reference(withPath: "category")
        getQuestions()
    }
    
    func getQuestions() {
        ref = Database.database().reference(withPath: "category")
        setLoading(isLoading: true)
        ref.observe(.value) { (snapShot) in
            self.setLoading(isLoading: false)
            if snapShot.childrenCount > 0 {
                self.categories.removeAll()
                
                for category in snapShot.children.allObjects as! [DataSnapshot] {
                    if let categoryObject = category.value as? [String:Any] {
                        let id = categoryObject["id"] as? String
                        let name = categoryObject["name"] as? String
                        var questionsModel: [QuestionModel] = []
                        if let questions = categoryObject["questions"] as? [[String: Any]] {
                            for questionObject in questions {
                                let questionId = questionObject["id"] as? String
                                let questionQuestion = questionObject["question"] as? String
                                let answer = questionObject["answer"] as? String
                                let option_1 = questionObject["option_1"] as? String
                                let option_2 = questionObject["option_2"] as? String
                                let option_3 = questionObject["option_3"] as? String
                                let option_4 = questionObject["option_4"] as? String
                                questionsModel.append(QuestionModel(answer: answer ?? "", id: questionId ?? "", question: questionQuestion ?? "", option_1: option_1 ?? "", option_2: option_2 ?? "", option_3: option_3 ?? "", option_4: option_4 ?? ""))
                            }
                        }
                        self.categories.append(CategoryModel(id: id ?? "", name: name ?? "", questions: questionsModel))
                    }
                }
            }
        }
        
        getUsers()
    }
    
    func checkPoint() {
        if let takenScore = users.first(where: { $0.email == FirebaseAuth.Auth.auth().currentUser?.email}) {
            myScore = takenScore.score ?? 0
        }
    }
    
    func getUsers() {
        setLoading(isLoading: true)
        ref = Database.database().reference(withPath: "user")
        ref.observe(.value) { (snapShot) in
            self.setLoading(isLoading: false)
            if snapShot.childrenCount > 0 {
                self.users.removeAll()
                
                for user in snapShot.children.allObjects as! [DataSnapshot] {
                    if let userObject = user.value as? [String: Any] {
                        let email = userObject["email"] as? String
                        let score = userObject["score"] as? Int
                        self.users.append(UserModel(email: email, score: score))
                    }
                }
            }
            self.checkPoint()
        }
    }
    
    func onSignOutButtonClicked() {
        showAlert(message: "Çıkış yapmak istediğinize emin misiniz?")
    }
    
    func onStartButtonClicked(categoryIndex: Int) {
        selectedCategory = categoryIndex
        isPresentedQuizView = true
    }
    
    func signOut() {
        do {
            try? Auth.auth().signOut()
            isPresentedLoginView = true
        } catch {
            // todo : handle error message
            print(error)
        }
    }
    
    func showAlert(message: String) {
        isAlertPresented = true
        alertMessage = message
    }
    
    func dismissAlert() {
        isAlertPresented = false
        alertMessage = ""
    }
    
    func setLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
}
