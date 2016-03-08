//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

import CoreLocation

class RJSLocationManager : UIViewController, CLLocationManagerDelegate
{
    var clLocationManager: CLLocationManager!
    var clLocation : CLLocation!
    var locationStatus: String!
    var lastHeading: Double!

    static let sharedInstance: RJSLocationManager =
    {
        let instance = RJSLocationManager()
        // Add here more setup code
        return instance
    }()
    
    func startLocating() -> Void
    {
        clLocationManager = CLLocationManager()
        clLocationManager.delegate = self
        clLocationManager.requestAlwaysAuthorization()
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.startUpdatingLocation() // Localizacao
        clLocationManager.startUpdatingHeading() // Norte, sul...
    }
    
    func getLastCLLocationCoordinate2D() -> CLLocationCoordinate2D
    {
        if(HaveValue(clLocation))
        {
            let result = CLLocationCoordinate2D(latitude: 0,longitude: 0)
            return result;
        }
        else
        {
            return getLastCLLocation().coordinate;
        }
    }
    
    func getLastHeadingDegrees() -> Double
    {
        if(!HaveValue(lastHeading))
        {
            lastHeading = 0;
        }
        return lastHeading;
    }
    
    func getLastCLLocation() -> CLLocation
    {
        if(HaveValue(clLocation))
        {
            return clLocation;
        }
        return CLLocation(latitude: 0, longitude: 0);
    }
    
    func getLocationStatus() -> String
    {
        if(HaveValue(locationStatus))
        {
            return "unknow";
        }
        return locationStatus;
    }
    
    static func calculateUserAngle(initialLocation : CLLocationCoordinate2D, destenyLocation : CLLocationCoordinate2D) -> Double
    {
        let locLat = destenyLocation.latitude;
        let locLon = destenyLocation.longitude;
        
        var pLat : Double = 0;
        var pLon : Double = 0;
        var degrees : Double = 0;
        
        let last = RJSLocationManager.sharedInstance.getLastCLLocation().coordinate;
        
        if(locLat > initialLocation.latitude && locLon > initialLocation.longitude)
        {
            // north east
            pLat = last.latitude;
            pLon = locLon;
            degrees = 0;
        }
        else if(locLat > initialLocation.latitude && locLon < initialLocation.longitude)
        {
            // south east
            pLat = locLat;
            pLon = last.longitude;
            degrees = 45;
        }
        else if(locLat < initialLocation.latitude && locLon < initialLocation.longitude)
        {
            // south west
            pLat = locLat;
            pLon = last.latitude;
            degrees = 180;
        }
        else if(locLat < initialLocation.latitude && locLon > initialLocation.longitude)
        {
            // north west
            pLat = locLat;
            pLon = last.longitude;
            degrees = 225;
        }
        
        // Vector QP (from user to point)
        let vQPlat = pLat - last.latitude;
        let vQPlon = pLon - last.longitude;
        
        // Vector QL (from user to location)
        let vQLlat = locLat - initialLocation.latitude;
        let vQLlon = locLon - initialLocation.longitude;
        
        // degrees between QP and QL
        let cosDegrees = (vQPlat * vQLlat + vQPlon * vQLlon) / sqrt((vQPlat*vQPlat + vQPlon*vQPlon) * (vQLlat*vQLlat + vQLlon*vQLlon));
        degrees = degrees + acos(cosDegrees);
        
       // degrees = ( ( radians ) * ( 180.0 / M_PI ) )
        
        return degrees
    }
    
    /*
     * DELEGATE
     */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locationArray = locations as NSArray
        let location      = locationArray.lastObject as! CLLocation
        clLocation        = location
    }
    
    // authorization status
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        var shouldIAllow = false
        
        switch status
        {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        
        if (shouldIAllow == true)
        {
            DLog("Location to Allowed")
            clLocationManager.startUpdatingLocation()
        }
        else
        {
            DLogError("Location to Allowed")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        //clLocationManager.stopUpdatingLocation()
        RJSErrorsManager.handleError(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        lastHeading = newHeading.magneticHeading;
    }
}

