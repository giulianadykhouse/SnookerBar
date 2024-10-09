//
//  MainView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    private let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 250))
    ]
    var selection = ["booking", "menu", "news", "rules", "qr", "settings"]
    @State var isAlerted = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackImageView(image: "bg1")
                    .scaleEffect(1.2)
                    .blur(radius: 15)
                
                VStack {
                    HStack {
                        Image("logo2")
                            .resizable()
                            .frame(width: 170, height: 170)
                    }
                    .padding(.trailing)
                    .padding(.top, 50)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(selection, id:\.self) { type in
                                NavigationLink {
                                    switch type {
                                    case "booking": BookingView().navigationBarBackButtonHidden().environmentObject(authViewModel)
                                    case "menu": MenuView().navigationBarBackButtonHidden()
                                    case "news": BarNewsView().navigationBarBackButtonHidden()
                                    case "rules": RulesView().navigationBarBackButtonHidden()
                                    case "qr": 
                                        QRView().navigationBarBackButtonHidden().environmentObject(authViewModel)
                                    case "settings": SettingsView()
                                            .environmentObject(authViewModel)
                                            .navigationBarBackButtonHidden()
                                    default: BookingView().navigationBarBackButtonHidden().environmentObject(authViewModel)
                                    }
                                } label: {
                                    ZStack {
                                        Image((type == "booking" || type == "rules" || type == "qr") ? "button1" : "button2")
                                            .resizable()
                                            .frame(width: 180, height: 170)
                                            .cornerRadius(12)
                                        
                                        Image(type)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .colorInvert()
                                      
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .alert("To participate in the loyalty system you must be registered. Do you want to register now?", isPresented: $isAlerted) {
            Button {
                authViewModel.signOut()
            } label: {
                Text("Yes")
            }
            
            Button {
                
            } label: {
                Text("No")
            }
        }
        .onAppear {
            if !UserDefaults.standard.bool(forKey: "init") {
                UserDefaults.standard.setValue(true, forKey: "init")
                UserDefaults.standard.setValue(generateCode(), forKey: "code")
            }
        }
        .tint(.white)
    }
    
    
    func generateCode() -> String {
        var numbers = ""
        for _ in 0..<4 {
            let number = Int.random(in: 0...99)
            numbers += String(format: "%02d", number) + " "
        }
        numbers.removeLast()
        return numbers
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel())
}
