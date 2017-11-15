//
//  ViewController.swift
//  MapCellSampler
//
//  Created by Masuhara on 2017/11/15.
//  Copyright © 2017年 Ylab, Inc. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sampleData = [SampleModel]()
    
    @IBOutlet weak var mapTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapTableView.estimatedRowHeight = 480
        self.mapTableView.rowHeight = UITableViewAutomaticDimension
        
        mapTableView.dataSource = self
        mapTableView.delegate = self
        
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
        
        // Setup Camera(Zoom)
        let zoom: Float = 13.5
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: sampleData[indexPath.row].routes.first!.latitude, longitude: sampleData[indexPath.row].routes.first!.longitude, zoom: zoom)
        cell.mapView.camera = camera
        
        
        // Line
        let path = GMSMutablePath()
        
        for route in sampleData[indexPath.row].routes {
            // Add Pin
            let marker: GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(route.latitude, route.longitude)
            marker.map = cell.mapView
            
            // Add Route
            path.add(CLLocationCoordinate2D(latitude: route.latitude, longitude: route.longitude))
        }
        
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeColor = UIColor.red
        rectangle.strokeWidth = 4.0
        rectangle.map = cell.mapView
        
        // Other Contents
        cell.titleLabel.text = sampleData[indexPath.row].title
        cell.detailLabel.text = sampleData[indexPath.row].detail
        
        // Images
        let length = cell.imageScrollView.bounds.height
        if let images = sampleData[indexPath.row].images {
            cell.imageScrollViewHeightConstraint.constant = 100
            cell.imageScrollView.alwaysBounceHorizontal = true
            cell.imageScrollView.contentSize = CGSize(width: length * CGFloat(images.count), height: length)
            
            print(cell.imageScrollView.contentSize)
            
            for i in 0..<images.count {
                let imageView = UIImageView(image: images[i])
                imageView.frame = CGRect(x: (CGFloat(i) * length) + CGFloat(8 * i), y: 0, width: length, height: length)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                cell.imageScrollView.addSubview(imageView)
            }
            
            print(cell.imageScrollView)
        } else {
            cell.imageScrollViewHeightConstraint.constant = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setSampleData() {
        let kanazawaRoute1 = Route(latitude: 36.5780574, longitude: 136.6486596) // 金沢駅
        let kanazawaRoute2 = Route(latitude: 36.5627364, longitude: 136.6641657) // 兼六園
        let kanazawaRoute3 = Route(latitude: 36.558945, longitude: 136.652489) // 金沢県立美術館
        let kanazawa = SampleModel(routes: [kanazawaRoute1, kanazawaRoute2, kanazawaRoute3])
        
        let hiroshimaRoute1 = Route(latitude: 34.3969103, longitude: 132.4773154) // 広島駅
        let hiroshimaRoute2 = Route(latitude: 34.391887, longitude: 132.484576) // マツダスタジアム
        let hiroshimaRoute3 = Route(latitude: 34.395483, longitude: 132.453592) // 原爆ドーム
        let hiroshima = SampleModel(routes: [hiroshimaRoute1, hiroshimaRoute2, hiroshimaRoute3])
        
        let shibuyaRoute1 = Route(latitude: 35.6592013, longitude: 139.702227) // 渋谷駅
        let shibuyaRoute2 = Route(latitude: 35.662243, longitude: 139.717093) // 根津美術館
        let shibuyaRoute3 = Route(latitude: 35.642145, longitude: 139.713487) // 恵比寿ガーデンプレイス
        let shibuya = SampleModel(routes: [shibuyaRoute1, shibuyaRoute2, shibuyaRoute3])
        
        let sapporoRoute1 = Route(latitude: 43.0686, longitude: 141.3507) // 札幌駅
        let sapporoRoute2 = Route(latitude: 43.015775, longitude: 141.409529) // 札幌ドーム
        let sapporoRoute3 = Route(latitude: 43.0878885, longitude: 141.2699472) // 白い恋人パーク
        let sapporo = SampleModel(routes: [sapporoRoute1, sapporoRoute2, sapporoRoute3])

        
        kanazawa.title = "金沢で風情溢れる観光スポット"
        kanazawa.detail = "金沢駅から降りて、歴史を感じながらゆったり周る観光コース。年齢問わず金沢を満喫するならこれ！"
        kanazawa.images = [UIImage(named: "kanazawa01.jpg"), UIImage(named: "kanazawa02.jpg"), UIImage(named: "kanazawa03.jpg")]
        
        hiroshima.title = "広島満喫コース"
        hiroshima.detail = "広島駅は、広島県広島市南区松原町にある西日本旅客鉄道・広島電鉄の駅。その周辺で名所を周るコース。"
        
        shibuya.title = "渋谷恵比寿デートコース"
        shibuya.detail = "渋谷駅から降りて、代々木公園で遊んだら、恵比寿ガーデンプレイスでディナーを食べる。"
        shibuya.images = [UIImage(named: "shibuya01.jpg"), UIImage(named: "shibuya02.jpg"), UIImage(named: "shibuya03.png"), UIImage(named: "shibuya04.jpg")]
        
        sapporo.title = "札幌デート決定版！"
        sapporo.detail = "札幌駅から降りて、都会でありつつも北海道の広さ、開放感を感じられるコース。おみやげも買える。"
        
        sampleData.append(kanazawa)
        sampleData.append(hiroshima)
        sampleData.append(shibuya)
        sampleData.append(sapporo)
    }
}

