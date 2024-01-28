//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Chad Eymard on 1/24/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
     
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingEnd = false
    @State private var endTitle = ""
    @State private var endMessage = ""
    
    @State private var correct: Int = 0
    @State private var incorrect: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("""
                    Correct: \(correct)
                    Incorrect: \(incorrect)
                    """)
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert(endTitle, isPresented: $showingEnd) {
            Button("Play again", action: reset)
        } message: {
            Text(endMessage)
        }
    }
    
    func isGameOver() -> Bool {
        print("Correct: \(correct), Incorrect: \(incorrect)")
        if ((correct + incorrect) == 8) {
            return true
        }
        return false
    }
    
    func flagTapped(_ number: Int) {
        if (number == correctAnswer) {
            correct += 1
            scoreTitle = "Correct"
            scoreMessage = "That is the flag of \(countries[number])"
            
        } else {
            incorrect += 1
            scoreTitle = "Wrong"
            scoreMessage = "That is the flag of \(countries[number])"
        }
        
        showingScore = true
        
        if(isGameOver()) {
            showingEnd = true
            endTitle = "Game Over"
            endMessage = """
                         Correct: \(correct)
                         Incorrect: \(incorrect)
                         """
        }
        
    }
    
    func reset() {
        correct = 0
        incorrect = 0
        askQuestion()
    }
    
    func askQuestion() {
        if (!isGameOver()) {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

#Preview {
    ContentView()
}
