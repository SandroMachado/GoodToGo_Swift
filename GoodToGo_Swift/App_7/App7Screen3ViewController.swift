//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit
import MapKit

// FIX: The map is consuming to much memory
class App7Screen3ViewController: UIViewController, MKMapViewDelegate {
 
    @IBOutlet weak var map: MKMapView?
    var sharedVar : TableItem?
    
    var viewModel : Screen3ViewModel? {
        didSet {
            shouldUpdateScreen()
        }
    }
    
    // MARK: MKMapView
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
        }
        else {
            pinView?.annotation = annotation
        }

        return pinView
    }
    
    // MARK: Auxiliar

    func shouldUpdateScreen() {
        
        guard HaveValue(map) else {
            DLogWarning("Ignored...")
            return
        }
        
        // Add the annotation with the user location
        let location = CLLocationCoordinate2D(
            latitude: (viewModel!.latitude),
            longitude: (viewModel!.longitude)
        )
        
        guard !(location.longitude==0) || !(location.latitude==0) else {
            DLogWarning("Latitude==0? Longitude==0? Ignored...")
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate   = location
        annotation.title        = ""
        annotation.subtitle     = ""

        map!.addAnnotation(annotation)
    
        // Center the map....
        let center = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        map!.setRegion(region, animated: true)
        
        RJSMessagesManager.showSmallTopMessage("[\(location.latitude),\(location.longitude)]")
    }
    
    func loadViewModel()
    {
        guard !HaveValue(viewModel) else {
            DLogWarning("Ignored... Are you calling this 2x?")
            return
        }
        viewModel = Screen3ViewModel(item: sharedVar!)
        viewModel!.viewNeedsReload.bindAndFire({
            if $0 {
                self.shouldUpdateScreen()
            }
        })
    }
    
    // MARK: Page life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated);
        self.loadViewModel()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }

}

