//
//  UserGuidance.swift
//  iBurn
//
//  Created by Chris Ballinger on 6/16/17.
//  Copyright © 2017 Burning Man Earth. All rights reserved.
//

import Foundation

class UserGuidance {
    
    struct DistanceEntry {
        let point: BRCMapPoint
        let distance: CLLocationDistance
    }
    
    static func findNearest(userLocation: CLLocation,
                            mapPointType: BRCMapPointType,
                            transaction: YapDatabaseReadTransaction) -> BRCMapPoint? {
        let yapCollection = BRCMapPoint.yapCollection(for: mapPointType)
        var distances: [DistanceEntry] = []
        transaction.iterateKeysAndObjects(inCollection: yapCollection) { (key, point: BRCMapPoint, stop) in
            guard point.type == mapPointType,
                let location = point.location() else { return }
            let distance = userLocation.distance(from: location)
            let entry = DistanceEntry(point: point, distance: distance)
            distances.append(entry)
        }
        distances.sort { $0.distance > $1.distance }
        return distances.first?.point
    }
}
