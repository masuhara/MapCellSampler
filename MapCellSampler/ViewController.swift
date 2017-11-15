//
//  ViewController.swift
//  MapCellSampler
//
//  Created by Masuhara on 2017/11/15.
//  Copyright © 2017年 Ylab, Inc. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, UITableViewDataSource {
    
    var sampleData = [SampleModel]()
    
    @IBOutlet weak var mapTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTableView.dataSource = self
        
        setSampleData()
        
        let nib = UINib(nibName: "MapTableViewCell", bundle: Bundle.main)
        mapTableView.register(nib, forCellReuseIdentifier: "MapCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapTableViewCell
        
        let zoom: Float = 15
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: sampleData[indexPath.row].latitude, longitude: sampleData[indexPath.row].longitude, zoom: zoom)
        
        cell.mapView.camera = camera
        
        let marker: GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(sampleData[indexPath.row].latitude, sampleData[indexPath.row].longitude)
        marker.map = cell.mapView
        
        cell.titleLabel.text = sampleData[indexPath.row].title
        cell.detailLabel.text = sampleData[indexPath.row].detail
        
        return cell
    }
    
    func setSampleData() {
        
        let kanazawa = SampleModel(latitude: 36.5780574, longitude: 136.6486596)
        let hiroshima = SampleModel(latitude: 34.249662, longitude: 132.555242)
        let shibuya = SampleModel(latitude: 35.658034, longitude: 139.701636)
        let sapporo = SampleModel(latitude: 43.062096, longitude: 141.350857)
        
        kanazawa.title = "金沢駅"
        kanazawa.detail = "金沢駅は、石川県金沢市木ノ新保町にある、西日本旅客鉄道・IRいしかわ鉄道の駅。"
        hiroshima.title = "広島駅"
        hiroshima.detail = "広島駅は、広島県広島市南区松原町にある西日本旅客鉄道・広島電鉄の駅。"
        shibuya.title = "渋谷駅"
        shibuya.detail = "渋谷駅は、東京都渋谷区道玄坂一丁目および同二丁目にある、東日本旅客鉄道・京王電鉄・東京急行電鉄・東京地下鉄の駅である。"
        sapporo.title = "札幌駅"
        sapporo.detail = "札幌駅は、北海道札幌市北区北6条西4丁目にある、北海道旅客鉄道函館本線の駅。"
        
        sampleData.append(kanazawa)
        sampleData.append(hiroshima)
        sampleData.append(shibuya)
        sampleData.append(sapporo)
    }
}

