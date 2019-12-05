//
//  MKPointAnnotation_ObservableObject.swift
//  BucketList
//
//  Created by Németh Gergely on 2019. 12. 03..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
