import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("CarrotOrange")
                .resizable()
                .scaledToFit()
                .frame(width: 40)

            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("location_name")
                    .font(.title2)
                    .foregroundColor(.black.opacity(0.7))
                }
            }
    }
}

#Preview {
    HomeHeaderView()
}
