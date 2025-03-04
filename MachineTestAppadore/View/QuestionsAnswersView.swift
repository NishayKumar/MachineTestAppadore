import SwiftUI

struct QuestionsAnswersView: View {
    @StateObject private var vm = QuestionViewModel()
    
    // UI state
    @State private var selectedAnswer: Int?
    @State private var showResult = false
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var maxQuestions = 15
    @State private var gameOver = false
    
    var body: some View {
        VStack(spacing: 5) {
            if gameOver {
                GameOverView()
                ScoreView(score: score, maxScore: maxQuestions)
                
                Button(action: {
                    // Reset the game
                    currentQuestionIndex = 0
                    score = 0
                    gameOver = false
                    resetQuestion()
                }) {
                    Text("Play Again ")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
            } else if !vm.questions.isEmpty {
                let currentQuestion = vm.questions[currentQuestionIndex]
                
                HStack(spacing: 30) {
                    // Display flag based on country code
                    Image(currentQuestion.countryCode)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 80)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    VStack(spacing: 20) {
                        // First row of options (0 and 1)
                        HStack(spacing: 15) {
                            if currentQuestion.countries.count > 0 {
                                OptionButton(
                                    country: currentQuestion.countries[0],
                                    correctId: currentQuestion.answerId
                                )
                            }
                            
                            if currentQuestion.countries.count > 1 {
                                OptionButton(
                                    country: currentQuestion.countries[1],
                                    correctId: currentQuestion.answerId
                                )
                            }
                        }
                        
                        // Second row of options (2 and 3)
                        HStack(spacing: 15) {
                            if currentQuestion.countries.count > 2 {
                                OptionButton(
                                    country: currentQuestion.countries[2],
                                    correctId: currentQuestion.answerId
                                )
                            }
                            
                            if currentQuestion.countries.count > 3 {
                                OptionButton(
                                    country: currentQuestion.countries[3],
                                    correctId: currentQuestion.answerId
                                )
                            }
                        }
                    }
                    .padding(.trailing)
                }
                .frame(maxWidth: 320)
                .padding()
                
                // Display current score
                Text("Score: \(score)/\(maxQuestions)")
                    .font(.headline)
                    .padding(.top, 5)
                
                // Navigation controls
                HStack(spacing: 20) {
                    Button(action: {
                        moveToNextQuestion()
                    }) {
                        Text("Next Question")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(showResult ? Color.blue : Color.gray)
                            .cornerRadius(10)
                    }
                    .disabled(!showResult)
                }
                .padding(.top, 10)
            } else {
                // Display loading state or error
                Text("Loading questions...")
                    .font(.headline)
                    .padding()
            }
        }
        .onAppear {
            vm.loadQuestions()
        }
    }
    
    // Helper function to reset the question state
    private func resetQuestion() {
        selectedAnswer = nil
        showResult = false
    }
    
    // Helper function to move to the next question or end game
    private func moveToNextQuestion() {
        if currentQuestionIndex < maxQuestions - 1 && currentQuestionIndex < vm.questions.count - 1 {
            currentQuestionIndex += 1
            resetQuestion()
        } else {
            // End the game
            gameOver = true
        }
    }
    
    // Custom view for option buttons
    @ViewBuilder
    private func OptionButton(country: Country, correctId: Int) -> some View {
        VStack(spacing: 5) {
            Button(action: {
                selectedAnswer = country.id
                showResult = true
                
                // Award points only for correct answers
                if country.id == correctId {
                    score += 1
                }
            }) {
                Text(country.countryName)
                    .font(.callout)
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                showResult ? (country.id == correctId ? Color.green : (country.id == selectedAnswer ? Color.red : Color.black)) : Color.black,
                                lineWidth: 2
                            )
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(getButtonBackgroundColor(for: country.id, correctId: correctId))
                    )
            }
            .disabled(showResult)
            
            Text(showResult ? (country.id == correctId ? "CORRECT" : (country.id == selectedAnswer ? "WRONG" : " ")) : " ")
                .foregroundStyle(country.id == correctId ? .green : .red)
                .font(.caption.bold())
                .frame(height: 10)
        }
    }
    
    private func getButtonBackgroundColor(for countryId: Int, correctId: Int) -> Color {
        if !showResult {
            return Color.white
        }
        
        if countryId == correctId {
            return Color.green.opacity(0)
        } else if countryId == selectedAnswer && countryId != correctId {
            return Color.red
        }
        
        return Color.white
    }
}

// Updated GameOverView and ScoreView
struct GameOverView: View {
    var body: some View {
        Text("Game Over")
            .font(.largeTitle.bold())
    }
}

struct ScoreView: View {
    let score: Int
    let maxScore: Int
    
    var body: some View {
        HStack {
            Text("Score:")
                .font(.largeTitle.bold())
                .foregroundStyle(.accent)
            Text("\(score)/\(maxScore)")
                .font(.largeTitle.bold())
        }
    }
}

#Preview {
    QuestionsAnswersView()
        .background(Color(UIColor.systemGray5))
//    ScoreView()
}


//struct GameOverView: View {
//    var body: some View {
//        Text("Game Over")
//            .font(.largeTitle.bold())
//            .foregroundStyle(.accent)
//    }
//}
//
//
//struct ScoreView: View {
//    var body: some View {
//        HStack{
//            Text("Score:")
//                .font(.largeTitle.bold())
//                .foregroundStyle(.accent)
//            Text("50/150")
//                .font(.largeTitle.bold())
//        }
//    }
//}
