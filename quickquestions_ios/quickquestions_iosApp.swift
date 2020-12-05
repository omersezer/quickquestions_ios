//
//  quickquestions_iosApp.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 24.10.2020.
//

import SwiftUI
import Firebase

@main
struct quickquestions_iosApp: App {
    
    init() {
        Firebase.FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
