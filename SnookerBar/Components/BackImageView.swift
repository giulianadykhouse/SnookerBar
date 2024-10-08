//
//  BackImageView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

struct BackImageView: View {
    
    var image: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .frame(width: size().width, height: size().height)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    BackImageView(image: "bg1")
}
