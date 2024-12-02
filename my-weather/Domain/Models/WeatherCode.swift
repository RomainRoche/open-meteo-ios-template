//
//  WeatherCode.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

/// The type of weather.
public enum WeatherCode: Int {
    case clear = 0
    
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3
    
    case fog = 45
    case depositingRimFog = 46
    
    case drizzleLight = 51
    case drizzleModerate = 53
    case drizzleDense = 55
    
    case freezingDrizzleLight = 56
    case freezingDrizzleDense = 57
    
    case rainSlight = 61
    case rainModerate = 63
    case rainHeavy = 65
    
    case freezingRainLight = 66
    case freezingRainHeavy = 67
    
    case snowFallSlight = 71
    case snowFallModerate = 73
    case snowFallHeavy = 75
    
    case snowGrains = 77
    
    case rainShowersSlight = 80
    case rainShowersModerate = 81
    case rainShowersViolent = 82
    
    case snowShowersSlight = 85
    case snowShowersHeavy = 86
    
    case thunderstorm = 95
    
    case thunderstormWithHail = 96
    case thunderstormWithHeavyHail = 99
    
    case unknown = -1
}
