import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    HomeHeaderView()
                    SearchBarView(text: $viewModel.searchText)
                    OfferBannerView()
                    
                    ProductGridView(title: HomeSectionType.exclusiveOffer.title, products: viewModel.products)
                    
                    ProductGridView(title: HomeSectionType.bestSelling.title, products: viewModel.products)
                    
                    VStack(alignment: .leading){
                        Text(HomeSectionType.groceries.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        CategorySectionView(categories: viewModel.categories)
                        
                        ProductGridView(title: nil, products: viewModel.products)
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
