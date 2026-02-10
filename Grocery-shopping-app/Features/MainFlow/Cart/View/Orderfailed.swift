
import SwiftUI

struct OrderFailed: View {
    @State private var showImage = false
    @State private var isPulsing = false

    var body: some View {
       
            ZStack {

                Color(.systemBackground)
                    .ignoresSafeArea()

                RadialGradient(colors: [Color.pink.opacity(0.11), .clear],
                               center: .topTrailing,
                               startRadius: 50,
                               endRadius: 200)
                    .ignoresSafeArea()

                RadialGradient(colors: [Color.green.opacity(0.10), .clear],
                               center: .topLeading,
                               startRadius: 50,
                               endRadius: 400)
                    .ignoresSafeArea()

                RadialGradient(colors: [Color.blue.opacity(0.14), .clear],
                               center: .bottom,
                               startRadius: 50,
                               endRadius: 500)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Image("OrderFailed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 220)
                            .scaleEffect(isPulsing ? 1.02 : 0.98)
                            .opacity(0.95)
                            .animation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true),
                                value: isPulsing
                            )
                            .onAppear {
                                isPulsing = true
                            }


                        Text("Oops! Order Failed")
                            .font(.system(size: 33, weight: .semibold))
                            .multilineTextAlignment(.center)

                        Text("Something went tembly wrong.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 32)
                    .frame(maxWidth: 400)

                    Spacer()

                    PrimaryButton(title: "Please Try Again") {
                        // retry
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Button("Back to home") {
                        // back
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.bottom, 40)
                }

            }
        }
    }


#Preview {
    OrderFailed()
}

