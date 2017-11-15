//
//  MapTableViewCell.swift
//  MapCellSampler
//
//  Created by Masuhara on 2017/11/15.
//  Copyright © 2017年 Ylab, Inc. All rights reserved.
//

import UIKit
import GoogleMaps

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapView.settings.setAllGesturesEnabled(false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
