import Testing

//import Testing
@testable import MachineTestAppadore // Make sure to replace this with your actual app name

struct QuestionModelTests {
    
    @Test func testQuestionIdentifiable() {
        let question = Question(answerId: 5, countries: [], countryCode: "US")
        #expect(question.id == 5)
    }
    
    @Test func testCountryProperties() {
        let country = Country(id: 1, countryName: "France")
        #expect(country.id == 1)
        #expect(country.countryName == "France")
    }
    
    @Test func testQuestionProperties() {
        let countries = [Country(id: 1, countryName: "Germany")]
        let question = Question(answerId: 3, countries: countries, countryCode: "DE")
        
        #expect(question.answerId == 3)
        #expect(question.countryCode == "DE")
        #expect(question.countries.count == 1)
        #expect(question.countries[0].countryName == "Germany")
    }
}
