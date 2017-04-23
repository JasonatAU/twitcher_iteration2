//
//  SizePickerViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 20/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class SizePickerViewController: UIViewController {

    @IBOutlet weak var birdNumbers: UILabel!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var hugeButton: UIButton!
    @IBOutlet weak var doNotKnowButton: UIButton!
    
    
    let selectedButtonColour = UIColor(red: 255/255, green: 47/255, blue: 66/255, alpha: 1)
    let notSelectedButtonColour = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    var options = [String]()
    var size = ""
    let locations = [" ", " ", " ", " ", " ", " ", " ", " "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButtons()
        let birds = Filter.filter(colours: options, size: size, locations: locations)
        let numbers = birds.count
        birdNumbers.text = "\(numbers) birds were found!"
        self.title = "Size"
    }
    
    @IBAction func smallButtonTapped(_ sender: UIButton) {
        size = "small"
        buttonSelected(button: smallButton)
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: hugeButton)
        buttonDeselected(button: doNotKnowButton)
    }
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        size = "medium"
        buttonSelected(button: mediumButton)
        buttonDeselected(button: smallButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: hugeButton)
        buttonDeselected(button: doNotKnowButton)
    }
    @IBAction func largeButtonTapped(_ sender: UIButton) {
        size = "large"
        buttonSelected(button: largeButton)
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: smallButton)
        buttonDeselected(button: hugeButton)
        buttonDeselected(button: doNotKnowButton)
    }
    @IBAction func hugeButtonTapped(_ sender: UIButton) {
        size = "huge"
        buttonSelected(button: hugeButton)
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: smallButton)
        buttonDeselected(button: doNotKnowButton)
    }
    
    @IBAction func doNotKnowButtonTapped(_ sender: UIButton) {
        size = "doNotKnow"
        buttonSelected(button: doNotKnowButton)
        buttonDeselected(button: smallButton)
        buttonDeselected(button: mediumButton)
        buttonDeselected(button: largeButton)
        buttonDeselected(button: hugeButton)
    }
    
    func buttonSelected(button:UIButton){
        button.backgroundColor = selectedButtonColour
        let birds = Filter.filter(colours: options, size: size, locations: locations)
        let numbers = birds.count
        birdNumbers.text = "\(numbers) birds were found!"
        print(options)
        print(size)
    }
    
    func buttonDeselected(button:UIButton){
        button.backgroundColor = notSelectedButtonColour
    }
    
    func initButtons(){
        smallButton.backgroundColor = notSelectedButtonColour
        mediumButton.backgroundColor = notSelectedButtonColour
        largeButton.backgroundColor = notSelectedButtonColour
        hugeButton.backgroundColor = notSelectedButtonColour
        doNotKnowButton.backgroundColor = notSelectedButtonColour
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sizeToLocation"
        {
            let controller = segue.destination as! LocationPickerViewController
            controller.options = self.options
            controller.size = self.size
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
