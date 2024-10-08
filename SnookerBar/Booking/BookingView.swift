//
//  BookingView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

struct BookingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var email = ""
    @State var number = ""
    @State var date = Date()
    @State var time = Date()
    @State var players = 2
    @State var note = ""
    
    @State var isShown = false
    
    private var availablePlayers = [2, 4, 6]
    private var startDate: Date
    private var endDate: Date
    
    init() {
        let calendar = Calendar.current
        self.startDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        self.endDate = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!
    }
    
    var body: some View {
        ZStack {
            BackImageView(image: "bg3")
            
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
                Text("BOOKING")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 43)
                
                ScrollView {
                    TextField("", text: $name, prompt: Text("Name").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    TextField("", text: $email, prompt: Text("E-mail").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    TextField("", text: $number, prompt: Text("Phone number").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    HStack {
                        Spacer()
                        
                        DatePicker("Date and Time", selection: $date, in: Date()..., displayedComponents: .date)
                            .foregroundColor(.gray)
                            .tint(.darkPurple)
                        
                        DatePicker("", selection: $time, in: startDate...endDate, displayedComponents: .hourAndMinute)
                            .foregroundColor(.gray)
                            .tint(.darkPurple)
                            .frame(width: 60)
                    }
                    .padding()
                    .padding(.vertical, 5)
                    .foregroundColor(.black)
                    .tint(.black)
                    .background {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    
                    HStack {
                        Text("Players")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Picker("", selection: $players) {
                            ForEach(availablePlayers, id: \.self) { text in
                                Text("\(text)")
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .tint(.black)
                        
                    }
                    .padding()
                    .padding(.vertical, 5)
                    .background {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    TextEditor(text: $note)
                        .frame(height: 150)
                        .padding(10)
                        .padding(.vertical, 25)
                        .background {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                
                                VStack {
                                    HStack {
                                        Text("Note")
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                    .padding(.top, 10)
                                    .padding(.leading, 14)
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    Button {
                        if !name.isEmpty && !email.isEmpty {
                            withAnimation {
                                isShown.toggle()

                            }
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.semiPurple)
                                .frame(width: size().width - 80, height: 60)
                                .cornerRadius(16)
                            
                            Text("BOOK")
                                .foregroundStyle(.white)
                                .font(.system(size: 28, weight: .bold))
                                
                        }
                    }
                    .disabled((name.isEmpty && email.isEmpty))
                    .opacity((name.isEmpty || email.isEmpty) ? 0.5 : 1)
                    .padding(.top, 50)
                    .padding(.bottom, 150)
                }
                .scrollIndicators(.hidden)
            }
        }
        .overlay {
           
            if isShown {
                ZStack {
                    Image("bg3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size().width, height: size().height)
                        .opacity(0.8)
                        .blur(radius: 12)
                    
                    CustomAlertView {
                        dismiss()
                    }
                }
               
            }
        }
    }
}

#Preview {
    BookingView()
}


struct CustomAlertView: View {
    
    @State var isShown = false
    var completion: () -> ()
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 40, height: 250)
            .cornerRadius(12)
            .blur(radius: 3)
            .foregroundColor(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.semiPurple)
                
                if !isShown {
                    ProgressView()
                        .controlSize(.large)
                        .colorMultiply(.darkPurple)
                } else {
                    VStack {
                        Text("The reservation message has been sent. You will be contacted at the number or email you provided.")
                            .foregroundStyle(.black)
                            .font(.system(size: 22, weight: .light))
                            .padding(.horizontal)
                        
                        Button {
                            completion()
                        } label: {
                            Text("OK")
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                    }
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShown.toggle()
                }
            }
    }
}
