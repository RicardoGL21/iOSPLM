//
//  ContentView.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var userCreated:Bool? = nil
    
    var body: some View {
        VStack {
            if let userCreated = userCreated {
                if userCreated {
                    MainUserView()
                } else {
                    SignUpView(userCreated: $userCreated)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            valdiateUserCreated()
        }
    }
    
    func valdiateUserCreated(){
        let user = UserDefaults.standard.string(forKey: "keyUser")
        if user != nil {
            print(user!)
            userCreated = true
        } else {
            userCreated = false
        }
    }
    
}

#Preview {
    ContentView()
}
