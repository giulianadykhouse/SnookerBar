//
//  QRView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State var code = "932 133 412"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @State var isShown = false
    
    var body: some View {
        ZStack {
            BackImageView(image: "bg4")
            
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
                    
                    Button {
                        isShown.toggle()
                    } label: {
                        Image(systemName: "lightbulb")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .black))
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 10)
                
                Spacer()
            }
            if authViewModel.currentuser != nil {
                VStack {
                    Text("LOYALTY")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
                        .padding(.top, 43)
                    
                    ScrollView {
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .overlay {
                                Image(uiImage: generateQRCode(from: code))
                                    .resizable()
                                    .interpolation(.none)
                                    .frame(width: 280, height: 280)
                            }
                            .padding(.top, 40)
                        
                        
                        Rectangle()
                            .frame(width: size().width  - 40, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .overlay {
                                Text("CODE: \(code)")
                                    .font(.system(size: 22, weight: .black))
                            }
                            .padding(.top, 40)
                        
                        Rectangle()
                            .frame(width: size().width  - 40, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .overlay {
                                Text("OFFERS: 10% Discount")
                                    .font(.system(size: 22, weight: .black))
                            }
                            .padding(.top, 40)
                    }
                    .scrollIndicators(.hidden)
                }
            } else {
                VStack {
                    Rectangle()
                        .cornerRadius(16)
                        .frame(width: size().width - 40, height: 500)
                        .foregroundColor(.white.opacity(0.2))
                        .overlay {
                            VStack {
                                Text("To participate in the loyalty system you must be registered. \n\nDo you want to register now?")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                                
                                HStack(spacing: 40) {
                                    Button {
                                        authViewModel.signOut()
                                    } label: {
                                        Text("YES")
                                            .foregroundStyle(.white)
                                    }
                                    .padding()
                                    .background {
                                        Rectangle()
                                            .foregroundColor(.semiPurple)
                                            .frame(height: 60)
                                            .cornerRadius(16)
                                    }
                                    
                                    Button {
                                        dismiss()
                                    } label: {
                                        Text("NO")
                                            .foregroundStyle(.white)
                                    }
                                    .padding()
                                    .background {
                                        Rectangle()
                                            .foregroundColor(.semiPurple)
                                            .frame(height: 60)
                                            .cornerRadius(16)
                                    }
                                }
                                .padding(.top, 50)
                            }
                        }
                }
            }
        }
        .onAppear {
            code = UserDefaults.standard.string(forKey: "code") ?? "932 133 412"
        }
        .alert("Loyalty", isPresented: $isShown) {
            Button {
                
            } label: {
                Text("OK")
            }
        } message: {
            Text("\nTo participate in the loyalty program and receive discounts, show the QR code to the establishment manager.\n")
        }

    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data("http://strikeSnooker/&sub2813\(string)".utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRView()
        .environmentObject(AuthViewModel())
}
