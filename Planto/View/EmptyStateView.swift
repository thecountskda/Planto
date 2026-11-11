import SwiftUI

struct EmptyStateView: View {
    var imageName: String
    var title: String
    var subtitle: String
    var buttonTitle: String? = nil
    
    //String? is an optional. The ? means “this can be a String or nothing (nil)”. The empty state needs a button, but the “All Done” state doesn’t, so the button title is optional, with nil as the default.
    
    var action: () -> Void = {}

    var body: some View {
        VStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text(title)
                .font(.title3)
                .bold()

            Text(subtitle)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            if let buttonTitle {
                Button(buttonTitle) {
                    action()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            //if let buttonTitle { ... } is how you safely open an optional. The code inside runs only if there is a value, and inside it buttonTitle is a normal String.
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        imageName: "mascot",
        title: "Start your plant journey!",
        subtitle: "Now all your plants will be in one place and we will help you take care of them :)",
        buttonTitle: "Set Plant Reminder"
    )
    .preferredColorScheme(.dark)
}
