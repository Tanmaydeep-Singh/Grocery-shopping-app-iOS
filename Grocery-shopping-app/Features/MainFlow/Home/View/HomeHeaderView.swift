import SwiftUI

struct HomeHeaderView: View {
    @StateObject private var locationManager = LocationManager()
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
                
                Text(locationManager.locationName)
                    .font(.title2)
                    .foregroundColor(.black.opacity(0.7))
                }
            }
        .onAppear{
            locationManager.checkPermissionAndRequest()
        }
    }
}

#Preview {
    HomeHeaderView()
}
