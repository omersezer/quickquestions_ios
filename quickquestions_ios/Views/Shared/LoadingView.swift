//
//  LoadingView.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 7.11.2020.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingView: View {
    @State var isLoading: Bool = true
    
    var body: some View {
        ActivityIndicatorView(isVisible: $isLoading, type: .arcs)
            .foregroundColor(.primaryColor)
            .frame(width: 60, height: 60)
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 6)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: false)
    }
}
