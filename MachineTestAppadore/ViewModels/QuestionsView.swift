//import SwiftUI
//
//struct QuestionsView: View {
//    @StateObject private var viewModel = QuestionViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List(viewModel.questions) { question in
//                Section(header: Text("Country Code: \(question.countryCode)"), footer: Text("Answer ID: \(question.answerId)")
//                ) {
//                    ForEach(question.countries) { country in
//                        HStack {
//                            Text(country.countryName)
//                            Spacer()
//                            Text("ID: \(country.id)")
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Questions")
//        }
//    }
//}
////footer: Text("Answer ID: \(question.answerID)")
//#Preview {
//    QuestionsView()
//}
