//
//  SampleModel.swift
//  MapCellSampler
//
//  Created by Masuhara on 2017/11/15.
//  Copyright © 2017年 Ylab, Inc. All rights reserved.
//

import UIKit
import GoogleMaps

class SampleModel {

    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var title: String?
    var detail: String?
    var image: UIImage?
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
