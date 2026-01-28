import SwiftUI

struct SafetyGuideView: View {
    @State private var expandedSection: String?
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.paddingLarge) {
                // Header
                header
                
                // How to Measure Ice
                accordionSection(
                    title: "How to Measure Ice",
                    icon: .auger,
                    content: measureIceContent
                )
                
                // Dangerous Ice Signs
                accordionSection(
                    title: "Signs of Dangerous Ice",
                    icon: .statusDanger,
                    content: dangerSignsContent
                )
                
                // What to Do If You Fall Through
                emergencySection
                
                // Safety Equipment
                accordionSection(
                    title: "Recommended Safety Equipment",
                    icon: .gear,
                    content: equipmentContent
                )
                
                // Emergency contacts reminder
                CardView {
                    HStack(spacing: 12) {
                        IconView(icon: .info, size: 24, colour: AppTheme.primary)
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Emergency Services")
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Save local emergency numbers before heading out. Mobile signal may be limited on frozen lakes.")
                                .font(.caption)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    }
                }
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, AppTheme.paddingMedium)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Safety")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                Text("Guide")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.primary)
            }
            Spacer()
            IconView(icon: .safety, size: 40, colour: AppTheme.primary)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .padding(.top, AppTheme.paddingMedium)
    }
    
    private func accordionSection(title: String, icon: AppIcon, content: () -> AnyView) -> some View {
        CardView(padding: 0) {
            VStack(spacing: 0) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if expandedSection == title {
                            expandedSection = nil
                        } else {
                            expandedSection = title
                        }
                    }
                }) {
                    HStack(spacing: 12) {
                        IconView(icon: icon, size: 24, colour: AppTheme.primary)
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        
                        Text(title)
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: expandedSection == title ? "chevron.up" : "chevron.down")
                            .foregroundColor(AppTheme.textMuted)
                    }
                    .padding(AppTheme.paddingMedium)
                }
                .buttonStyle(PlainButtonStyle())
                
                if expandedSection == title {
                    Divider().background(AppTheme.cardBackgroundLight)
                    content()
                        .padding(AppTheme.paddingMedium)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
    }
    
    private var measureIceContent: () -> AnyView {
        return {
            AnyView(
                VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                    guideStep(number: 1, title: "Use Proper Tools", description: "Use an ice auger, ice chisel, or cordless drill with an ice bit. Never rely on visual inspection alone.")
                    
                    guideStep(number: 2, title: "Check Multiple Locations", description: "Ice thickness varies across a body of water. Check every 50 metres and especially near shore, pressure ridges, and where water flows in or out.")
                    
                    guideStep(number: 3, title: "Measure Correctly", description: "Drill completely through the ice. Use a tape measure or marked stick to measure from the bottom of the ice to the top surface.")
                    
                    guideStep(number: 4, title: "Note Ice Quality", description: "Record whether ice is clear blue (strongest), white/opaque (weaker), or grey (unsafe). Only clear ice should be used for thickness guidelines.")
                    
                    guideStep(number: 5, title: "Repeat Often", description: "Conditions change daily. Check ice thickness at the start of each trip and periodically throughout your time on the ice.")
                }
            )
        }
    }
    
    private var dangerSignsContent: () -> AnyView {
        return {
            AnyView(
                VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                    dangerItem(title: "Grey or Dark Ice", description: "Indicates water saturation. Extremely weak and unpredictable. Never walk on grey ice.")
                    
                    dangerItem(title: "Cracking Sounds", description: "Loud cracking, popping, or booming sounds indicate stress. Move carefully and spread your weight.")
                    
                    dangerItem(title: "Water on Surface", description: "Standing water, slush, or wet spots suggest the ice is melting or compromised from below.")
                    
                    dangerItem(title: "Snow Drifts", description: "Deep snow acts as insulation preventing proper freezing. Ice under snow is often thinner and weaker.")
                    
                    dangerItem(title: "Pressure Ridges", description: "Areas where ice sheets have collided and buckled. These create weak points and uneven thickness.")
                    
                    dangerItem(title: "Open Water Nearby", description: "Ice near open water, inlets, outlets, or springs is typically much thinner and weaker.")
                }
            )
        }
    }
    
    private var emergencySection: some View {
        GradientCardView(gradient: AppTheme.dangerGradient) {
            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                HStack {
                    IconView(icon: .statusDanger, size: 28, colour: .white)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    Text("If You Fall Through Ice")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    emergencyStep(number: 1, text: "Stay calm. You have 1-3 minutes before cold shock passes.")
                    emergencyStep(number: 2, text: "Turn towards the direction you came from - that ice held you.")
                    emergencyStep(number: 3, text: "Extend arms onto the ice. Kick your legs to propel forward.")
                    emergencyStep(number: 4, text: "Use ice picks if available. Dig in and pull yourself out.")
                    emergencyStep(number: 5, text: "Roll away from the hole - don't stand up immediately.")
                    emergencyStep(number: 6, text: "Get to shelter immediately. Remove wet clothes. Seek medical help.")
                }
                
                Divider().background(Color.white.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("To Help Someone Else:")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                    
                    Text("Never walk to the edge of the hole. Lie flat and crawl. Extend a rope, pole, ladder, or clothing to reach them. Pull them to safety while staying low.")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                }
            }
        }
    }
    
    private var equipmentContent: () -> AnyView {
        return {
            AnyView(
                VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                    equipmentItem(title: "Ice Picks / Claws", description: "Worn around neck on a cord. Essential for pulling yourself out of the water by gripping the ice.")
                    
                    equipmentItem(title: "Flotation Suit or Device", description: "Provides buoyancy if you fall through. Also helps with hypothermia by keeping you afloat.")
                    
                    equipmentItem(title: "Throw Rope", description: "15-25 metres of floating rope to throw to someone in trouble. Never approach the hole directly.")
                    
                    equipmentItem(title: "Ice Spud / Chisel", description: "Test ice ahead of you as you walk. Hit the ice firmly - if it chips or cracks easily, turn back.")
                    
                    equipmentItem(title: "Whistle", description: "Sound carries well over ice. Use to signal for help if in trouble.")
                    
                    equipmentItem(title: "Change of Clothes", description: "Keep dry clothes in a waterproof bag in your vehicle or shelter.")
                }
            )
        }
    }
    
    private func guideStep(number: Int, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(AppTheme.primary)
                    .frame(width: 28, height: 28)
                Text("\(number)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(AppTheme.textPrimary)
                Text(description)
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
    
    private func dangerItem(title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(AppTheme.danger)
                .frame(width: 10, height: 10)
                .offset(y: 4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(AppTheme.danger)
                Text(description)
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
    
    private func emergencyStep(number: Int, text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(number).")
                .font(.subheadline.weight(.bold))
                .foregroundColor(.white)
                .frame(width: 20)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.95))
        }
    }
    
    private func equipmentItem(title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            IconView(icon: .check, size: 16, colour: AppTheme.safe)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .offset(y: 2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(AppTheme.textPrimary)
                Text(description)
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
}

#Preview {
    SafetyGuideView()
}
