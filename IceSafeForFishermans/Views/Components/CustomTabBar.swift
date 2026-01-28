import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    private let tabs: [(icon: AppIcon, label: String)] = [
        (.calculator, "Calculate"),
        (.reference, "Reference"),
        (.safety, "Safety"),
        (.log, "Log"),
        (.formation, "Formation")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                TabBarButton(
                    icon: tab.icon,
                    label: tab.label,
                    isSelected: selectedTab == index
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = index
                    }
                }
            }
        }
        .padding(.horizontal, AppTheme.paddingSmall)
        .padding(.top, AppTheme.paddingSmall)
        .padding(.bottom, 20)
        .background(
            AppTheme.cardBackground
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

struct TabBarButton: View {
    let icon: AppIcon
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: AppTheme.cornerRadiusSmall)
                            .fill(AppTheme.primary.opacity(0.2))
                            .frame(width: 50, height: 32)
                    }
                    
                    IconView(
                        icon: icon,
                        size: 22,
                        colour: isSelected ? AppTheme.primary : AppTheme.textMuted
                    )
                    .stroke(style: StrokeStyle(lineWidth: isSelected ? 2.5 : 2, lineCap: .round, lineJoin: .round))
                }
                
                Text(label)
                    .font(.system(size: 10, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? AppTheme.primary : AppTheme.textMuted)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selected = 0
        
        var body: some View {
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selected)
            }
            .background(AppTheme.background)
        }
    }
    
    return PreviewWrapper()
}
