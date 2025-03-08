//
//  SearchProductsView.swift
//  PLM
//
//  Created by Ricardo Garcia on 07/03/25.
//

import SwiftUI

struct SearchProductsView: View {
    
    @StateObject var viewModelProducts = SearchProductsViewModel()
    @State var productToSearch: String = ""
    @State var listProducts:[ResponseProducts.DrugsResult] = []
    @State var productSearched: String = ""
    @State var loading:Bool = false
    
    @State var showPopupError: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                TextField("Buscar producto", text: $productToSearch)
                    .textFieldStyle(MyCustomTextField())
                    .padding()
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .foregroundStyle(Color.gray)
                }
                .padding()
            }
            
            Button {
                searchProducts()
            } label: {
                Text("Buscar")
            }
            .buttonStyle(MyCustomButton())
            
            if !listProducts.isEmpty {
                Text("Resultados para \"\(productSearched)\"")
                    .padding(.top)
                
                ScrollView {
                    LazyVStack {
                        ForEach(listProducts, id: \.id) { product in
                            VStack() {
                                Text("\(product.Brand ?? "")")
                                    .bold()
                                    .padding(.top)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                Text("\(product.PharmaForm ?? "")")
                                    .padding(.top,5)
                                    .padding(.bottom)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                        }
                    }
                }
                
            }
            
            if loading {
                ProgressView()
                    .padding(.top)
            }
            
            Spacer()
            
        }
        .navigationTitle("Buscador")
        .popup(isPresented: $showPopupError) {
            VStack {
                VStack {
                    Text("Hubo algun error al buscar por favor intenta de nuevo")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                .padding(.horizontal,30)
                
                VStack {
                    Image(systemName: "xmark")
                        .padding()
                }
                .background(.white)
                .clipShape(Circle())
                
            }
        } customize: {
            $0
                .displayMode(.overlay)
                .type(.default)
                .backgroundColor(.black.opacity(0.5))
        }
    }
    
    func searchProducts() {
        if !productToSearch.isEmpty {
            loading = true
            viewModelProducts.searchDrugs(drug: productToSearch) { result in
                switch result {
                case .success(let success):
                    loading = false
                    productSearched = self.productToSearch
                    listProducts = success
                    break
                case .failure(let failure):
                    loading = false
                    showPopupError = true
                    break
                }
            }
        } else {
            showPopupError = true
        }
    }
    
}

#Preview {
    SearchProductsView()
}
