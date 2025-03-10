import Testing
import Foundation

@testable import MachineTestAppadore

struct QuestionViewModelTests {
    
    @Test func testDecodeValidJSON() async throws {
        let jsonString = """
        {
            "questions": [
                {
                    "answer_id": 4,
                    "countries": [
                        {
                            "id": 1,
                            "country_name": "United States"
                        },
                        {
                            "id": 2,
                            "country_name": "Canada"
                        },
                        {
                            "id": 3,
                            "country_name": "India"
                        },
                        {
                            "id": 4,
                            "country_name": "Philippines"
                        }
                    ],
                    "country_code": "PH"
                }
            ]
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            #expect(Bool(false), "Failed to convert string to data")
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(QuestionData.self, from: jsonData)
            #expect(decodedData.questions.count == 1)
            #expect(decodedData.questions[0].answerId == 4)
            #expect(decodedData.questions[0].countryCode == "PH")
            #expect(decodedData.questions[0].countries.count == 4)
            #expect(decodedData.questions[0].countries[0].countryName == "United States")
            #expect(decodedData.questions[0].countries[3].countryName == "Philippines")
        } catch {
            #expect(Bool(false), "Failed to decode JSON: \(error)")
        }
    }
    
    @Test func testDecodeInvalidJSON() async throws {
        let invalidJSON = "{ invalid json }".data(using: .utf8)!
        
        do {
            _ = try JSONDecoder().decode(QuestionData.self, from: invalidJSON)
            #expect(Bool(false), "Expected decoding to fail but it succeeded")
        } catch {
            #expect(Bool(true), "Decoding invalid JSON correctly threw an error")
        }
    }
    
    @Test func testViewModelInitialization() async throws {
        _ = QuestionViewModel()
        try await Task.sleep(nanoseconds: 1_000_000_000) // Sleep for 1 second
        #expect(true)
    }
}
