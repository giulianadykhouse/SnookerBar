//
//  NewsCellView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

struct RulesCellView: View {
    
//    var image: String
//    var title: String
    
    var rule: Rule
    @State var isShown = false
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 50, height: 250)
            .cornerRadius(16)
            .overlay {
                ZStack {
                    Image(rule.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size().width - 50, height: 250)
                        .clipped()
                        .cornerRadius(16)
                    
                    VStack {
                        
                        
                        RoundedRectangle(cornerRadius: 12)
                        .frame(width: size().width - 80, height: 60)
                        .foregroundColor(.white)
                        
                        .overlay {
                            Text(rule.name)
                                .foregroundStyle(.black)
                                .font(.system(size: 20, weight: .black))
                        }
                        Spacer()
                    }
                    .padding(.top)
                        
                }
            }
            .onTapGesture {
                isShown.toggle()
            }
            .fullScreenCover(isPresented: $isShown) {
                RuleDetailView(rule: rule)
            }
    }
}

//#Preview {
//    RulesCellView(image: "mock", title: "Some good news about bar")
//}
