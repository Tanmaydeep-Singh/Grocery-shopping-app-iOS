
import SwiftUI

struct OfferBannerView: View {

    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        TabView(selection: $viewModel.currentBannerIndex) {

            ForEach(viewModel.bannerImages.indices, id: \.self) { index in
                Image(viewModel.bannerImages[index])
                    .resizable()
                    .scaledToFill()
                    .frame(height: 140, alignment: .top)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .tag(index)
            }
        }
        .frame(height: 140)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .onAppear {
            viewModel.startBannerAutoScroll()
        }
        .onDisappear {
            viewModel.stopBannerAutoScroll()
        }
        .animation(.easeInOut(duration: 0.5),
                   value: viewModel.currentBannerIndex)
    }
}

#Preview {
    OfferBannerView()
}
