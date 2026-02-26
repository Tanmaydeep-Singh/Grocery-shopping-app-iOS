import SwiftUI

struct OrderAcceptedView: View {

    @EnvironmentObject private var router: AppRouter
    @State private var isAnimating = false
    @State private var isShining = false
    @State private var goToTrackOrder = false

    var body: some View {
        ZStack {

            // MARK: - Background
            Color(.systemBackground)
                .ignoresSafeArea()

            RadialGradient(colors: [Color.pink.opacity(0.12), .clear],
                           center: .topTrailing,
                           startRadius: 50,
                           endRadius: 400)
                .ignoresSafeArea()

            RadialGradient(colors: [Color.green.opacity(0.10), .clear],
                           center: .topLeading,
                           startRadius: 50,
                           endRadius: 400)
                .ignoresSafeArea()

            RadialGradient(colors: [Color.blue.opacity(0.10), .clear],
                           center: .bottom,
                           startRadius: 50,
                           endRadius: 500)
                .ignoresSafeArea()

            // MARK: - Content
            VStack {

                // MARK: Main Content
                VStack(spacing: 20) {

                    orderImage

                    Text("Your Order has been\naccepted")
                        .font(.system(size: 28, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)

                    Text("Your items has been placed and is on it's way to being processed")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }
                .padding(.horizontal, 32)
                .padding(.top, 80)
                .frame(maxWidth: 400)

                Spacer()

                // MARK: Actions
                VStack(spacing: 16) {
                    PrimaryButton(title: "Track Order") {
                        goToTrackOrder = true
                    }

                    Button("Back to home") {
                        router.selectedTab = .home
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            startMainAnimation()
        }
        .navigationDestination(isPresented: $goToTrackOrder) {
            DeliveryTrackingView(
                locationManager: LocationManager()
            )
        }
    }

    // MARK: - Animated Image
    private var orderImage: some View {
        Image("OrderAccepted")
            .resizable()
            .scaledToFit()
            .offset(x: -20)
            .frame(width: 269, height: 240)
            .overlay(shineOverlay)
            .scaleEffect(isAnimating ? 1.0 : 0.3)
            .rotationEffect(.degrees(isAnimating ? 0 : -180))
            .opacity(isAnimating ? 1.0 : 0.0)
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.5)) {
                    isAnimating = true
                }
            }
    }

    private var shineOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0),
                Color.white.opacity(0.6),
                Color.white.opacity(0)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(width: 100)
        .rotationEffect(.degrees(45))
        .offset(x: isShining ? 300 : -300)
        .opacity(isAnimating ? 1 : 0)
    }

    private func startMainAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            startShineAnimation()
        }
    }

    private func startShineAnimation() {
        withAnimation(.easeInOut(duration: 1.0)) {
            isShining = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isShining = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                startShineAnimation()
            }
        }
    }
}

#Preview {
    OrderAcceptedView()
}
