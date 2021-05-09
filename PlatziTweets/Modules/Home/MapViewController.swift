//
//  MapViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 9/05/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapContainer: UIView!
    
    var posts = [Post]()
    private var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMap()
    }
    
    private func setupMap() {
        map = MKMapView(frame: mapContainer.bounds)
        mapContainer.addSubview(map ?? UIView())
        
        setupMarkers()
    }
    
    private func setupMarkers() {
        posts.forEach { item in
            let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
            
            marker.title = item.text
            marker.subtitle = item.author.names
            
            map?.addAnnotation(marker)
            
        }
        
        guard let lastPost = posts.first else {
            return
        }
        
        let lastPostLocation = CLLocationCoordinate2D(latitude: lastPost.location.latitude,
                                                      longitude: lastPost.location.longitude)
        
        guard let heading = CLLocationDirection(exactly: 12) else {
            return
        }
        
        map?.camera = MKMapCamera(lookingAtCenter: lastPostLocation, fromDistance: 30, pitch: .zero, heading: heading)
        
        
    }
    

}
