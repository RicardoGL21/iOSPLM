//
//  DeveloperView.swift
//  PLM
//
//  Created by Ricardo Garcia on 07/03/25.
//

import SwiftUI

struct DeveloperView: View {
    var body: some View {
        VStack(spacing:0) {
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 100)
                .offset(x: 0, y: 45)
            
            VStack {
                Text("Ricardo Garcia Lopez")
                    .frame(maxWidth: .infinity)
                    .padding(.top,30)
                    .font(.largeTitle)
                Text("Correo: ricardogarcia.lopez@hotmail.com")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                Text("Número: 5566837465")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                Text("Edad: 24 años")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                Text("Estado: EDOMEX")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .padding(.bottom,30)
            }
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .padding()
            
            Spacer()
        }
        .navigationTitle("Desarrollador")
    }
}

#Preview {
    DeveloperView()
}
