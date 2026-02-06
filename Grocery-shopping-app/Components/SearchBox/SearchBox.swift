import SwiftUI

struct SearchBox: View {
    @State private var searchText = ""
    @FocusState private var isFocused: Bool
    @State private var showFilter: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("SearchIcon"))

            TextField("Search Store", text: $searchText)
                .focused($isFocused)
                .foregroundColor(Color("SearchText"))
                .font(.system(size: 16))
                .submitLabel(.search)

            if !searchText.isEmpty {
                SwiftUI.Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("SearchIcon"))
                }
            }

            if isFocused {
                SwiftUI.Button(action: {
                    showFilter.toggle()
                    
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color("SearchIcon"))
                }
            }
        }
        .padding(16)
        .frame(height: 52)
        .background(Color("SearchBackground"))
        .cornerRadius(16)
        .opacity(1)
        .fullScreenCover(isPresented: $showFilter) {
            FilterView()
        }
    }
}
