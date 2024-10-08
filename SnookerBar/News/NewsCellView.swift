//
//  NewsCellView.swift
//  SnookerBar
//
//  Created by D K on 03.10.2024.
//

import SwiftUI



struct NewsCellView: View {
    
    var news: News
    
    @State var isShown = false
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 50, height: 250)
            .cornerRadius(16)
            .foregroundColor(.darkPurple)
            .overlay {
                ZStack {
                    if let url = URL(string: news.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: size().width - 50, height: 250)
                                .clipped()
                                .cornerRadius(16)
                        } placeholder: {
                            ProgressView()
                                .frame(width: size().width - 50, height: 250)
                        }
                    }
                        
                    VStack {
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 12)
                        .frame(width: size().width - 80, height: 60)
                        .foregroundColor(.white)
                        
                        .overlay {
                            Text(news.header)
                                .foregroundStyle(.black)
                                .font(.system(size: 20, weight: .black))
                        }
                        
                    }
                    .padding(.bottom)
                        
                }
            }
            .onTapGesture {
                isShown.toggle()
            }
            .fullScreenCover(isPresented: $isShown) {
                NewsDetailView(news: news)
            }
    }
}

//#Preview {
//    NewsCellView()
//}
