import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                CalculatorView()
                    .tag(0)
                
                ReferenceTableView()
                    .tag(1)
                
                SafetyGuideView()
                    .tag(2)
                
                MeasurementLogView()
                    .tag(3)
                
                IceFormationView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .background(AppTheme.background)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView()
}
