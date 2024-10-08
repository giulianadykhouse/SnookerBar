//
//  RuleDetailView.swift
//  SnookerBar
//
//  Created by D K on 03.10.2024.
//

import SwiftUI

struct RuleDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var rule: Rule
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
                    
            VStack {
                Image(rule.name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size().width, height: 300)
                    .offset(y: -20)
                    .clipped()
                    .ignoresSafeArea()
                    
                ScrollView {
                    Text(rule.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .black))
                    
                    Text(rule.description)
                        .foregroundStyle(.white)
                        .padding(.top)
                        .font(.system(size: 22, weight: .regular))
                }
                .padding(.horizontal, 20)
                .padding(.top, -20)
                .scrollIndicators(.hidden)
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .black))
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

//#Preview {
//    RuleDetailView()
//}
