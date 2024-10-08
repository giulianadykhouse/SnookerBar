//
//  SettingsView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI
import MessageUI
import StoreKit


struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showingMailWithError = false
    @State private var showingMailWithSuggestion = false
    @State private var isDeleteAlertShown = false
    @State private var isAlertShown = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .black))
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                
                Spacer()
            }
            
            VStack {
                Text("SETTINGS")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 3)
                
                ScrollView {
                    VStack(spacing: 30) {
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                showingMailWithSuggestion.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width - 50, height: 80)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                
                                Text("FEEDBACK")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .sheet(isPresented: $showingMailWithSuggestion) {
                            MailComposeView(isShowing: $showingMailWithSuggestion, subject: "Feedback message", recipientEmail: "samgoodman0218@gmail.com", textBody: "")
                        }
                        
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                showingMailWithError.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width - 50, height: 80)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                
                                Text("REPORT A BUG")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .sheet(isPresented: $showingMailWithError) {
                            MailComposeView(isShowing: $showingMailWithError, subject: "Error message", recipientEmail: "samgoodman0218@gmail.com", textBody: "")
                        }
                        
                        Button {
                            openPrivacyPolicy()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width - 50, height: 80)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                
                                Text("PRIVACY POLICY")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Button {
                            requestAppReview()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width - 50, height: 80)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                
                                Text("RATE THE APP")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.semiPurple)
                                    .frame(width: size().width - 80, height: 60)
                                    .cornerRadius(16)
                                
                                Text("SIGN OUT")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28, weight: .bold))
                            }
                        }
                        .padding(.top, 50)
                        
                        
                        if authViewModel.currentuser != nil {
                            Button {
                                isDeleteAlertShown.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.semiPurple)
                                        .frame(width: size().width - 80, height: 60)
                                        .cornerRadius(16)
                                    
                                    Text("DELETE ACCOUNT")
                                        .foregroundStyle(.red)
                                        .font(.system(size: 14, weight: .bold))
                                }
                            }
                        }
                      
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .alert("Are you sure you want to delete your account?", isPresented: $isDeleteAlertShown) {
            Button {
                authViewModel.deleteUserAccount { result in
                    switch result {
                    case .success():
                        print("Account deleted successfully.")
                        authViewModel.userSession = nil
                        authViewModel.currentuser = nil
                    case .failure(let error):
                        print("ERROR DELELETING: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button {
                isDeleteAlertShown.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("To access your reserves you will need to create a new account.")
        }
        .alert("Unable to send email", isPresented: $isAlertShown) {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
    }
    
    func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
