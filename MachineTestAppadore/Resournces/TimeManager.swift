import Foundation

// MARK: - Timer Manager
class TimerManager: ObservableObject {
    @Published var secondsRemaining: Int = 40
    @Published var formattedTime: String = "00:40"
    
    private var timer: Timer?
    private var onComplete: (() -> Void)?
    
    func startTimer(seconds: Int, completion: @escaping () -> Void) {
        stopTimer()
        secondsRemaining = seconds
        onComplete = completion
        updateFormattedTime()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                self.updateFormattedTime()
            } else {
                self.stopTimer()
                self.onComplete?()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateFormattedTime() {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        formattedTime = String(format: "%02d:%02d", minutes, seconds)
    }
}

