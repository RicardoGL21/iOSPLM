//
//  SignUpView.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import SwiftUI
import PopupView

struct SignUpView: View {
    
    @Binding var userCreated:Bool?
    
    @StateObject private var viewModelSignUp = SignUpViewModel()
    
    @State var name:String = ""
    @State var surname1:String = ""
    @State var surname2:String = ""
    @State var email:String = ""
    @State var profession:String = ""
    @State var codeProfession:String = ""
    @State var country:String = ""
    @State var state:String = ""
    @State var phone:String = ""
    
    @State var listProfessions:[ResponseGetProfessions.ProfessionResult] = []
    @State var listCountries:[ResponseGetCountries.CountriesResult] = []
    @State var listStates:[ResponseGetStates.StateByCountry] = []
    
    @State var countrySelected:ResponseGetCountries.CountriesResult? = nil
    @State var stateSelected:ResponseGetStates.StateByCountry? = nil
    @State var professionSelected:ResponseGetProfessions.ProfessionResult? = nil
    
    @State var showPopupError: Bool = false
    @State var isValidEmail: Bool = true
    @State var loading: Bool = false
    
    var userDefaults = UserDefaults.standard
    
    var body: some View {
        NavigationStack {
            
            if loading {
                ProgressView()
            } else {
                
                ScrollView {
                    
                    VStack {
                        
                        Text("Registro")
                            .font(.title)
                        
                        HStack {
                            Text("Nombre:")
                                .frame(width: 100)
                            TextField(text: $name) {
                                Text("Nombre")
                            }
                            .textFieldStyle(MyCustomTextField())
                            .onChange(of: name) { oldValue, newValue in
                                name = newValue.filter { $0.isLetter || $0.isWhitespace }
                            }
                        }
                        HStack {
                            Text("A. Paterno:")
                                .frame(width: 100)
                            TextField(text: $surname1) {
                                Text("Apellido Paterno")
                            }
                            .textFieldStyle(MyCustomTextField())
                        }
                        .onChange(of: surname1) { oldValue, newValue in
                            surname1 = newValue.filter { $0.isLetter || $0.isWhitespace }
                        }
                        HStack {
                            Text("A. Materno:")
                                .frame(width: 100)
                            TextField(text: $surname2) {
                                Text("Apellido Materno")
                            }
                            .textFieldStyle(MyCustomTextField())
                        }
                        .onChange(of: surname2) { oldValue, newValue in
                            surname2 = newValue.filter { $0.isLetter || $0.isWhitespace }
                        }
                        HStack {
                            Text("Email:")
                                .frame(width: 100)
                            TextField(text: $email) {
                                Text("Email")
                            }
                            .textFieldStyle(MyCustomTextField())
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .onChange(of: email) { oldValue, newValue in
                                isValidEmail = isValidEmailFormat(newValue)
                            }
                        }
                        HStack {
                            Text("Profesión:")
                                .frame(width: 100)
                            ZStack {
                                TextField(text: $profession) {
                                    Text("Profesión")
                                }
                                .textFieldStyle(MyCustomTextField())
                                .disabled(true)
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .padding(.trailing)
                                }
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                Menu {
                                    ForEach(listProfessions, id: \.ProfessionId) { profession in
                                        Button {
                                            self.profession = profession.EnglishName ?? ""
                                            professionSelected = profession
                                        } label: {
                                            Text("\(profession.EnglishName ?? "")")
                                        }
                                    }
                                } label: {
                                    Text("")
                                        .frame(maxWidth: .infinity)
                                        .frame(height:45)
                                }
                                .id(UUID())
                                
                            }
                        }
                        HStack {
                            Text("Ced. Prof.:")
                                .frame(width: 100)
                            TextField(text: $codeProfession) {
                                Text("Cedula Profesional")
                            }
                            .textFieldStyle(MyCustomTextField())
                            .onChange(of: codeProfession) { oldValue, newValue in
                                codeProfession = newValue.filter { $0.isNumber || $0.isLetter }
                                if codeProfession.count > 10 {
                                    codeProfession = String(codeProfession.prefix(10))
                                }
                            }
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        }
                        HStack {
                            Text("País:")
                                .frame(width: 100)
                            ZStack {
                                TextField(text: $country) {
                                    Text("País")
                                }
                                .textFieldStyle(MyCustomTextField())
                                .disabled(true)
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .padding(.trailing)
                                }
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                Menu {
                                    ForEach(listCountries, id: \.CountryId) { country in
                                        Button {
                                            self.state = ""
                                            countrySelected = country
                                            self.country = country.CountryName ?? ""
                                            getStates(idCountry: "\(country.CountryId ?? 1)")
                                        } label: {
                                            Text("\(country.CountryName ?? "")")
                                        }
                                    }
                                } label: {
                                    Text("")
                                        .frame(maxWidth: .infinity)
                                        .frame(height:45)
                                }
                                .id(UUID())
                            }
                        }
                        HStack {
                            Text("Estado:")
                                .frame(width: 100)
                            ZStack {
                                TextField(text: $state) {
                                    Text("Estado")
                                }
                                .textFieldStyle(MyCustomTextField())
                                .disabled(true)
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .padding(.trailing)
                                }
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                Menu {
                                    ForEach(listStates, id: \.StateId) { state in
                                        Button {
                                            self.state = state.StateName ?? ""
                                            stateSelected = state
                                        } label: {
                                            Text("\(state.StateName ?? "")")
                                        }
                                    }
                                } label: {
                                    Text("")
                                        .frame(maxWidth: .infinity)
                                        .frame(height:45)
                                }
                                .id(UUID())
                            }
                        }
                        HStack {
                            Text("Teléfono:")
                                .frame(width: 100)
                            TextField(text: $phone) {
                                Text("Teléfono")
                            }
                            .textFieldStyle(MyCustomTextField())
                            .onChange(of: phone) { oldValue, newValue in
                                phone = newValue.filter { $0.isNumber }
                                if phone.count > 10 {
                                    phone = String(phone.prefix(10))
                                }
                            }
                        }
                        
                        Button {
                            validateFields()
                        } label: {
                            Text("Registrar")
                        }
                        .buttonStyle(MyCustomButton())
                        .padding()
                        
                        
                    }
                    .padding()
                }
                .onAppear {
                    getProfessions()
                    getCountries()
                }
                .popup(isPresented: $showPopupError) {
                    VStack {
                        VStack {
                            Text("Hubo algun error al registrarte por favor intenta de nuevo")
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
        }
    }
    
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validateFields() {
        if name.isEmpty {
            showPopupError = true
            return
        } else if surname1.isEmpty {
            showPopupError = true
            return
        } else if surname2.isEmpty {
            showPopupError = true
            return
        } else if email.isEmpty {
            showPopupError = true
            return
        } else if !isValidEmail {
            showPopupError = true
            return
        } else if profession.isEmpty {
            showPopupError = true
            return
        } else if codeProfession.isEmpty {
            showPopupError = true
            return
        } else if country.isEmpty {
            showPopupError = true
            return
        } else if state.isEmpty {
            showPopupError = true
            return
        } else if phone.isEmpty {
            showPopupError = true
            return
        } else if phone.count < 10 {
            showPopupError = true
            return
        } else {
            createUser()
        }
    }
    
    func createUser() {
        loading = true
        let request = RequestCreateUser(codePrefix: "TESTPLM", country: countrySelected?.ID ?? "", email: email, firstName: name, lastName: surname1, phone: phone, profession: professionSelected?.ProfessionId ?? 0, professionLicense: codeProfession, slastName: surname2, source: 27, state: stateSelected?.ShortName ?? (countrySelected?.CountryName ?? ""), targetOutput: 5)
        print(request)
        viewModelSignUp.createAccount(request: request) { result in
            switch result {
            case .success(let keyUser):
                loading = false
                userDefaults.setValue(keyUser, forKey: "keyUser")
                userDefaults.synchronize()
                userCreated = true
                break
            case .failure(let failure):
                loading = false
                showPopupError = true
                break
            }
        }
    }
    
    func getProfessions() {
        viewModelSignUp.getProfession { result in
            switch result {
            case .success(let professions):
                var filteredProfessions: [ResponseGetProfessions.ProfessionResult] = []
                for profes in professions {
                    if let professionFilterId = profes.ProfessionId, professionFilterId > 0, let professionName = profes.EnglishName, !professionName.isEmpty {
                        filteredProfessions.append(profes)
                    }
                }
                listProfessions = filteredProfessions
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getCountries() {
        viewModelSignUp.getCountries { result in
            switch result {
            case .success(let countries):
                var filteredCountries: [ResponseGetCountries.CountriesResult] = []
                for country in countries {
                    if let countryFilterId = country.CountryId, countryFilterId > 0, let countryName = country.CountryName, !countryName.isEmpty {
                        filteredCountries.append(country)
                    }
                }
                
                listCountries = filteredCountries
                
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getStates(idCountry:String) {
        viewModelSignUp.getStates(idCountry: idCountry) { result in
            switch result {
            case .success(let success):
                var filteredStates: [ResponseGetStates.StateByCountry] = []
                for state in success {
                    if let stateID = state.CountryId, stateID > 0, let stateName = state.StateName, !stateName.isEmpty {
                        filteredStates.append(state)
                    }
                }
                
                listStates = filteredStates
                
                if filteredStates.isEmpty {
                    self.state = self.country
                }
                
                break
            case .failure(let error):
                break
            }
        }
    }
    
}

#Preview {
    
    @State var userCreated: Bool? = nil
    
    SignUpView(userCreated: $userCreated)
}
