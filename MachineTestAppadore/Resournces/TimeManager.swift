import Foundation

// MARK: - Timer Manager
class TimerManager: ObservableObject {
    @Published var secondsRemaining: Int = 30
    @Published var formattedTime: String = "00:00"
    
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
        DispatchQueue.main.async {
            let minutes = self.secondsRemaining / 60
            let seconds = self.secondsRemaining % 60
            self.formattedTime = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func resetFormattedTime() {
        DispatchQueue.main.async {
            self.formattedTime = "00:00"
        }
    }
}

