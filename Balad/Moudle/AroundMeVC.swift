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
    func show(items: [Items])
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
        guard !(view.annotation is MKUserLocation),
              let venueAnnotation = view.annotation as? VenueAnnotation else { return }
        let calloutView = CalloutView.loadFromNib()
        calloutView.item = venueAnnotation.item
        calloutView.delegate = self
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
//    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        if view.isKind(of: MKAnnotationView.self) {
//            for subview in view.subviews {
//                subview.removeFromSuperview()
//            }
//        }
//    }
}

extension AroundMeVC: CalloutViewDelegate {
    func showDetail(item: Items) {

    }
}
extension AroundMeVC: P2VAroundMeProtocol {
    func show(items: [Items]) {
        let annotaions = items.map({return VenueAnnotation(item: $0)})
        self.mapView?.addAnnotations(annotaions)
        let viewRegion = MKCoordinateRegion(center: annotaions[annotaions.count / 2].coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        self.mapView?.setRegion(viewRegion, animated: true)
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
