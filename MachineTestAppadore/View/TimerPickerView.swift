//
//  TimerPickerView.swift
//  MachineTestAppadore
//
//  Created by Nishay Kumar on 27/02/25.
//

import SwiftUI

struct TimerPickerView: View {
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 5) {
//            Text("SCHEDULE")
//                .font(.system(size: 32, weight: .bold))
//                .padding(.top, 30)
            
            // Time Picker Labels
            HStack(spacing: 40) {
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
            
            // Time Pickers
            HStack(spacing: 40) {
                // Hours
                HStack {
                    Picker("", selection: $hours) {
                        ForEach(0..<24) { hour in
                            Text("\(hour)")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 100)
                    .clipped()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemGray5))
                    )
                }
                
                // Minutes
                HStack {
                    Picker("", selection: $minutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute)")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 100)
                    .clipped()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemGray5))
                    )
                }
                
                // Seconds
                HStack {
                    Picker("", selection: $seconds) {
                        ForEach(0..<60) { second in
                            Text("\(second)")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 100)
                    .clipped()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemGray5))
                    )
                }
            }
            
            // Save Button
            Button(action: {
                showAlert = true
            }) {
                Text("Save")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 150, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.accent)
                    )
            }
            .padding(.top, 30)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Time Saved"),
                    message: Text("You selected \(hours) hours, \(minutes) minutes, and \(seconds) seconds"),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Spacer()
        }
        .padding()
//        .background(Color(UIColor.systemBackground))
    }
}


#Preview {
    TimerPickerView()
}
