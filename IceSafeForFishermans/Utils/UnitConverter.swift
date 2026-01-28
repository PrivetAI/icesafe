import Foundation

struct UnitConverter {
    static func cmToInches(_ cm: Double) -> Double {
        return cm / 2.54
    }
    
    static func inchesToCm(_ inches: Double) -> Double {
        return inches * 2.54
    }
    
    static func kgToLbs(_ kg: Double) -> Double {
        return kg * 2.20462
    }
    
    static func lbsToKg(_ lbs: Double) -> Double {
        return lbs / 2.20462
    }
    
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }
    
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
    
    static func formatThickness(_ cm: Double, useInches: Bool) -> String {
        if useInches {
            let inches = cmToInches(cm)
            return String(format: "%.1f\"", inches)
        } else {
            return String(format: "%.1f cm", cm)
        }
    }
    
    static func formatWeight(_ kg: Double, useLbs: Bool) -> String {
        if useLbs {
            let lbs = kgToLbs(kg)
            return String(format: "%.0f lbs", lbs)
        } else {
            return String(format: "%.0f kg", kg)
        }
    }
    
    static func formatTemperature(_ celsius: Double, useFahrenheit: Bool) -> String {
        if useFahrenheit {
            let fahrenheit = celsiusToFahrenheit(celsius)
            return String(format: "%.0f°F", fahrenheit)
        } else {
            return String(format: "%.0f°C", celsius)
        }
    }
}
