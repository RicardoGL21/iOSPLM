//
//  Buttons.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import SwiftUI

struct MyCustomButton: ButtonStyle {
    var isEnabled: Bool?
    var colorButton: Color?
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(10)
                .background(isEnabled ?? true ? colorButton != nil ? colorButton! : Color.blue : Color.gray)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.1 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
