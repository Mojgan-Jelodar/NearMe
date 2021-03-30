//
//  AroundMeVC.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//
import UIKit
import CoreLocation
import MapKit

protocol P2VAroundMeProtocol: NSObjectProtocol {
    func startLoading()
    func show(error: Error)
    func stopLoading()
    func show(items: [Venue])
}

final class AroundMeVC: UIViewController {
    var presenter: V2PAroundMeProtocol?
    private lazy var locationManager: CLLocationManager = {
        let tmp = CLLocationManager()
        tmp.desiredAccuracy = kCLLocationAccuracyHundredMeters
        tmp.delegate = self
        return tmp
    }()
    @IBOutlet weak var mapView: MKMapView? {
        didSet {
            mapView?.showsUserLocation = true
            mapView?.delegate = self
        }
    }
}
extension AroundMeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizeStrings.AroundMe.title
        locationManager.requestWhenInUseAuthorization()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension AroundMeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        presenter?.fetch(lat: location.latitude, long: location.longitude)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
extension AroundMeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let venueAnnotation = view.annotation as? VenueAnnotation else { return }
        presenter?.showDetail(item: venueAnnotation.item)
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let regionRadius = 1000.0 // in meters
        let coordinateRegion = MKCoordinateRegion.init(center: userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.mapView?.setRegion( coordinateRegion, animated: true)
    }
}

extension AroundMeVC: P2VAroundMeProtocol {
    func show(items: [Venue]) {
        let annotaions = items.map({return VenueAnnotation(item: $0)})
        self.mapView?.addAnnotations(annotaions)
    }
    func startLoading() {
        self.view.lock()
    }
    func show(error: Error) {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func stopLoading() {
        self.view.unlock()
    }
}
