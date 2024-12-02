//
//  LocalWeatherPoint+CoreDataProperties.swift
//  my-weather
//
//  Created by Romain Roche on 02/12/2024.
//
//

import Foundation
import CoreData


extension LocalWeatherPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalWeatherPoint> {
        return NSFetchRequest<LocalWeatherPoint>(entityName: "LocalWeatherPoint")
    }

    @NSManaged public var date: Date
    @NSManaged public var temperature: Double
    @NSManaged public var precipitation: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var weatherCode: Int16
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension LocalWeatherPoint : Identifiable {

}
