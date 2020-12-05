//
//  SplashView.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 5.11.2020.
//

import SwiftUI
import ActivityIndicatorView

struct SplashView: View {
    
    @ObservedObject var vm: SplashViewModel = SplashViewModel()
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .edgesIgnoringSafeArea(.all)
            Image("ic_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120, alignment: .center)
            
        }
        .fullScreenCover(isPresented: $vm.isPresented, content: {
            if vm.isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
