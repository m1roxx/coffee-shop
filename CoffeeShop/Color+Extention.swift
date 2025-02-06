import SwiftUI

extension Color {
    static let primaryGreen = Color(hex: "006400")  // Основной темно-зеленый
    static let accentGreen = Color(hex: "228B22")   // Акцентный зеленый
    static let lightGreen = Color(hex: "90EE90")    // Светлый зеленый для текста
    static let darkGreen = Color(hex: "004225")     // Очень темный зеленый для фона
    static let customDarkGreen = Color(hex: "004D40") 
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
