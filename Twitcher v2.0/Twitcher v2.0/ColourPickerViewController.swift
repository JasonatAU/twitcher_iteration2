//
//  ColourPickerViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 20/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class ColourPickerViewController: UIViewController {

    
    @IBOutlet weak var birdNumbers: UILabel!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var brownButton: UIButton!
    @IBOutlet weak var chestnutButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var greyButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var tanButton: UIButton!
    
    
    
    
    
    var options = [String]()
    let small:CGFloat = 50
    let big:CGFloat = 100
    let size = "xxx"
    let locations = [" ", " ", " ", " ", " ", " ", " ", " "]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Colour"
        initButtons()
        updateBirdNumbers()
        self.tabBarController?.tabBar.isHidden = true
    }


    @IBAction func blueButtonTapped(_ sender: UIButton) {
        updateOptions(button: blueButton, colour: "blue")
    }
    @IBAction func blackButtonTapped(_ sender: UIButton) {
        updateOptions(button: blackButton, colour: "black")
    }
    @IBAction func brownButtonTapped(_ sender: UIButton) {
        updateOptions(button: brownButton, colour: "brown")
    }
    @IBAction func chestnutButtonTapped(_ sender: UIButton) {
        updateOptions(button: chestnutButton, colour: "chestnut")
    }
    @IBAction func greenButtonTapped(_ sender: UIButton) {
        updateOptions(button: greenButton, colour: "green")
    }
    @IBAction func greyButtonTapped(_ sender: UIButton) {
        updateOptions(button: greyButton, colour: "grey")
    }
    @IBAction func pinkButtonTapped(_ sender: UIButton) {
        updateOptions(button: pinkButton, colour: "pink")
    }
    @IBAction func redButtonTapped(_ sender: UIButton) {
        updateOptions(button: redButton, colour: "red")
    }
    @IBAction func whiteButtonTapped(_ sender: UIButton) {
        updateOptions(button: whiteButton, colour: "white")
    }
    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        updateOptions(button: yellowButton, colour: "yellow")
    }
    @IBAction func orangeButtonTapped(_ sender: UIButton) {
        updateOptions(button: orangeButton, colour: "orange")
    }
    @IBAction func tanButtonTapped(_ sender: UIButton) {
        updateOptions(button: tanButton, colour: "tan")
    }

    
    
    
    func shrink(button:UIButton){
        button.frame = CGRect(x: button.frame.origin.x + small/2, y: button.frame.origin.y + small/2, width: small, height: small)
        makeCircle(button: button)
    }

    
    func enlarge(button:UIButton){
        button.frame = CGRect(x: button.frame.origin.x - small/2, y: button.frame.origin.y - small/2, width: big, height: big)
        makeCircle(button: button)
    }
    
    func makeCircle(button:UIButton){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
    }
    
    
    
    func updateBirdNumbers(){
        var numbers = 0
        numbers = Filter.filter(colours: options, size: size, locations: locations).count
        birdNumbers.text = "\(numbers) birds were found!"
    }
    
    func updateOptions(button:UIButton, colour:String){
        let radius = button.frame.width
        if radius == small{
            enlarge(button: button)
            options.append(colour)
        }else{
            shrink(button: button)
            var j = -1
            for i in 0..<options.count{
                if options[i] == colour{
                    j = i
                    break
                }
            }
            if j != -1{
                options.remove(at: j)
            }
        }
        updateBirdNumbers()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func initButtons(){
        blueButton.frame = CGRect(x: blueButton.frame.origin.x, y: blueButton.frame.origin.y, width: small, height: small)
        makeCircle(button: blueButton)
        blueButton.backgroundColor = UIColor(red: 0/255, green: 102/255, blue: 255/255, alpha: 1)
        
        blackButton.frame = CGRect(x: blackButton.frame.origin.x, y: blackButton.frame.origin.y, width: small, height: small)
        makeCircle(button: blackButton)
        blackButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        brownButton.frame = CGRect(x: brownButton.frame.origin.x, y: brownButton.frame.origin.y, width: small, height: small)
        makeCircle(button: brownButton)
        brownButton.backgroundColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)

        chestnutButton.frame = CGRect(x: chestnutButton.frame.origin.x, y: chestnutButton.frame.origin.y, width: small, height: small)
        makeCircle(button: chestnutButton)
        chestnutButton.backgroundColor = UIColor(red: 149/255, green: 69/255, blue: 53/255, alpha: 1)
        
        greenButton.frame = CGRect(x: greenButton.frame.origin.x, y: greenButton.frame.origin.y, width: small, height: small)
        makeCircle(button: greenButton)
        greenButton.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1)
        
        greyButton.frame = CGRect(x: greyButton.frame.origin.x, y: greyButton.frame.origin.y, width: small, height: small)
        makeCircle(button: greyButton)
        greyButton.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        
        pinkButton.frame = CGRect(x: pinkButton.frame.origin.x, y: pinkButton.frame.origin.y, width: small, height: small)
        makeCircle(button: pinkButton)
        pinkButton.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1)
        
        redButton.frame = CGRect(x: redButton.frame.origin.x, y: redButton.frame.origin.y, width: small, height: small)
        makeCircle(button: redButton)
        redButton.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        
        whiteButton.frame = CGRect(x: whiteButton.frame.origin.x, y: whiteButton.frame.origin.y, width: small, height: small)
        makeCircle(button: whiteButton)
        whiteButton.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        yellowButton.frame = CGRect(x: yellowButton.frame.origin.x, y: yellowButton.frame.origin.y, width: small, height: small)
        makeCircle(button: yellowButton)
        yellowButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
        
        orangeButton.frame = CGRect(x: orangeButton.frame.origin.x, y: orangeButton.frame.origin.y, width: small, height: small)
        makeCircle(button: orangeButton)
        orangeButton.backgroundColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)
        
        tanButton.frame = CGRect(x: tanButton.frame.origin.x, y: tanButton.frame.origin.y, width: small, height: small)
        makeCircle(button: tanButton)
        tanButton.backgroundColor = UIColor(red: 210/255, green: 180/255, blue: 140/255, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "colourToSize"
        {
            let controller = segue.destination as! SizePickerViewController
            controller.options = self.options
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}