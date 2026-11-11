import SwiftUI

struct ProgressBarView: View {
    var progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))

                Capsule()
                    .fill(Color.green)
                    .frame(width: geo.size.width * progress)
            }
        }
        .frame(height: 6)
        .animation(.easeInOut, value: progress)
    }
}

#Preview {
    ProgressBarView(progress: 0.6)
        .padding()
        .preferredColorScheme(.dark)
}
