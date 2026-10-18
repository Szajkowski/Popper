import SwiftUI

struct HowToPlayView: View {
    @Binding var screen: AppScreen

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Jak grać")
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading, spacing: 12) {
                Text("• Bańki lecą z dołu do góry ekranu")
                Text("• Kliknij bańkę zanim dotknie sufitu")
                Text("• Każda zbita bańka = 1 punkt")
                Text("• 3 pudła kończą grę")
                Text("• Im więcej punktów, tym szybciej lecą bańki")
            }
            .font(.body)

            Spacer()

            Button {
                screen = .menu
            } label: {
                Text("Powrót")
                    .font(.title3)
                    .frame(width: 200, height: 45)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
    }
}

