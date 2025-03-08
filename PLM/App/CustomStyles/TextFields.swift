//
//  TextFields.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import SwiftUI

struct MyCustomTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.black)
    }
}
