//
//  NewsDetailsView.swift
//  SnookerBar
//
//  Created by D K on 03.10.2024.
//

import SwiftUI

struct NewsDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var news: News
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
                    
            VStack {
                if let url = URL(string: news.image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: size().width, height: 300)
                            .offset(y: -20)
                            .clipped()
                            .ignoresSafeArea()
                    } placeholder: {
                        ProgressView()
                            .frame(width: size().width, height: 300)
                    }
                }
                    
                ScrollView {
                    Text(news.header)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .black))
                    
                    Text(news.body)
                        .foregroundStyle(.white)
                        .padding(.top)
                        .font(.system(size: 22, weight: .regular))
                }
                .padding(.horizontal, 20)
                .padding(.top, -50)
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

