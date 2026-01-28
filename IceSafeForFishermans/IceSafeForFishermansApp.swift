import SwiftUI

@main
struct IceSafeForFishermansApp: App {
    @State private var hasAcceptedDisclaimer = UserDefaults.standard.bool(forKey: "hasAcceptedDisclaimer")
    
    var body: some Scene {
        WindowGroup {
            if hasAcceptedDisclaimer {
                ContentView()
                    .preferredColorScheme(.dark)
            } else {
                DisclaimerView(hasAccepted: $hasAcceptedDisclaimer)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
