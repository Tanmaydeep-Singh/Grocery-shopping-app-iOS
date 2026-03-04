import SwiftUI

struct CategorySectionView: View {

    let categories: [Category]
    let selectedCategory: Category?
    let onCategorySelected: (Category) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories) { category in
                    CategoryChipView(category: category, isSelected: selectedCategory?.id == category.id){
                        onCategorySelected(category)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

