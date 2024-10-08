//
//  View + Extension.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

extension View {
    func size() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
