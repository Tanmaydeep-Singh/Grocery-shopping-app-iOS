import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Container@*/VStack/*@END_MENU_TOKEN@*/ {
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
                            
                            CategorySectionView(
                                categories: viewModel.categories
                            ) { category in
                                Task {
                                    // Convert UI Category → ProductCategory
                                    if let productCategory = ProductCategory.allCases.first(
                                        where: { $0.title == category.title }
                                    ) {
                                        await viewModel.fetchProducts(category: productCategory)
                                    }
                                }
                            }
                            
                            ProductGridView(title: nil, products: viewModel.categoryProducts.isEmpty ? viewModel.products : viewModel.categoryProducts)
                        }
                    }
                }
                .task {
                    await viewModel.fetchProducts()
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
