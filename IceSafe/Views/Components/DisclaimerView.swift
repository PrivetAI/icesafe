import SwiftUI

struct DisclaimerView: View {
    @Binding var hasAccepted: Bool
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AppTheme.paddingLarge) {
                    Spacer(minLength: 40)
                    
                    // Logo/Icon
                    ZStack {
                        Circle()
                            .fill(AppTheme.iceGradient)
                            .frame(width: 100, height: 100)
                        
                        IconView(icon: .formation, size: 50, colour: .white)
                            .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    }
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1 : 0.5)
                    
                    // Title
                    VStack(spacing: 8) {
                        Text("Ice Safety")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("for Fishermans")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(AppTheme.primary)
                        
                        Text("Ice Thickness Calculator")
                            .font(.system(size: 16))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                    
                    // Disclaimer content
                    CardView {
                        VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                            HStack {
                                IconView(icon: .warning, size: 24, colour: AppTheme.warning)
                                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                Text("Important Safety Information")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.warning)
                            }
                            
                            disclaimerText("This application provides general educational information about ice safety. It is not a substitute for professional assessment or local expert advice.")
                            
                            disclaimerText("Ice conditions vary significantly based on location, weather history, water currents, and many other factors that this app cannot measure.")
                            
                            disclaimerText("You are solely responsible for your own safety when venturing onto ice. Always exercise caution and good judgement.")
                            
                            disclaimerText("Never rely solely on this app to make safety decisions. When in doubt, stay off the ice.")
                            
                            disclaimerText("By using this app, you acknowledge that you understand these limitations and accept full responsibility for your safety decisions.")
                        }
                    }
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 30)
                    
                    // Accept button
                    Button(action: acceptDisclaimer) {
                        HStack {
                            IconView(icon: .check, size: 20, colour: .white)
                                .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            Text("I Understand and Accept")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, AppTheme.paddingMedium)
                        .background(AppTheme.iceGradient)
                        .cornerRadius(AppTheme.cornerRadiusMedium)
                    }
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 40)
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, AppTheme.paddingLarge)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6).delay(0.2)) {
                showContent = true
            }
        }
    }
    
    private func disclaimerText(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(AppTheme.textMuted)
                .frame(width: 6, height: 6)
                .offset(y: 6)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func acceptDisclaimer() {
        UserDefaults.standard.set(true, forKey: "hasAcceptedDisclaimer")
        withAnimation(.easeInOut(duration: 0.3)) {
            hasAccepted = true
        }
    }
}

#Preview {
    DisclaimerView(hasAccepted: .constant(false))
}
