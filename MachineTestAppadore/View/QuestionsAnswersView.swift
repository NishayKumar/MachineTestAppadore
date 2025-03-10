import SwiftUI

struct QuestionsAnswersView: View {
    @StateObject private var vm = QuestionViewModel()
    @ObservedObject var timerManager: TimerManager
    
    @State private var selectedAnswer: Int?
    @State private var showResult = false
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var maxQuestions = 15
    @State private var gameOver = false
    @State private var showGameOverView = true
    
    var body: some View {
        VStack(spacing: 5) {
            if !gameOver {
                HStack(){
                    ZStack {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 0)
                            .frame(width: 40, height: 40)
                        
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 35, height: 45)
                            
                            Text("\(currentQuestionIndex + 1)")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                        }
                    }
                    
                    .background(.accent)
                    .clipShape(.rect(bottomTrailingRadius: 10, topTrailingRadius: 10))
                    Text("guess the country from the flag?")
                        .textCase(.uppercase)
                        .font(.callout)
                        .padding(.horizontal, 20)
                }
            }
            
            if gameOver {
                if showGameOverView {
                    GameOverView()
                        .onAppear {
                            timerManager.stopTimer()
                            timerManager.resetFormattedTime() 
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showGameOverView = false
                            }
                        }
                } else {
                    ScoreView(score: score, maxScore: maxQuestions)
                }
            } else if !vm.questions.isEmpty {
                let currentQuestion = vm.questions[currentQuestionIndex]
                
                HStack(spacing: 30) {
                    Image(currentQuestion.countryCode)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 80)
                        .cornerRadius(8)
                    
                    VStack(spacing: 20) {
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
                .padding(.vertical)
                
            }
        }
        .onAppear {
            vm.loadQuestions()
            startTimer()
        }
    }
    
    private func OptionButton(country: Country, correctId: Int) -> some View {
        VStack(spacing: 5) {
            Button(action: {
                selectedAnswer = country.id
                showResult = true
                
                timerManager.stopTimer()
                
                
                if country.id == correctId {
                    score += 10
                }
                // 10-second interval
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    moveToNextQuestion()
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
    

}


struct GameOverView: View {
    var body: some View {
        Text("Game Over")
            .font(.largeTitle.bold())
            .frame(maxHeight: .infinity)
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
            Text("\(score)/\(maxScore*10)")
                .font(.largeTitle.bold())
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    QuestionsAnswersView(timerManager: TimerManager())
        .background(Color(UIColor.systemGray5))
}


extension QuestionsAnswersView {
    // MARK: - Logic
    private func resetQuestion() {
        selectedAnswer = nil
        showResult = false
    }
    
    private func startTimer() {
        timerManager.startTimer(seconds: 30) {
            showResult = true
            // 10-second interval
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                moveToNextQuestion()
            }
        }
    }
    
    private func moveToNextQuestion() {
        if currentQuestionIndex < maxQuestions - 1 && currentQuestionIndex < vm.questions.count - 1 {
            currentQuestionIndex += 1
            resetQuestion()
            startTimer()
        } else {
            gameOver = true
        }
    }
    
    private func getButtonBackgroundColor(for countryId: Int, correctId: Int) -> Color {
        
        return countryId == selectedAnswer && countryId != correctId ? Color.red : Color(UIColor.systemGray5)
    }
}
