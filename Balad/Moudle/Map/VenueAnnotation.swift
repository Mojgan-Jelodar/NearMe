//
//  VenueAnnotation.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import CoreLocation
import MapKit

class VenueAnnotation: NSObject, MKAnnotation {
    private(set) var item: Items!

    required init(item: Items) {
        self.item = item
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(self.item?.venue?.location?.lat ?? 0.0),
                                          CLLocationDegrees(self.item?.venue?.location?.lng ?? 0.0))
    }

    var title: String? {
        return self.item?.venue?.name
    }

    var subtitle: String? {
        return self.item?.venue?.location?.formattedAddress.joined(separator: "-")
    }
}
