//
//  InitialRootView.swift
//  SnookerBar
//
//  Created by D K on 06.10.2024.
//

import SwiftUI

struct InitialRootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView()
                    .environmentObject(viewModel)
            } else {
                InitialView(viewModel: viewModel)
            }
        }
    }
}
#Preview {
    InitialRootView()
}
