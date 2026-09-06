import SwiftUI

struct CelebrationView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow.opacity(0.3))
                .frame(width: 100, height: 100)
                .scaleEffect(isAnimating ? 1.5 : 0.5)
                .opacity(isAnimating ? 0 : 1)
            
            Image(systemName: "star.fill")
                .font(.system(size: 50))
                .foregroundColor(.yellow)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .scaleEffect(isAnimating ? 1.2 : 0.8)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatCount(2, autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
