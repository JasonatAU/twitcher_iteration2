//
//  BirdTagDetailViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 2/5/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BirdTagDetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var birdNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    let manager = CLLocationManager()
    var birdName = ""
    var latitude = 0.0
    var longitude = 0.0
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        displayBirdLocation()
        //manager.requestWhenInUseAuthorization()
        //manager.startUpdatingLocation()
    }
    
    func displayBirdLocation(){
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let birdLocation = CLLocation(latitude:latitude, longitude:longitude)
        let birdLocation2D:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: birdLocation2D, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = latitude
        annotation.coordinate.longitude = longitude
        annotation.title = "\(Filter.aOrAn(name: birdName).uppercased()) \(birdName)!"
        map.addAnnotation(annotation)
        
        CLGeocoder().reverseGeocodeLocation(birdLocation, completionHandler: {(placemarks, error) in
            
            if error != nil{
                print("There was an error")
            }else{
                if let place = placemarks?[0]{
                    //addressDictionary, country, postalCode, thoroughfare
                    var fullAddress = ""
                    if let name = place.name{
                        fullAddress = fullAddress + name + "\n"
                    }
                    if let thoroughfare = place.thoroughfare{
                        fullAddress = fullAddress + thoroughfare + "\n"
                    }
                    if let city = place.locality{
                        fullAddress = fullAddress + city + " "
                    }
                    if let state = place.administrativeArea{
                        fullAddress = fullAddress + state + "\n"
                    }
                    if let country = place.country{
                        fullAddress = fullAddress + country
                    }
                    print(place.subAdministrativeArea, place.administrativeArea, place.areasOfInterest, place.subLocality)
                    
                    self.birdNameLabel.text = "Wow, this is \(Filter.aOrAn(name: self.birdName)) \(self.birdName)"
                    self.addressLabel.text = "It was found at\n\(fullAddress)"
                    self.dateLabel.text = "It was found on \n\(Filter.displayDate(date: self.date))"
                }
            }
        })
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
//        
//        //let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let birdLocation2D:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//        let birdLocation = CLLocation(latitude:latitude, longitude:longitude)
//        let region:MKCoordinateRegion = MKCoordinateRegion(center: birdLocation2D, span: span)
//        map.setRegion(region, animated: true)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate.latitude = latitude
//        annotation.coordinate.longitude = longitude
//        annotation.title = birdName
//        map.addAnnotation(annotation)
//        self.map.showsUserLocation = true
//        //print(location.coordinate.latitude)
//        //print(location.coordinate.longitude)
//        
//        CLGeocoder().reverseGeocodeLocation(birdLocation, completionHandler: {(placemarks, error) in
//            
//            if error != nil{
//                print("There was an error")
//            }else{
//                if let place = placemarks?[0]{
//                    if let address = place.addressDictionary{
//                        print("address: \(address)")
//                    }
//                    if let country = place.country{
//                        print("country: \(country)")
//                    }
//                    if let postalCode = place.postalCode{
//                        print("post code: \(postalCode)")
//                    }
//                    if let thoroughfare = place.thoroughfare{
//                        print("thoroughfare: \(thoroughfare)")
//                    }
//                    if let subThoroughfare = place.subThoroughfare{
//                        print("sub thoroughfare: \(subThoroughfare)")
//                    }
//                }
//            }
//        })
//    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
