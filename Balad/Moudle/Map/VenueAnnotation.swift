//
//  VenueAnnotation.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import CoreLocation
import MapKit

class VenueAnnotation: NSObject, MKAnnotation {
    private(set) var item: Venue!

    required init(item: Venue) {
        self.item = item
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(item.location?.lat ?? 0.0),
                                          CLLocationDegrees(item?.location?.lng ?? 0.0))
    }

    var title: String? {
        return item.name
    }

    var subtitle: String? {
        return item.location?.formattedAddress.joined(separator: "-")
    }
}
