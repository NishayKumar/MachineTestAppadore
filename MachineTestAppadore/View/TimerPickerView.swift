import SwiftUI

struct MainView: View {
    @State private var showCountdown = false
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    
    var body: some View {
        if showCountdown {
            CountdownTimerView(
                hours: hours,
                minutes: minutes,
                seconds: seconds,
                showCountdown: $showCountdown
            )
        } else {
            TimerPickerView(
                hours: $hours,
                minutes: $minutes,
                seconds: $seconds,
                onSave: {
                    if hours > 0 || minutes > 0 || seconds > 0 {
                        showCountdown = true
                    }
                }
            )
        }
    }
}


struct TimerPickerView: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    var onSave: () -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            Text("SCHEDULE")
                .font(.title2.bold())
                .padding(.vertical, 10)
            
            HStack(spacing: 0) {
                Text("Hour")
                    .font(.headline)
                    .frame(width: 120)
                
                Text("Minute")
                    .font(.headline)
                    .frame(width: 120)
                
                Text("Second")
                    .font(.headline)
                    .frame(width: 120)
            }
            .foregroundStyle(.gray)
            .fontDesign(.monospaced)
            
            HStack(spacing: 30) {
                // Hours
                HStack {
                    Picker("", selection: $hours) {
                        ForEach(0..<24) { hour in
                            Text("\(hour)")
                                .font(.system(size: 32))
                                .foregroundStyle(Color(UIColor.darkGray))
                                .bold()
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 90, height: 70)
                    .clipped()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemGray4))
                    )
                }
                
                // Minutes
                HStack {
                    Picker("", selection: $minutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute)")
                                .font(.system(size: 32))
                                .foregroundStyle(Color(UIColor.darkGray))
                                .bold()
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 90, height: 70)
                    .clipped()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemGray4))
                    )
                }
                
                // Seconds
                HStack {
                    Picker("", selection: $seconds) {
                        ForEach(0..<60) { second in
                            Text("\(second)")
                                .font(.system(size: 32))
                                .foregroundStyle(Color(UIColor.darkGray))
                                .bold()
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 90, height: 70)
                    .clipped()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemGray4))
                    )
                }
            }
            
            Button(action: {
                onSave()
            }) {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.accent)
                    )
            }
            .padding(.top, 10)
        }
    }
}

struct ChallengeView: View {
    var body: some View {
        VStack{
            Text("guess the country from the flag!")
                .font(.title2.bold())
                .padding(.vertical, 10)
        }
    }
}




struct CountdownTimerView: View {
    let totalSeconds: Int
    @State private var timeRemaining: Int
    @State private var timer: Timer? = nil
    @State private var timerFinished = false
    @Binding var showCountdown: Bool
    
    init(hours: Int, minutes: Int, seconds: Int, showCountdown: Binding<Bool>) {
        self.totalSeconds = hours * 3600 + minutes * 60 + seconds
        self._timeRemaining = State(initialValue: self.totalSeconds)
        self._showCountdown = showCountdown
    }
    
    var body: some View {
        ZStack {
            if timerFinished {
                QuestionsAnswersView()
            } else {
                VStack(spacing: 5) {
                    Text("CHALLENGE\nWILL START IN")
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Text(timeString(time: timeRemaining))
                        .font(.system(size: 70, weight: .bold, design: .monospaced))
                        .foregroundColor(.black)

                }
                .onAppear {
                    startTimer()
                }
            }
        }
    }
    
    func timeString(time: Int) -> String {
        if totalSeconds >= 3600 {
            let hours = time / 3600
            let minutes = (time % 3600) / 60
            let seconds = time % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            let minutes = time / 60
            let seconds = time % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                finishTimer()
            }
        }
    }
    
    func finishTimer() {
        timer?.invalidate()
        timer = nil
        timerFinished = true
    }
    
}


#Preview {
    MainView()
}


#Preview {
    CountdownTimerView(
        hours: 0,
        minutes: 0,
        seconds: 0,
        showCountdown: .constant(false)
    )
}
