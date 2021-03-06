//
//  LocationPickerViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 20/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class LocationPickerViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var wereFound: UILabel!
    @IBOutlet weak var birdNumbers: UILabel!
    @IBOutlet weak var actButton: UIButton!
    @IBOutlet weak var nswButton: UIButton!
    @IBOutlet weak var ntButton: UIButton!
    @IBOutlet weak var qldButton: UIButton!
    @IBOutlet weak var saButton: UIButton!
    @IBOutlet weak var tasButton: UIButton!
    @IBOutlet weak var vicButton: UIButton!
    @IBOutlet weak var waButton: UIButton!
    @IBOutlet weak var topNavigationBar: UINavigationItem!
    
    
    var autoLocation = ""
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    var diameter = CGFloat()
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    var options = [String]()
    var size = ""
    var locations = [String]()
    let selectedButtonColour = UIColor(red: 255/255, green: 47/255, blue: 66/255, alpha: 1)
    let notSelectedButtonColour = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        questionLabel.adjustsFontSizeToFitWidth = true
        
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        diameter = screenWidth*0.25
        
        switch screenWidth {
        case 320:
            diameter = screenWidth*0.25
            initButtonsForSE()
        case 375:
            diameter = screenWidth*0.2
            initButtons()
        case 414:
            diameter = screenWidth*0.25
            initButtonsForPlus()
        case 768:
            diameter = screenWidth*0.25
            initButtonsForIpad()
        default:
            print("")
        }
        
        initLocation()
        updateBirdNumbers()
    }
    
    func initLocation(){
        
        switch autoLocation.uppercased() {
        case "ACT":
            updateLocations(button: vicButton, location: "act")
        case "NSW":
            updateLocations(button: vicButton, location: "nsw")
        case "NT":
            updateLocations(button: vicButton, location: "nt")
        case "QLD":
            updateLocations(button: vicButton, location: "qld")
        case "SA":
            updateLocations(button: vicButton, location: "sa")
        case "TAS":
            updateLocations(button: vicButton, location: "tas")
        case "VIC":
            updateLocations(button: vicButton, location: "vic")
        case "WA":
            updateLocations(button: vicButton, location: "wa")
        default:
            print("")
        }
        print("autoLocation: \(autoLocation)")
        
    }
    
    func updateBirdNumbers(){
        generator.impactOccurred()
        var tempLocation = locations
        if tempLocation.count != 8{
            for i in 1...(8-tempLocation.count){
                tempLocation.append(" ")
            }
        }
        let birds = Filter.filter(colours: options, size: size, locations: tempLocation)
        let numbers = birds.count
        birdNumbers.text = "\(numbers) "
        if numbers > 1{
            wereFound.text = "birds were found!"
        }else{
            wereFound.text = "bird was found!"
        }
        if numbers == 0{
            topNavigationBar.rightBarButtonItem?.isEnabled = false
        }else{
            topNavigationBar.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @IBAction func actButtonTapped(_ sender: UIButton) {
        updateLocations(button: actButton, location: "act")
    }
    
    @IBAction func nswButtonTapped(_ sender: UIButton) {
        updateLocations(button: nswButton, location: "nsw")
    }
    
    @IBAction func ntButtonTapped(_ sender: UIButton) {
        updateLocations(button: ntButton, location: "nt")
    }
    
    @IBAction func qldButtonTapped(_ sender: UIButton) {
        updateLocations(button: qldButton, location: "qld")
    }
    
    @IBAction func saButtonTapped(_ sender: UIButton) {
        updateLocations(button: saButton, location: "sa")
    }
    
    @IBAction func tasButtonTapped(_ sender: UIButton) {
        updateLocations(button: tasButton, location: "tas")
    }
    
    @IBAction func vicButtonTapped(_ sender: UIButton) {
        updateLocations(button: vicButton, location: "vic")
    }
    
    @IBAction func waButtonTapped(_ sender: UIButton) {
        updateLocations(button: waButton, location: "wa")
    }
    
    func initButtons(){
        actButton.backgroundColor = notSelectedButtonColour
        actButton.frame = CGRect(x: actButton.frame.origin.x, y: actButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: actButton)
        
        nswButton.backgroundColor = notSelectedButtonColour
        nswButton.frame = CGRect(x: nswButton.frame.origin.x, y: nswButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: nswButton)
        
        ntButton.backgroundColor = notSelectedButtonColour
        ntButton.frame = CGRect(x: ntButton.frame.origin.x, y: ntButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: ntButton)
        
        qldButton.backgroundColor = notSelectedButtonColour
        qldButton.frame = CGRect(x: qldButton.frame.origin.x, y: qldButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: qldButton)
        
        saButton.backgroundColor = notSelectedButtonColour
        saButton.frame = CGRect(x: saButton.frame.origin.x, y: saButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: saButton)
        
        tasButton.backgroundColor = notSelectedButtonColour
        tasButton.frame = CGRect(x: tasButton.frame.origin.x, y: tasButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: tasButton)
        
        vicButton.backgroundColor = notSelectedButtonColour
        vicButton.frame = CGRect(x: vicButton.frame.origin.x, y: vicButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: vicButton)
        
        waButton.backgroundColor = notSelectedButtonColour
        waButton.frame = CGRect(x: waButton.frame.origin.x, y: waButton.frame.origin.y, width: diameter, height: diameter)
        makeCircle(button: waButton)
    }
    
    func initButtonsForPlus(){
        actButton.backgroundColor = notSelectedButtonColour
        actButton.frame = CGRect(x: diameter*0.4, y: diameter*2.5, width: diameter, height: diameter)
        makeCircle(button: actButton)
        
        nswButton.backgroundColor = notSelectedButtonColour
        nswButton.frame = CGRect(x: diameter*0.4, y: diameter*4, width: diameter, height: diameter)
        makeCircle(button: nswButton)
        
        ntButton.backgroundColor = notSelectedButtonColour
        ntButton.frame = CGRect(x: diameter*0.4, y: diameter*5.5, width: diameter, height: diameter)
        makeCircle(button: ntButton)
        
        qldButton.backgroundColor = notSelectedButtonColour
        qldButton.frame = CGRect(x: diameter*1.5, y: diameter*3.3, width: diameter, height: diameter)
        makeCircle(button: qldButton)
        
        saButton.backgroundColor = notSelectedButtonColour
        saButton.frame = CGRect(x: diameter*1.5, y: diameter*4.7, width: diameter, height: diameter)
        makeCircle(button: saButton)
        
        tasButton.backgroundColor = notSelectedButtonColour
        tasButton.frame = CGRect(x: diameter*2.5, y: diameter*2.5, width: diameter, height: diameter)
        makeCircle(button: tasButton)
        
        vicButton.backgroundColor = notSelectedButtonColour
        vicButton.frame = CGRect(x: diameter*2.5, y: diameter*4, width: diameter, height: diameter)
        makeCircle(button: vicButton)
        
        waButton.backgroundColor = notSelectedButtonColour
        waButton.frame = CGRect(x: diameter*2.5, y: diameter*5.5, width: diameter, height: diameter)
        makeCircle(button: waButton)
    }
    
    func initButtonsForSE(){
        actButton.backgroundColor = notSelectedButtonColour
        actButton.frame = CGRect(x: diameter*0.4, y: diameter*2.7, width: diameter, height: diameter)
        makeCircle(button: actButton)
        
        nswButton.backgroundColor = notSelectedButtonColour
        nswButton.frame = CGRect(x: diameter*0.4, y: diameter*4.2, width: diameter, height: diameter)
        makeCircle(button: nswButton)
        
        ntButton.backgroundColor = notSelectedButtonColour
        ntButton.frame = CGRect(x: diameter*0.4, y: diameter*5.7, width: diameter, height: diameter)
        makeCircle(button: ntButton)
        
        qldButton.backgroundColor = notSelectedButtonColour
        qldButton.frame = CGRect(x: diameter*1.5, y: diameter*3.5, width: diameter, height: diameter)
        makeCircle(button: qldButton)
        
        saButton.backgroundColor = notSelectedButtonColour
        saButton.frame = CGRect(x: diameter*1.5, y: diameter*4.8, width: diameter, height: diameter)
        makeCircle(button: saButton)
        
        tasButton.backgroundColor = notSelectedButtonColour
        tasButton.frame = CGRect(x: diameter*2.5, y: diameter*2.7, width: diameter, height: diameter)
        makeCircle(button: tasButton)
        
        vicButton.backgroundColor = notSelectedButtonColour
        vicButton.frame = CGRect(x: diameter*2.5, y: diameter*4.2, width: diameter, height: diameter)
        makeCircle(button: vicButton)
        
        waButton.backgroundColor = notSelectedButtonColour
        waButton.frame = CGRect(x: diameter*2.5, y: diameter*5.7, width: diameter, height: diameter)
        makeCircle(button: waButton)
    }
    
    func initButtonsForIpad(){
        actButton.backgroundColor = notSelectedButtonColour
        actButton.frame = CGRect(x: diameter*0.4, y: diameter*1, width: diameter, height: diameter)
        makeCircle(button: actButton)
        
        nswButton.backgroundColor = notSelectedButtonColour
        nswButton.frame = CGRect(x: diameter*0.4, y: diameter*2.5, width: diameter, height: diameter)
        makeCircle(button: nswButton)
        
        ntButton.backgroundColor = notSelectedButtonColour
        ntButton.frame = CGRect(x: diameter*0.4, y: diameter*4, width: diameter, height: diameter)
        makeCircle(button: ntButton)
        
        qldButton.backgroundColor = notSelectedButtonColour
        qldButton.frame = CGRect(x: diameter*1.5, y: diameter*1.8, width: diameter, height: diameter)
        makeCircle(button: qldButton)
        
        saButton.backgroundColor = notSelectedButtonColour
        saButton.frame = CGRect(x: diameter*1.5, y: diameter*3.2, width: diameter, height: diameter)
        makeCircle(button: saButton)
        
        tasButton.backgroundColor = notSelectedButtonColour
        tasButton.frame = CGRect(x: diameter*2.5, y: diameter*1, width: diameter, height: diameter)
        makeCircle(button: tasButton)
        
        vicButton.backgroundColor = notSelectedButtonColour
        vicButton.frame = CGRect(x: diameter*2.5, y: diameter*2.5, width: diameter, height: diameter)
        makeCircle(button: vicButton)
        
        waButton.backgroundColor = notSelectedButtonColour
        waButton.frame = CGRect(x: diameter*2.5, y: diameter*4, width: diameter, height: diameter)
        makeCircle(button: waButton)
    }
    
    func makeCircle(button:UIButton){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
    }
    
    func updateLocations(button:UIButton, location:String){
        if button.backgroundColor == notSelectedButtonColour{
            button.backgroundColor = selectedButtonColour
            locations.append(location)
        }else{
            button.backgroundColor = notSelectedButtonColour
            var j = -1
            for i in 0..<locations.count{
                if locations[i] == location{
                    j = i
                    break
                }
            }
            if j != -1{
                locations.remove(at: j)
            }
        }
        updateBirdNumbers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationToList"
        {
            let controller = segue.destination as! FilterResultViewController
            var tempLocation = locations
            if tempLocation.count != 8{
                for i in 1...(8-tempLocation.count){
                    tempLocation.append(" ")
                }
            }
            let birds = Filter.filter(colours: options, size: size, locations: tempLocation)
            controller.birds = birds
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
