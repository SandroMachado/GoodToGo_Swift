//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//


import Foundation
import UIKit

import MapKit
import CoreLocation

class RJSMapViewUtils : UIViewController, MKMapViewDelegate
{
    
    static func centerMapInCLLocation(location: CLLocation, mapView :MKMapView)
    {
        centerMapInCLLocation(location, mapView: mapView, radius: 1000)
    }
    
    static func centerMapInCLLocation(location: CLLocation, mapView :MKMapView, radius: Int)
    {
        if(!HaveValue(mapView))
        {
            return;
        }
        let regionRadius: CLLocationDistance = 1000;//(double)radius
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0,regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    static func getPlacemarkFromCLLocationCoordinate2D(location:CLLocationCoordinate2D, rjpsCompletionHandler:RJSPCompletionHandler)
    {
        let clLocation: CLLocation =  CLLocation(latitude: location.latitude, longitude: location.longitude)
        getPlacemarkFromCLLocation(clLocation, rjpsCompletionHandler:{(anyObject, error) in
                rjpsCompletionHandler(anyObject, error);
        })
    }
    
    static func getPlacemarkFromCLLocation(clLocation: CLLocation, rjpsCompletionHandler: RJSPCompletionHandler)
    {
        CLGeocoder().reverseGeocodeLocation(clLocation, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    RJSErrorsManager.handleError(error)
                    rjpsCompletionHandler(nil, error);
                }
                if(HaveValue(placemarks))
                {
                    let pm = placemarks! as [CLPlacemark]
                    if pm.count > 0
                    {
                        let place = placemarks![0] as CLPlacemark
                        rjpsCompletionHandler(place, nil);
                    }
                    rjpsCompletionHandler(nil, nil);
                }
                rjpsCompletionHandler(nil, nil);
        })
    }
    
    static func adressFromCLPlacemark(placeMark: CLPlacemark?, fullAdress: Bool) -> String
    {
        if(!HaveValue(placeMark))
        {
            return "";
        }
        let address = placeMark?.addressDictionary?.description;
        return address!;
    }
    
    static func addAnnotationToMap(mapView :MKMapView?, latitude : Double, longitude : Double, title : String?, subTitle: String?, tag: Int) -> Bool
    {
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude);
        return addAnnotationToMap(mapView,coordinates:coordinates, title: title, subTitle: subTitle, tag: tag);
    }
    
    static func removeAllAnnotions(mapView :MKMapView?) -> Bool
    {
        if(!HaveValue(mapView))
        {
            return false;
        }
        let annotations = mapView!.annotations;
        if(HaveValue(annotations))
        {
            let annotationsToRemove = mapView!.annotations.filter { $0 !== mapView!.userLocation }
            mapView!.removeAnnotations( annotationsToRemove )
        }
        return true
    }
    
    static func addAnnotationToMap(mapView :MKMapView?, coordinates : CLLocationCoordinate2D, title : String?, subTitle: String?, tag: Int) -> Bool
    {
        if(!HaveValue(mapView))
        {
            return false;
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = title
        annotation.subtitle = subTitle
        mapView!.addAnnotation(annotation)
        return true;
    }
}
