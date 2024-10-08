//
//  BarNewsView.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

class News: Codable {
    var header: String
    var body: String
    var image: String
    
    init(header: String, body: String, image: String) {
        self.header = header
        self.body = body
        self.image = image
    }
}

struct BarNewsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var news: [News] = []
    
    var body: some View {
        ZStack {
            BackImageView(image: "bg1")
            
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
                Text("NEWS")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 43)
                
                ScrollView {
                    ForEach(news, id: \.header) { news in
                        NewsCellView(news: news)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            do {
                news = try await loadNews()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadNews() async throws -> [News] {
        guard let url = URL(string: "https://api.jsonserve.com/64Rjcg") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let news = try JSONDecoder().decode([News].self, from: data)
        return news
    }
}


#Preview {
    BarNewsView()
}
