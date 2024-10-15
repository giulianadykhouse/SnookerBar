//
//  InitialRootView.swift
//  SnookerBar
//
//  Created by D K on 06.10.2024.
//

import SwiftUI

struct InitialRootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView()
                    .environmentObject(viewModel)
            } else {
                InitialView(viewModel: viewModel)
            }
        }
        .onAppear {
            AppDelegate.orientationLock = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}
#Preview {
    InitialRootView()
}
