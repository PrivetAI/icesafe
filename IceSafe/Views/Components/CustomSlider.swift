import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    var thumbColour: Color = AppTheme.primary
    var trackColour: Color = AppTheme.cardBackgroundLight
    var activeTrackColour: Color = AppTheme.primary
    
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height: CGFloat = 8
            let thumbSize: CGFloat = 28
            
            let percent = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
            let thumbX = percent * (width - thumbSize)
            
            ZStack(alignment: .leading) {
                // Track background
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(trackColour)
                    .frame(height: height)
                
                // Active track
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(activeTrackColour)
                    .frame(width: thumbX + thumbSize / 2, height: height)
                
                // Thumb
                Circle()
                    .fill(thumbColour)
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(color: thumbColour.opacity(0.4), radius: isDragging ? 8 : 4)
                    .scaleEffect(isDragging ? 1.1 : 1.0)
                    .offset(x: thumbX)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                isDragging = true
                                let newPercent = gesture.location.x / width
                                let clampedPercent = min(max(newPercent, 0), 1)
                                let newValue = range.lowerBound + clampedPercent * (range.upperBound - range.lowerBound)
                                let steppedValue = round(newValue / step) * step
                                value = min(max(steppedValue, range.lowerBound), range.upperBound)
                            }
                            .onEnded { _ in
                                isDragging = false
                            }
                    )
            }
            .frame(height: thumbSize)
        }
        .frame(height: 28)
        .animation(.easeOut(duration: 0.15), value: isDragging)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var value: Double = 10
        
        var body: some View {
            VStack(spacing: 30) {
                CustomSlider(value: $value, range: 0...50, step: 1)
                Text("Value: \(Int(value))")
                    .foregroundColor(.white)
            }
            .padding()
            .background(AppTheme.background)
        }
    }
    
    return PreviewWrapper()
}
