//
//  MapViewController.swift
//  PocketBank
//
//  Created by Евгений on 27.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            
            mapView.delegate = self
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            
        }
    }
    
    var officeService = OfficeService()
    var icon = UIImage(named: "mapPin")
    
}

extension MapViewController {
    func setMarkers(_ markers: [GMSMarker]?) {
        mapView.clear()
        if let m = markers {
            for mapMarker in m {
                mapMarker.icon = icon
                mapMarker.map = mapView
            }
        }
    }
}

extension MapViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let moscowRegion = CLLocationCoordinate2D(latitude: 55.755873 , longitude: 37.617578)
        let zoom: Float = 10
        self.bouds(to: moscowRegion, zoom: zoom)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        if mapView.selectedMarker == nil {
            
            let vr = mapView.projection.visibleRegion()
            let reg = GMSCoordinateBounds(region: vr)
            let boundingBox = BoundingBox(northeast: reg.northEast, southwest: reg.southWest)
            
            self.fetch(with: boundingBox)
        }
    }
    
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        
        if let location = mapView.myLocation {
            
            self.bouds(to: location.coordinate, zoom: 15)
        }
        
        return true
    }
}

extension MapViewController {
 
    func fetch(with box: BoundingBox) {
        
        officeService.fetch(with: box, completion: { [weak self] (response) in
            do {
                
                let offices = try response()
                
                let markers = offices!.map({ office -> GMSMarker in
                    let marker =  GMSMarker(position: office.coordinate!)
                    marker.snippet = office.infoText
                    return marker
                    
                })
                
                self?.setMarkers(markers)
                
            } catch {
                
                print("Error")
                
            }
        })
    }
    
    func bouds(to coordinate: CLLocationCoordinate2D, zoom: Float) {
        
        let position = GMSCameraPosition(target: coordinate, zoom: zoom, bearing: 0, viewingAngle: 0)
        mapView.animate(to: position)
        
    }
    
}
