import SwiftUI

struct UnifiedSearchBar: View {
    @Binding var text: String
    var placeholderItems: [String] = [
                "Search for categories...",
                "Search for dairy...",
                "Search for bakery...",
                "Search for coffee...",
                "Search for candy...",
                "Search for fresh produce...",
                "Search for meat & seafood...",
            ]
    var onSubmit: (() -> Void)? = nil
    var onFiltersApplied: ((Set<String>, Set<String>) -> Void)? = nil

    @FocusState private var isFocused: Bool
    @State private var showFilter: Bool = false
    @State private var currentPlaceholderIndex: Int = 0
    @State private var displayedPlaceholder: String = ""
    @State private var placeholderTimer: Timer? = nil

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("SearchIcon"))

            ZStack(alignment: .leading) {
                if text.isEmpty && !isFocused {
                    Text(displayedPlaceholder)
                        .foregroundColor(Color("SearchIcon").opacity(0.6))
                        .font(.system(size: 16))
                        .transition(.asymmetric(
                            insertion: .offset(y: 40).combined(with: .opacity),
                            removal: .offset(y: -40).combined(with: .opacity)
                        ))
                        .id(currentPlaceholderIndex)
                        .allowsHitTesting(false)
                }

                TextField("", text: $text)
                    .focused($isFocused)
                    .foregroundColor(Color("SearchText"))
                    .font(.system(size: 16))
                    .submitLabel(.search)
                    .autocorrectionDisabled()
                    .onSubmit {
                        onSubmit?()
                    }
            }

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("SearchIcon"))
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.1), value: text.isEmpty)
            }

            if onFiltersApplied != nil {
                Button {
                    isFocused = false
                    showFilter = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color("SearchIcon"))
                }
            }
        }
        .padding(16)
        .frame(height: 52)
        .background(Color("SearchBackground"))
        .cornerRadius(16)
        .fullScreenCover(isPresented: $showFilter) {
            if let onFiltersApplied {
                FilterView { categories, brands in
                    onFiltersApplied(categories, brands)
                }
            }
        }
        .onAppear {
            displayedPlaceholder = placeholderItems.first ?? ""
            startPlaceholderCycle()
        }
        .onDisappear {
            stopPlaceholderCycle()
        }
    }

    private func startPlaceholderCycle() {
        stopPlaceholderCycle()
        placeholderTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            guard !isFocused, text.isEmpty else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                currentPlaceholderIndex = (currentPlaceholderIndex + 1) % placeholderItems.count
                displayedPlaceholder = placeholderItems[currentPlaceholderIndex]
            }
        }
    }

    private func stopPlaceholderCycle() {
        placeholderTimer?.invalidate()
        placeholderTimer = nil
    }
}

#Preview("Without filter") {
    UnifiedSearchBar(text: .constant(""))
        .padding()
}

#Preview("With filter") {
    UnifiedSearchBar(text: .constant("")) { categories, brands in
        print(categories, brands)
    }
    .padding()
}
