//
//  Color.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 1.11.2020.
//

import SwiftUI

extension Color {
    
    static let primaryColor = Color("color_primary")
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
