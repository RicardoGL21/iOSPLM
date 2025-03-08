//
//  MainUserView.swift
//  PLM
//
//  Created by Ricardo Garcia on 07/03/25.
//

import SwiftUI

struct MainUserView: View {
    
    @State var showMenu = false
    @State var sectionSelected: Int = 1

        var body: some View {
            ZStack(alignment: .leading) {
                NavigationView {
                    VStack {
                        switch sectionSelected {
                        case 1:
                            SearchProductsView()
                        case 2:
                            DeveloperView()
                        default:
                            EmptyView()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title)
                            }
                        }
                    }
                }

                if showMenu {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                showMenu = false
                            }
                        }

                    SideMenuView(sectionSelected: $sectionSelected, showMenu: $showMenu)
                        .frame(width: 250)
                        .offset(x: showMenu ? 0 : -250)
                        .transition(.move(edge: .leading))
                }
            }
        }
}

#Preview {
    MainUserView()
}

struct SideMenuView: View {
    
    @Binding var sectionSelected: Int
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Menú")
                .font(.title)
                .bold()
                .padding(.top, 50)

            Button("Buscador") {
                sectionSelected = 1
                showMenu = false
            }
            Button("Desarrollador") {
                sectionSelected = 2
                showMenu = false
            }

            Spacer()
        }
        .frame(maxWidth: 250, maxHeight: .infinity)
        .background()
        .offset(x: 0)
        .edgesIgnoringSafeArea(.all)
    }
}
