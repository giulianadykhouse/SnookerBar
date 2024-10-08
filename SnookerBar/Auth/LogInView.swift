//
//  LogInView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

struct LogInView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var isAlertShown = false
    @State private var switcher = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.darkPurple)
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo2")
                        .resizable()
                        .frame(width: 220, height: 220)
                    
                    TextField("", text: $email, prompt: Text("E-mail").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    SecureField("", text: $password, prompt: Text("Password").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Button {
                        Task {
                            try await viewModel.signIn(email: email, password: password)
                        }
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.semiPurple)
                                .frame(width: size().width - 80, height: 60)
                                .cornerRadius(16)
                            
                            Text("LOG IN")
                                .foregroundStyle(.white)
                                .font(.system(size: 28, weight: .bold))
                        }
                    }
                    .padding(.top, 50)
                    
                    Button {
                        Task {
                            await viewModel.signInAnonymously()
                        }
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.semiPurple)
                                .frame(width: size().width - 80, height: 60)
                                .cornerRadius(16)
                            
                            Text("Continue as Guest".uppercased())
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .light))
                        }
                    }
                    
//                    NavigationLink {
//                        RegistrationView(viewModel: viewModel)
//                    } label: {
//                        Text("you don't have an account yet?".uppercased())
//                        + Text("\nsign up now".uppercased())
//                            .foregroundColor(.pink)
//                    }
//                    .foregroundColor(.white)
//                    .font(.system(size: 16, weight: .light))
//                    .padding(.top, 50)
//                    
                    
                    Spacer()
                }
            }
        }
        .tint(.white)
        .overlay {
            if isAlertShown {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if switcher {
                        Rectangle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                ProgressView()
                                    .tint(.purple)
                                    .controlSize(.large)
                            }
                    } else {
                        Rectangle()
                            .frame(width: 290, height: 250)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                VStack {
                                    Text("Incorrect email or password.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlertShown = false
                                            switcher = true
                                        }
                                    } label: {
                                       Image(systemName: "xmark")
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                            .bold()
                                    }
                                    .padding(.top, 30)
                                }
                               
                            }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        switcher = false
                    }
                }
            }
        }
    }
}

#Preview {
    LogInView(viewModel: AuthViewModel())
}
