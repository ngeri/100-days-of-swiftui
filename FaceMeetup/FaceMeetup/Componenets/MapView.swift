import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    var centerCoordinate: CLLocationCoordinate2D
    var location: MKPointAnnotation

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.centerCoordinate = centerCoordinate
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.centerCoordinate = centerCoordinate
        if let annotation = view.annotations.first {
            if annotation.coordinate.latitude != location.coordinate.latitude || annotation.coordinate.longitude != location.coordinate.longitude {
                view.removeAnnotation(annotation)
                view.addAnnotation(location)
            }
        } else {
            view.addAnnotation(location)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
