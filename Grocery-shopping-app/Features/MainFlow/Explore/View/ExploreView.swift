import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var navigateToResults = false
    @State private var selectedCategories: Set<String> = []
    @State private var selectedBrands: Set<String> = []
    @State private var pendingSearchQuery: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScreenHeader(title: "Find Products")

                UnifiedSearchBar(
                    text: $viewModel.searchText,
                    onSubmit: {
                        selectedCategories = []
                        selectedBrands = []
                        pendingSearchQuery = viewModel.searchText
                        navigateToResults = true
                    },
                    onFiltersApplied: { categories, brands in
                        selectedCategories = categories
                        selectedBrands = brands
                        pendingSearchQuery = ""
                        navigateToResults = true
                    }
                )
                .navigationDestination(isPresented: $navigateToResults) {
                    FilterResultView(
                        selectedCategories: selectedCategories,
                        selectedBrands: selectedBrands,
                        searchQuery: pendingSearchQuery
                    )
                }

                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                        spacing: 16
                    ) {
                        ForEach(viewModel.categories) { category in
                            NavigationLink {
                                CategoryProductsView(category: category)
                            } label: {
                                CategoryCard(
                                    title: category.title,
                                    imageName: category.imageName,
                                    backgroundColor: category.backgroundColor,
                                    borderColor: category.borderColor
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ExploreView()
}
