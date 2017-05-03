//
//  SizePickerViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 20/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SizePickerViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var birdNumbers: UILabel!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var hugeButton: UIButton!
    @IBOutlet weak var doNotKnowButton: UIButton!
    @IBOutlet weak var likeWhatLabel: UILabel!
    
    var autoLocation = ""
    let manager = CLLocationManager()
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    var diameter = CGFloat()
    
    let selectedButtonColour = UIColor(red: 255/255, green: 47/255, blue: 66/255, alpha: 1)
    let notSelectedButtonColour = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    var options = [String]()
    var size = ""
    let locations = [" ", " ", " ", " ", " ", " ", " ", " "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        let birds = Filter.filter(colours: options, size: size, locations: locations)
        let numbers = birds.count
        if numbers > 1{
            birdNumbers.text = "\(numbers) birds were found!"
        }else{
            birdNumbers.text = "\(numbers) bird were found!"
        }
        self.title = "Size"
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        diameter = screenWidth*0.3
        if screenHeight/screenWidth < 1.5{
            initButtonsForIpad()
        }else{
            initButtons()
        }
        likeWhatLabel.text = "Just Like a Bird!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        if autoLocation != ""{
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            
            if error != nil{
                manager.stopUpdatingLocation()
                print("There was an error")
            }else{
                if let place = placemarks?[0]{
                    if let state = place.administrativeArea{
                        self.autoLocation = state
                    }
                    
                }
            }
        })
        
    }
    
    @IBAction func smallButtonTapped(_ sender: UIButton) {
        if size != "small"{
            size = "small"
            buttonSelected(button: smallButton)
            likeWhatLabel.text = "Like a Sparrow?"
        }else{
            buttonDeselected(button: smallButton)
            size = "xxx"
            likeWhatLabel.text = "Just Like a Bird!"
        }
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: hugeButton)
        buttonDeselected(button: doNotKnowButton)
        updateNumbers()
    }
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        if size != "medium"{
            size = "medium"
            buttonSelected(button: mediumButton)
            likeWhatLabel.text = "Like a Pigeon?"
        }else{
            buttonDeselected(button: mediumButton)
            size = "xxx"
            likeWhatLabel.text = "Just Like a Bird!"
        }
        buttonDeselected(button: smallButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: hugeButton)
        buttonDeselected(button: doNotKnowButton)
        updateNumbers()
    }
    @IBAction func largeButtonTapped(_ sender: UIButton) {
        if size != "large"{
            size = "large"
            buttonSelected(button: largeButton)
            likeWhatLabel.text = "Like a Goose?"
        }else{
            buttonDeselected(button: largeButton)
            size = "xxx"
            likeWhatLabel.text = "Just Like a Bird!"
        }
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: smallButton)
        buttonDeselected(button: hugeButton)
        buttonDeselected(button: doNotKnowButton)
        updateNumbers()
    }
    @IBAction func hugeButtonTapped(_ sender: UIButton) {
        if size != "huge"{
            size = "huge"
            buttonSelected(button: hugeButton)
            likeWhatLabel.text = "Like an Emu?"
        }else{
            buttonDeselected(button: hugeButton)
            size = "xxx"
            likeWhatLabel.text = "Just Like a Bird!"
        }
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: smallButton)
        buttonDeselected(button: doNotKnowButton)
        updateNumbers()
    }
    
    @IBAction func doNotKnowButtonTapped(_ sender: UIButton) {
        if size != "doNotKnow"{
            size = "doNotKnow"
            likeWhatLabel.text = "I Don't Know!"
            buttonSelected(button: doNotKnowButton)
        }else{
            buttonDeselected(button: doNotKnowButton)
            size = "xxx"
            likeWhatLabel.text = "Just Like a Bird!"
        }
        buttonDeselected(button: smallButton)
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: hugeButton)
        updateNumbers()
    }
    
    func buttonSelected(button:UIButton){
        button.backgroundColor = selectedButtonColour
    }
    
    func buttonDeselected(button:UIButton){
        button.backgroundColor = notSelectedButtonColour
    }
    
    func updateNumbers(){
        let birds = Filter.filter(colours: options, size: size, locations: locations)
        let numbers = birds.count
        if numbers > 1{
            birdNumbers.text = "\(numbers) birds were found!"
        }else{
            birdNumbers.text = "\(numbers) bird were found!"
        }
    }
    
    func initButtons(){
        smallButton.frame = CGRect(x: diameter/3, y: diameter*2.75, width: diameter, height: diameter)
        smallButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: smallButton)
        mediumButton.frame = CGRect(x: diameter*2, y: diameter*2.75, width: diameter, height: diameter)
        mediumButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: mediumButton)
        largeButton.frame = CGRect(x: diameter/3, y: diameter*4.25, width: diameter, height: diameter)
        largeButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: largeButton)
        hugeButton.frame = CGRect(x: diameter*2, y: diameter*4.25, width: diameter, height: diameter)
        hugeButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: hugeButton)
        doNotKnowButton.frame = CGRect(x: diameter/3*3.5, y: diameter*3.5, width: diameter, height: diameter)
        doNotKnowButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: doNotKnowButton)
    }
    
    func initButtonsForIpad(){
        smallButton.frame = CGRect(x: diameter/3, y: diameter*1.75, width: diameter, height: diameter)
        smallButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: smallButton)
        mediumButton.frame = CGRect(x: diameter*2, y: diameter*1.75, width: diameter, height: diameter)
        mediumButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: mediumButton)
        largeButton.frame = CGRect(x: diameter/3, y: diameter*3, width: diameter, height: diameter)
        largeButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: largeButton)
        hugeButton.frame = CGRect(x: diameter*2, y: diameter*3, width: diameter, height: diameter)
        hugeButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: hugeButton)
        doNotKnowButton.frame = CGRect(x: diameter/3*3.5, y: diameter*2.4, width: diameter, height: diameter)
        doNotKnowButton.backgroundColor = notSelectedButtonColour
        makeCircle(button: doNotKnowButton)
    }
    
    func makeCircle(button:UIButton){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sizeToLocation"
        {
            let controller = segue.destination as! LocationPickerViewController
            controller.options = self.options
            controller.size = self.size
            controller.autoLocation = autoLocation
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
