import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    var padding: CGFloat = AppTheme.paddingMedium
    
    init(padding: CGFloat = AppTheme.paddingMedium, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.padding = padding
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(AppTheme.cardBackground)
            .cornerRadius(AppTheme.cornerRadiusMedium)
    }
}

struct GradientCardView<Content: View>: View {
    let gradient: LinearGradient
    let content: Content
    
    init(gradient: LinearGradient, @ViewBuilder content: () -> Content) {
        self.gradient = gradient
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(AppTheme.paddingMedium)
            .background(gradient)
            .cornerRadius(AppTheme.cornerRadiusMedium)
    }
}

#Preview {
    VStack {
        CardView {
            Text("Test Card")
                .foregroundColor(.white)
        }
        
        GradientCardView(gradient: AppTheme.iceGradient) {
            Text("Gradient Card")
                .foregroundColor(.white)
        }
    }
    .padding()
    .background(AppTheme.background)
}
