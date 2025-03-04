import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(.accent)
                .ignoresSafeArea()
                .frame(height: 100)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemGray5))
                    .frame(height: 350)
                    .padding(.horizontal, 2)
                
                VStack(spacing: 0) {
                    headerView()
                    Rectangle() // divider
                        .fill(.gray)
                        .opacity(0.5)
                        .frame(height: 1)
                    MainView()
                }
                .padding(.horizontal, 2)
                .frame(height: 350, alignment: .top)
            }
            
            Spacer()
        }
    }
}


extension ContentView {
    func headerView() -> some View {
        
        HStack(alignment: .center) {
            ZStack{
                Rectangle()
                    .opacity(0.8)
                    .clipShape(.rect(topLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 10))
                    .frame(width: 100, height: 70)
                Text("00:00")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                
            }
            Spacer()
            Text("Flags Challenge")
                .font(.title3.bold())
                .textCase(.uppercase)
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                .offset(x: -25)
            Spacer()
        }
        
           
    }
}

#Preview {
    ContentView()
}

