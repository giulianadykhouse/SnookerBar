//
//  MenuView.swift
//  SnookerBar
//
//  Created by D K on 06.10.2024.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.darkPurple)
            
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
                .padding(.top, 50)
                .padding(.leading, 10)
                
                Spacer()
            }
            
            VStack {
                Text("MENU")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 43)
                
                ZoomableScrollView(image: Image("menucard"))
                
                Spacer()
            }
        }
    }
}

#Preview {
    MenuView()
}


struct ZoomableScrollView: View {
    @State private var scale: CGFloat = 1.0  // Масштабирование
    @State private var lastScale: CGFloat = 1.0  // Запоминает последний масштаб
    
    var image: Image
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: geometry.size.width * scale,
                        height: geometry.size.height * scale
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            .onEnded { _ in
                                lastScale = scale
                            }
                    )
            }
        }
        .edgesIgnoringSafeArea(.all)  // Чтобы картинка могла заходить за границы экрана
    }
}
