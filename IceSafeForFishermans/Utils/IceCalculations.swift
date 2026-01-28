import Foundation

struct IceCalculations {
    // Minimum thickness requirements in cm for clear ice
    // These are standard safety guidelines
    static let thicknessForOnePerson: Double = 5.0      // 2 inches
    static let thicknessForGroup: Double = 7.5          // 3 inches
    static let thicknessForLightGear: Double = 10.0     // 4 inches
    static let thicknessForSnowmobile: Double = 15.0    // 6 inches
    static let thicknessForCar: Double = 25.0           // 10 inches
    static let thicknessForTruck: Double = 35.0         // 14 inches
    
    // Average person weight in kg
    static let averagePersonWeight: Double = 80.0
    
    /// Calculate required ice thickness for given load
    /// Formula: thickness (inches) = sqrt(load in lbs / 50) * 2
    /// Converted to metric: thickness (cm) = sqrt(load in kg / 22.7) * 5.08
    static func requiredThickness(for loadKg: Double, iceType: IceType) -> Double {
        let baseThickness = sqrt(loadKg / 22.7) * 5.08
        // Adjust for ice type - weaker ice needs more thickness
        return baseThickness / iceType.strengthMultiplier
    }
    
    /// Calculate maximum safe load for given ice thickness
    /// Inverse of the above formula
    static func maxLoad(thickness: Double, iceType: IceType) -> Double {
        let effectiveThickness = thickness * iceType.strengthMultiplier
        let loadKg = pow(effectiveThickness / 5.08, 2) * 22.7
        return max(0, loadKg)
    }
    
    /// Calculate safety result based on inputs
    static func calculateSafety(
        thicknessCm: Double,
        iceType: IceType,
        peopleCount: Int,
        equipmentWeight: Double
    ) -> SafetyResult {
        // Calculate total load
        let peopleWeight = Double(peopleCount) * averagePersonWeight
        let totalLoad = peopleWeight + equipmentWeight
        
        // Calculate required thickness
        let requiredThickness = Self.requiredThickness(for: totalLoad, iceType: iceType)
        
        // Calculate max load at current thickness
        let maxLoadAtThickness = Self.maxLoad(thickness: thicknessCm, iceType: iceType)
        
        // Determine safety level
        let safetyRatio = thicknessCm / requiredThickness
        
        var level: SafetyLevel
        var warnings: [String] = []
        var recommendations: [String] = []
        
        if iceType == .grey {
            level = .danger
            warnings.append("Grey ice is extremely dangerous and unpredictable")
            recommendations.append("Do not walk on grey ice under any circumstances")
        } else if safetyRatio < 0.8 {
            level = .danger
            warnings.append("Ice is too thin for your planned activity")
            recommendations.append("Wait for ice to thicken or reduce load significantly")
        } else if safetyRatio < 1.2 {
            level = .warning
            warnings.append("Ice thickness is marginal for safety")
            recommendations.append("Proceed with extreme caution")
            recommendations.append("Stay close to shore and have rescue equipment ready")
        } else {
            level = .safe
            recommendations.append("Ice appears adequate for your planned activity")
            recommendations.append("Always test ice regularly as you move")
        }
        
        // Add type-specific warnings
        if iceType == .white && level != .danger {
            warnings.append("White ice is about 50% weaker than clear ice")
        }
        
        // Add general recommendations
        if thicknessCm < 10 {
            recommendations.append("Consider using ice picks and a flotation device")
        }
        
        if peopleCount > 3 {
            recommendations.append("Spread out group at least 3 metres apart")
        }
        
        return SafetyResult(
            level: level,
            currentThickness: thicknessCm,
            recommendedThickness: requiredThickness,
            maxLoad: maxLoadAtThickness,
            warnings: warnings,
            recommendations: recommendations
        )
    }
    
    /// Calculate ice growth based on freezing degree days
    /// Stefan's Law: H = α * √(FDD)
    /// Where H is ice thickness, α is coefficient (~2.7 for snow-free, ~1.8 with snow)
    static func calculateIceGrowth(
        averageTemp: Double, // Celsius
        days: Int,
        hasSnowCover: Bool
    ) -> Double {
        // Only counts when temp is below freezing
        guard averageTemp < 0 else { return 0 }
        
        // Freezing degree days (using 0°C as base)
        let fdd = abs(averageTemp) * Double(days)
        
        // Coefficient depends on snow cover
        let alpha: Double = hasSnowCover ? 1.8 : 2.7
        
        // Ice thickness in cm
        let thickness = alpha * sqrt(fdd)
        
        return thickness
    }
    
    /// Calculate days needed to reach target thickness
    static func daysToReachThickness(
        targetCm: Double,
        averageTemp: Double,
        hasSnowCover: Bool
    ) -> Int {
        guard averageTemp < 0, targetCm > 0 else { return 0 }
        
        let alpha: Double = hasSnowCover ? 1.8 : 2.7
        
        // H = α * √(FDD) => FDD = (H/α)²
        let fdd = pow(targetCm / alpha, 2)
        
        // FDD = |temp| * days => days = FDD / |temp|
        let days = fdd / abs(averageTemp)
        
        return Int(ceil(days))
    }
}
