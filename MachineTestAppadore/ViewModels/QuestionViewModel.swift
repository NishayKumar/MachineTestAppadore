import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    
    init() {
        loadQuestions()
    }
    
    func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Failed to locate JSON file.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(QuestionData.self, from: data)
            DispatchQueue.main.async {
                self.questions = decodedData.questions
            }
        } catch {
//            print("Error decoding JSON: \(error.localizedDescription)")
            print(String(describing: error))
        }
    }
}
