//
//  RegistrationView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//


import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isOn = false
    
    @State private var isNotificationShown = false
    @State private var switched = true
    @State private var isAlerted = false
    
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            BackImageView(image: "bg1")
            
            VStack {
                Text("REGISTRATION")
                    .foregroundStyle(.white)
                    .font(.system(size: 42, weight: .black))
                    .padding(.top, 50)
                
                ScrollView {
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
                        .padding(.top, 20)
                    
                    SecureField("", text: $confirmPassword, prompt: Text("Confirm Password").foregroundColor(.black.opacity(0.6)))
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
                    
                    
                    Toggle("Receive updates and news by email", isOn: $isOn)
                        .font(.system(size: 16, weight: .light))
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                    Button {
                        if isValid {
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password)
                            }
                            withAnimation {
                                isAlerted.toggle()
                            }
                        } else {
                            withAnimation {
                                isAlerted.toggle()
                            }
                            isNotificationShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.semiPurple)
                                .frame(width: size().width - 80, height: 60)
                                .cornerRadius(16)
                            
                            Text("SIGN UP")
                                .foregroundStyle(.white)
                                .font(.system(size: 28, weight: .bold))
                        }
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 100)
                    
//                    Button {
//                        dismiss()
//                    } label: {
//                        Text("Do you already have an account?".uppercased())
//                        + Text("\nSign in".uppercased())
//                            .foregroundColor(.pink)
//                    }
//                    .foregroundColor(.white)
//                    .font(.system(size: 16, weight: .light))
//                    .padding(.top, 50)
                }
                .scrollIndicators(.hidden)
            }
        }
        .overlay {
            if isAlerted {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if switched {
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
                                    Text("Incorrect data or user with this email already exists.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlerted = false
                                            switched = true
                                            
                                            email = ""
                                            password = ""
                                            confirmPassword = ""
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
                        switched = false
                    }
                }
            }
        }
    }
}

#Preview {
    RegistrationView(viewModel: AuthViewModel())
}

extension RegistrationView: AuthViewModelProtocol {
    var isValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
    }
}
