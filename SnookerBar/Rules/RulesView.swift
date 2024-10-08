//
//  RulesView.swift
//  SnookerBar
//
//  Created by D K on 03.10.2024.
//

import SwiftUI

class Rule {
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

struct RulesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var types: [Rule] = [
        Rule(name: "Eight-Ball Pool", description: """
Objective: Pocket all of your designated balls (solids or stripes) and then legally pocket the 8-ball.

Setup: 15 balls (1-7 solids, 9-15 stripes) and a cue ball. Balls are racked in a triangle.

Turns: Players take turns. Once a ball type (solid or stripe) is legally pocketed, the player continues shooting that type.

Win: Pocket all assigned balls and the 8-ball, without fouling.
"""),
        Rule(name: "Nine-Ball Pool", description: """
Objective: Pocket the 9-ball after hitting the lowest-numbered ball on the table first.

Setup: Balls 1-9 are racked in a diamond shape.

Turns: Players must always hit the lowest-numbered ball first, but can pocket any ball.

Win: Legally pocket the 9-ball.
"""),
        Rule(name: "Straight Pool (14.1 Continuous)", description: """
Objective: Reach a set number of points by pocketing any balls.

Setup: 15 balls are racked. Any ball can be pocketed.

Turns: Players score 1 point per ball pocketed and continue their turn until they miss.

Win: Reach the agreed-upon points (e.g., 100 or 150).
"""),
        Rule(name: "Snooker", description: """
Objective: Score more points than your opponent by pocketing balls in a specific order.

Setup: 15 red balls and 6 colored balls. Reds are worth 1 point, colors have different point values.

Turns: Players alternate between pocketing red balls and colored balls. Reds must be pocketed first.

Win: Highest score at the end of the frame or by opponent conceding.
"""),
        Rule(name: "Carom (Carambole)", description: """
Objective: Score points by making the cue ball hit both other object balls on the table.

Setup: Played on a table without pockets, using 3 balls (2 cue balls, 1 red object ball).

Turns: Each successful carom (cue ball hits both object balls) scores a point.

Win: First to reach the set number of points.
"""),
        Rule(name: "Three-Cushion Billiards", description: """
Objective: Hit both object balls with the cue ball, but the cue ball must also contact at least three cushions before striking the second object ball.

Setup: Played on a pocketless table with 3 balls.

Turns: Players score 1 point per successful shot.

Win: Reach the set number of points (usually 15 or 40).
""")
    ]
    
    
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
                Text("RULES")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 43)
                
                ScrollView {
                    VStack {
                        ForEach(types, id: \.name) { rule in
                            RulesCellView(rule: rule)
                        }
                    }
                    .padding(.bottom, 100)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}


#Preview {
    RulesView()
}
