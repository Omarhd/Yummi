//
//  TrackingViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 18/10/2022.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class TrackingViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var centerMarker: UIImageView!
    @IBOutlet weak var startPointLabel: UILabel!
    
    @IBOutlet weak var endPointLabel: UILabel!
    
    var fpc = FloatingPanelController()
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    let pin = MKPointAnnotation()

    var previousLocation: CLLocation?
    var latitude: Double?
    var longitude: Double?
    
    var selectedLocationDelegate: locationSelectionDelegate?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.backgroundColor = UIColor(named: "BG")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkhLocationServices()

        fpc.delegate = self
        fpc = FloatingPanelController(delegate: self)
        fpc.layout = MyFloatingPanelLayout()

        // content
        guard let placesPanelViewController = storyboard?.instantiateViewController(withIdentifier: "PlacesPanelViewController") as? PlacesPanelViewController else { return }
        fpc.set(contentViewController: placesPanelViewController)
        fpc.title = "Select Location"
        fpc.surfaceView.backgroundColor = .clear
        fpc.contentMode = .static
        fpc.addPanel(toParent: self)
    }
    
    @IBAction func myLocationAction(_ sender: Any) {
        centerViewInUserLocation()
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func checkhLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
        }
    }
    
    fileprivate func startTrackingLocation() {
        showmyLiveLocation()
        centerViewInUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingLocation()
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        }
    }
    
    func showmyLiveLocation() {
        mapView.showsUserLocation = true
    }
    
    func centerViewInUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
        pin.coordinate = location
        pin.title = "موقع المزرعة"
        pin.subtitle = ""
        self.mapView.addAnnotation(pin)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func hideTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        frame!.origin.y = self.view.frame.size.height + (frame?.size.height)!
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }

    func showTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        self.tabBarController?.tabBar.backgroundColor = UIColor(named: "BG")
        frame!.origin.y = self.view.frame.size.height - (frame?.size.height)!
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }
}


extension TrackingViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        self.latitude = previousLocation.coordinate.latitude
        self.longitude = previousLocation.coordinate.longitude
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard self != nil else { return }
            
            if let _ = error {
                
            }
            guard let placemark = placemarks?.first else {
                return
            }
            
            _ = placemark.locality ?? ""
            let region = placemark.country ?? ""
            let street = placemark.subThoroughfare ?? "oops"
            
            DispatchQueue.main.async {
                print(mapView.centerCoordinate)
                self?.startPointLabel.text = region
                self?.endPointLabel.text = street
            }
        }
    }
}

extension TrackingViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

extension TrackingViewController: FloatingPanelControllerDelegate {

    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == .half {
            hideTabBar()
        } else if fpc.state == .full {
            hideTabBar()
        } else {
            showTabBar()
        }
    }
}
