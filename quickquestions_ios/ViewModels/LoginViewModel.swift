//
//  LoginViewModel.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 1.11.2020.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var isSignIn: Bool = true
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var rePasswordText: String = ""
    @Published var isPresented: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    init() {
        #if DEBUG
        emailText = "oomersezer@gmail.com"
        passwordText = "omer1234"
        #endif
    }
    
    public func onChangeContent(isSignIn: Bool) {
        self.isSignIn = isSignIn
    }
    
    public func signUp() {
        if emailText.count > 0 && passwordText.count > 0 {
            if isSignIn {
                setLoading(isLoading: true)
                Auth.auth().signIn(withEmail: emailText, password: passwordText) { (authResult, error) in
                    if error == nil {
                        self.setLoading(isLoading: false)
                        self.isPresented = true
                    } else {
                        self.setLoading(isLoading: false)
                        self.showAlert(message: error?.localizedDescription ?? "Biinmeyen bir hata oluştu")
                    }
                }
            } else {
                if passwordText == rePasswordText {
                    setLoading(isLoading: true)
                    Auth.auth().createUser(withEmail: emailText, password: passwordText) { (authResult, error) in
                        if error == nil {
                            self.isPresented = true
                        } else {
                            self.setLoading(isLoading: false)
                            self.showAlert(message: error?.localizedDescription ?? "Biinmeyen bir hata oluştu")
                        }
                    }
                } else {
                    self.setLoading(isLoading: false)
                    self.showAlert(message: "Lütfen girdiğiniz şifrelerin eşleştiğinden emin olunuz.")
                }
            }
        } else {
            showAlert(message: "Lütfen tüm alanları doldurduğunuzdan emin olunuz")
        }
    }
    
    func showAlert(message: String) {
        isShowingAlert = true
        alertMessage = message
    }
    
    func setLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
}
