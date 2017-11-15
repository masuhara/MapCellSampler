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

    var routes: [Route]
    var title: String?
    var detail: String?
    var images: [UIImage?]?
    
    init(routes: [Route]) {
        self.routes = routes
    }
    
}
