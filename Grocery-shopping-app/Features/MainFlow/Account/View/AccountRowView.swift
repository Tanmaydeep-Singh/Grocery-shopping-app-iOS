import SwiftUI

struct AccountRowView: View {

    let item: AccountMenuItem

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: item.icon)
                .frame(width: 24)

            Text(item.title)
                .font(.body)
//                .fontWeight(.semibold)

            Spacer()
//            Divider()

            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
        .padding(.vertical, 8)
    
    }
}

#Preview {
    AccountView(selectedTab: .constant(.home))   
}
