import SwiftUI

struct MenuView: View {
    @Binding var screen: AppScreen

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("POPPER")
                .font(.largeTitle)
                .bold()

            Text("Zbij bańki zanim dotkną sufitu")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()

            Button {
                screen = .game
            } label: {
                Text("Graj")
                    .font(.title2)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Button {
                screen = .howToPlay
            } label: {
                Text("Jak grać")
                    .font(.title3)
                    .frame(width: 200, height: 45)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
            }

            Spacer()
        }
    }
}


