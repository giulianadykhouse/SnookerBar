//
//  InitialView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

struct InitialView: View {
    
    @ObservedObject var viewModel: AuthViewModel

    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.darkPurple)
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo2")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    Text("WELCOME")
                        .foregroundStyle(.white)
                        .font(.system(size: 42, weight: .black))
                    
                    NavigationLink {
                        LogInView(viewModel: viewModel)
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.semiPurple)
                                .frame(width: size().width - 80, height: 60)
                                .cornerRadius(12)
                            
                            Text("LOG IN")
                                .foregroundStyle(.white)
                                .font(.system(size: 28, weight: .bold))
                        }
                 
                    }

                    NavigationLink {
                        RegistrationView(viewModel: viewModel)
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.semiPurple)
                                .frame(width: size().width - 80, height: 60)
                                .cornerRadius(12)
                            
                            Text("REGISTRATION")
                                .foregroundStyle(.white)
                                .font(.system(size: 28, weight: .bold))
                        }
                 
                    }
                }
                
            }
        }
        .tint(.white)
    }
}

#Preview {
    InitialView(viewModel: AuthViewModel())
}
