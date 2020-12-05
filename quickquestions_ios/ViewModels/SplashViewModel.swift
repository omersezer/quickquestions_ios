//
//  SplashViewModel.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 5.11.2020.
//

import SwiftUI
import FirebaseAuth

class SplashViewModel: ObservableObject {
    
    @Published var isPresented: Bool = false
    @Published var isLoggedIn: Bool = false
    
    init() {
        checkAuth()
    }
    
    public func checkAuth() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
        self.isPresented = true
    }
}
