import SwiftUI


// Category Selector Component
struct CategorySelectorView: View {
    @Binding var selectedCategory: DrinkCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(DrinkCategory.allCases, id: \.self) { category in
                    Button(action: {
                        withAnimation {
                            selectedCategory = category
                        }
                    }) {
                        Text(category.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedCategory == category ? Color.brown : Color(.systemGray6))
                            )
                            .foregroundColor(selectedCategory == category ? .white : .gray)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
