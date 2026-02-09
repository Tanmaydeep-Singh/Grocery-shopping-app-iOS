import SwiftUI

struct CategorySectionView: View {

    let categories: [Category]
    let onCategorySelected: (Category) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories) { category in
                    CategoryChipView(category: category){
                        onCategorySelected(category)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

