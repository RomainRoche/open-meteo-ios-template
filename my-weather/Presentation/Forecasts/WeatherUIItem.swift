//
//  WeatherUIItem.swift
//  my-weather
//
//  Created by Romain Roche on 25/11/2024.
//

import Foundation

struct WeatherUIItem {
    let icon: String
    let date: String
    let title: String
}

extension WeatherCode {
    
    var emoji: String {
        switch self {
        case .clear:                        return "☀️"
            
        case .mainlyClear:                  return "🌤️"
        case .partlyCloudy:                 return "⛅️"
        case .overcast:                     return "☁️"
            
        case .fog:                          return "🌫️"
        case .depositingRimFog:             return "🌧️"
        
        case .drizzleLight:                 return "🌧️"
        case .drizzleModerate:              return "🌧️"
        case .drizzleDense:                 return "🌧️"
            
        case .freezingDrizzleLight:         return "🌧️"
        case .freezingDrizzleDense:         return "🌧️"
            
        case .rainSlight:                   return "🌧️"
        case .rainModerate:                 return "🌧️"
        case .rainHeavy:                    return "🌧️"
            
        case .freezingRainLight:            return "🌨️"
        case .freezingRainHeavy:            return "🌨️"
            
        case .snowFallSlight:               return "❄️"
        case .snowFallModerate:             return "❄️"
        case .snowFallHeavy:                return "❄️"
        case .snowShowersSlight:            return "❄️"
        case .snowShowersHeavy:             return "❄️"
            
        case .snowGrains:                   return "❄️"
            
        case .rainShowersSlight:            return "🌧️"
        case .rainShowersModerate:          return "🌧️"
        case .rainShowersViolent:           return "🌧️"
            
        case .thunderstorm:                 return "🌩️"
        case .thunderstormWithHail:         return "🌩️"
        case .thunderstormWithHeavyHail:    return "🌩️"
        }
    }
    
    var title: String {
        switch self {
        case .clear:                        return "Sunny"
        
        case .mainlyClear:                  return "Mainly Clear"
        case .partlyCloudy:                 return "Partly Cloudy"
        case .overcast:                     return "Overcast"
            
        case .fog:                          return "Fog"
        case .depositingRimFog:             return "Depositing Fog"
        
        case .drizzleLight:                 return "Light Drizzle"
        case .drizzleModerate:              return "Moderate Drizzle"
        case .drizzleDense:                 return "Dense Drizzle"
            
        case .freezingDrizzleLight:         return "Light Freezing Drizzle"
        case .freezingDrizzleDense:         return "Dense Freezing Drizzle"
            
        case .rainSlight:                   return "Slight Rain"
        case .rainModerate:                 return "Moderate Rain"
        case .rainHeavy:                    return "Heavy Rain"
            
        case .freezingRainLight:            return "Light Freezing Rain"
        case .freezingRainHeavy:            return "Heavy Freezing Rain"
            
        case .snowFallSlight:               return "Slight Snow Fall"
        case .snowFallModerate:             return "Moderate Snow Fall"
        case .snowFallHeavy:                return "Heavy Snow Fall"
        case .snowShowersSlight:            return "Slight Snow Showers"
        case .snowShowersHeavy:             return "Heavy Snow Showers"
            
        case .snowGrains:                   return "Snow Grains"
            
        case .rainShowersSlight:            return "Slight Rain Shower"
        case .rainShowersModerate:          return "Moderate Rain Shower"
        case .rainShowersViolent:           return "Violent Rain Shower"
            
        case .thunderstorm:                 return "Thunderstorm"
        case .thunderstormWithHail:         return "Thunderstorm With Hail"
        case .thunderstormWithHeavyHail:    return "Thunderstorm With Heavy Hail"
        }
    }
    
}
