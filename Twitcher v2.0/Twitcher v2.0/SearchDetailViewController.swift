//
//  SearchDetailViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 19/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import CoreLocation
import MapKit

class SearchDetailViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {

    var bird:Bird? = nil
    var player:AVAudioPlayer = AVAudioPlayer()
    var latitude = 0.0
    var longitude = 0.0
    
    @IBOutlet weak var pictureScrollView: UIScrollView!
    

    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var commonNameLabel: UILabel!
    @IBOutlet weak var scientificNameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var minLengthLabel: UILabel!
    @IBOutlet weak var maxLengthLabel: UILabel!
    @IBOutlet weak var minWeightLabel: UILabel!
    @IBOutlet weak var maxWeightLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionInfoLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    @IBOutlet weak var dietInfoLabel: UILabel!
    @IBOutlet weak var taxonomyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    let manager = CLLocationManager()
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // core location manager
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        pictureScrollView.delegate = self
        loadBIrd()
        addPicturesToScrollView()
        pageControl.numberOfPages = imageArray.count
        loadBirdInfo()
        initAVPlayer()
        initTagButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addPicturesToScrollView(){
        pictureScrollView.frame = view.frame
        
        for j in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.image = imageArray[j]
            imageView.contentMode = .scaleToFill
            let xPosition = self.view.frame.width * CGFloat(j)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.pictureScrollView.frame.width, height: 250)//self.pictureScrollView.frame.height)
            
            pictureScrollView.contentSize.width = pictureScrollView.frame.width * CGFloat( j + 1)
            pictureScrollView.addSubview(imageView)
        }
    }
    
    func loadBIrd(){
        //commonName.text = bird?.commonName
        
        for i in 0..<5{
            if let image = UIImage(named: "\(bird!.index)_\(i)"){
                
                imageArray.append(image)
            }else{
                print("image \(bird!.index)_\(i) was not found")
            }
        }
        
        if imageArray.isEmpty {
            print(imageArray.count)
            if let defaultImage = UIImage(named: "noImage"){
                imageArray.append(defaultImage)
                print("add default picture succeeded")
            }else{
                print("add default picture failed")
            }
        }
    }
    
    func loadBirdInfo(){
        commonNameLabel.text = Filter.captitaliseFirstCharacter(aString: bird!.commonName!)
        scientificNameLabel.text = Filter.captitaliseFirstCharacter(aString: bird!.scientificName!)
        sizeLabel.text = "Size"
        if bird!.minLength != 0{
            minLengthLabel.text = "Min Length: \(bird!.minLength) cm"
        }else{
            minLengthLabel.text = "Min Length: no value"
        }
        if bird!.maxLength != 500{
            maxLengthLabel.text = "Max Length: \(bird!.maxLength) cm"
        }else{
            maxLengthLabel.text = "Max Length: no value"
        }
        if bird!.minWeight != 0{
            minWeightLabel.text = "Min Weight: \(bird!.minWeight) g"
        }else{
            minWeightLabel.text = "Min Weight: no value"
        }
        if bird!.maxWeight != 100000{
            maxWeightLabel.text = "Max Weight: \(bird!.maxWeight) g"
        }else{
            maxWeightLabel.text = "Max Weight: no value"
        }
        
        
        locationLabel.text = "Locations"
        stateLabel.text = bird!.colour2?.uppercased()
        descriptionLabel.text = "Description"
        descriptionInfoLabel.text = bird!.birdDescription
        dietLabel.text = "Diet"
        dietInfoLabel.text = bird!.diet
        taxonomyLabel.text = "Taxonomy"
        categoryLabel.text = "Category: \(bird!.category!)"
        orderLabel.text = "Order: \(bird!.order!) "
        familyLabel.text = "Family: \(bird!.family!) "
    }
    
    func initAVPlayer(){
        
        if let audioPath = Bundle.main.path(forResource: "\((bird?.index)!)", ofType: "mp3"){
            do {
                playButton.isEnabled = true
                try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath) as URL)
            }catch{
                //ERROR
            }
        }else{
            playButton.isEnabled = false
            playButton.setTitle("No Record", for: .normal)
        }
    }
    
    func initTagButton(){
        let birdTags = Filter.filterTagByIndex(birdIndex: Int((bird?.index)!))
        tagButton.setTitle("\(birdTags.count) Times", for: .normal)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = pictureScrollView.contentOffset.x / pictureScrollView.frame.size.width
        //pageControl.numberOfPages = imageArray.count
        pageControl.currentPage = Int(page)
    }
    
    @IBAction func play(_ sender: UIButton) {
        player.play()
    }
    
    @IBAction func pause(_ sender: UIButton) {
        player.pause()
    }
    @IBAction func tagButtonTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newBirdTag = NSEntityDescription.insertNewObject(forEntityName: "BirdTag", into: context) as! BirdTag
        newBirdTag.birdIndex = (bird?.index)!
        newBirdTag.isSeen = 1
        newBirdTag.latitude = latitude
        newBirdTag.longitude = longitude
        newBirdTag.date = Filter.getDate()
        
        let birdTags = Filter.filterTagByIndex(birdIndex: Int((bird?.index)!))
        tagButton.setTitle("\(birdTags.count) Times", for: .normal)
        Filter.writeTagToCSV()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
