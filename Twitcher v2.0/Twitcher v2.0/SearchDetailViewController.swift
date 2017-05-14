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

class SearchDetailViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate, AVAudioPlayerDelegate {

    var bird:Bird? = nil
    var player:AVAudioPlayer = AVAudioPlayer()
    var latitude = 0.0
    var longitude = 0.0
    var currentPage = 0
    var numberOfPages = 0
    var haveAudio = false
    var isPlaying = false
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var pictureScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var commonNameLabel: UILabel!
    @IBOutlet weak var scientificNameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var minLengthLabel: UILabel!
    @IBOutlet weak var minWeightLabel: UILabel!
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
    
    
    @IBOutlet weak var topNavigationBar: UINavigationItem!
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
        initScreenSize()
        initScrollViewHeight()
        loadBIrd()
        addPicturesToScrollView()
        pageControl.numberOfPages = imageArray.count
        loadBirdInfo()
        initAVPlayer()
        initTagButton()
        autoScroll()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if haveAudio{
            player.pause()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addPicturesToScrollView(){
        //pictureScrollView.frame = view.frame
        
        var width = CGFloat()
        var height = CGFloat()
        
        switch screenWidth {
        case 320:
            width = 320
            height = 213
        case 375:
            width = 375
            height = 250
        case 414:
            width = 414
            height = 276
        case 768:
            width = 768
            height = 512
        default:
            print("")
        }
        
        for j in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.image = imageArray[j]
            imageView.contentMode = .scaleToFill
            let xPosition = self.view.frame.width * CGFloat(j)
            imageView.frame = CGRect(x: xPosition, y: 0, width: width, height: height)//self.pictureScrollView.frame.height)
            
            pictureScrollView.contentSize.width = width * CGFloat( j + 1)
            pictureScrollView.addSubview(imageView)
            numberOfPages += 1
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let myPageWidth = pictureScrollView.frame.width
        let number = currentPage%numberOfPages
        let page = pictureScrollView.contentOffset.x / pictureScrollView.frame.size.width
        pageControl.currentPage = Int(page)
        currentPage = Int(page)
        if pictureScrollView.contentOffset.x > pictureScrollView.frame.size.width*CGFloat(numberOfPages-1) {
            pictureScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(0), y:0), animated: true)
            currentPage = 0
        }
        if pictureScrollView.contentOffset.x < 0 {
            pictureScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(numberOfPages-1), y:0), animated: true)
            currentPage -= 1
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
            if bird!.maxLength != 500{
                minLengthLabel.text = "Length: \(bird!.minLength) to \(bird!.maxLength) cm"
            }
        }else{
            minLengthLabel.text = "Length: no value"
        }
        
        if bird!.minWeight != 0{
            if bird!.maxWeight != 100000{
                minWeightLabel.text = "Weight: \(bird!.minWeight) to \(bird!.maxWeight) g"
            }
        }else{
            minWeightLabel.text = "Weight: no value"
        }
        
        locationLabel.text = "Locations"
        stateLabel.text = bird!.colour2?.uppercased()
        descriptionLabel.text = "Description"
        descriptionInfoLabel.text = bird!.birdDescription
        dietLabel.text = "Diet"
        dietInfoLabel.text = bird!.diet
        taxonomyLabel.text = "Sorting & Classifying (Taxonomy)"
        categoryLabel.text = "Category: \(bird!.category!)"
        orderLabel.text = "Order: \(bird!.order!) "
        familyLabel.text = "Family: \(bird!.family!) "
    }
    
    func initAVPlayer(){
        
        if let audioPath = Bundle.main.path(forResource: "\((bird?.index)!)", ofType: "mp3"){
            do {
                playButton.isEnabled = true
                try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath) as URL)
                player.delegate = self
                pauseButton.isEnabled = true
                
                if let playImage = UIImage(named: "ic_play_arrow"){
                    pauseButton.setImage(playImage, for: .normal)
                }
                
                haveAudio = true
            }catch{
                //ERROR
            }
        }else{
            if let pauseImage = UIImage(named: "ic_pause_2x"){
                pauseButton.setImage(pauseImage, for: .normal)
            }
            playButton.isEnabled = false
            playButton.setTitle("", for: .normal)
            pauseButton.isEnabled = false
            haveAudio = false
        }
    }
    
    func initTagButton(){
        let birdTags = Filter.filterTagByIndex(birdIndex: Int((bird?.index)!)).count
        if birdTags == 0{
            tagButton.setTitle(" Tag It! ", for: .normal)
        }else if birdTags == 1{
            tagButton.setTitle(" 1 Tag! ", for: .normal)
        }else{
            tagButton.setTitle(" \(birdTags) Tags! ", for: .normal)
        }
        tagButton.layer.cornerRadius = 0.1 * tagButton.bounds.size.width
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let page = pictureScrollView.contentOffset.x / pictureScrollView.frame.size.width
//        //pageControl.numberOfPages = imageArray.count
//        pageControl.currentPage = Int(page)
//    }
    
    @IBAction func play(_ sender: UIButton) {
        
        if isPlaying{
            isPlaying = false
            player.pause()
            if let playImage = UIImage(named: "ic_play_arrow"){
                pauseButton.setImage(playImage, for: .normal)
            }
        }else{
            isPlaying = true
            player.play()
            if let pauseImage = UIImage(named: "ic_pause_2x"){
                pauseButton.setImage(pauseImage, for: .normal)
            }
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if isPlaying{
            isPlaying = false
            player.pause()
            if let playImage = UIImage(named: "ic_play_arrow"){
                pauseButton.setImage(playImage, for: .normal)
            }
        }else{
            isPlaying = true
            player.play()
            if let pauseImage = UIImage(named: "ic_pause_2x"){
                pauseButton.setImage(pauseImage, for: .normal)
            }
        }
    }
    @IBAction func tagButtonTapped(_ sender: UIButton) {
        
        let birdTags = Filter.filterTagByIndex(birdIndex: Int((bird?.index)!)).count
        let alert = UIAlertController(title: "Add Bird Tag", message: "Would you like to tag \(Filter.aOrAn(name: (bird?.commonName)!)) \(Filter.captitaliseFirstCharacter(aString: (bird?.commonName)!))?\nThis will be the \(Filter.ordinal(aInt: birdTags+1)) time you tag it!", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { action in
            
            print("do nothing")
        }))
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
            print("add the tag")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newBirdTag = NSEntityDescription.insertNewObject(forEntityName: "BirdTag", into: context) as! BirdTag
            newBirdTag.birdIndex = (self.bird?.index)!
            newBirdTag.isSeen = 1
            newBirdTag.latitude = self.latitude
            newBirdTag.longitude = self.longitude
            newBirdTag.date = Filter.getDate()
            
            self.initTagButton()
            Filter.writeTagToCSV()
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
    }
    
    func autoScroll(){
        let timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector("scrollPages"), userInfo: nil, repeats: true)
    }
    
    func scrollToPage(number:Int){
        let myPageWidth = pictureScrollView.frame.width
        if number != 0 {
            pictureScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(number), y:0), animated: true)
        }else{
            pictureScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(number), y:0), animated: false)
        }
    }
    
    func scrollPages(){
        scrollToPage(number: currentPage%numberOfPages)
        currentPage += 1
    }
    
    func initScreenSize(){
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        print(screenWidth)
        print(screenHeight)
    }
    
    func initScrollViewHeight(){
        
        switch screenWidth {
        case 320:
            NSLayoutConstraint(item: pictureScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 240/568, constant:0.0).isActive = true
        case 375:
            NSLayoutConstraint(item: pictureScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 280/667, constant:0.0).isActive = true
        case 414:
            NSLayoutConstraint(item: pictureScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 310/736, constant:0.0).isActive = true
        case 768:
            NSLayoutConstraint(item: pictureScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 560/1024, constant:0.0).isActive = true
        default:
            print("")
        }

    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        if let playImage = UIImage(named: "ic_play_arrow"){
            pauseButton.setImage(playImage, for: .normal)
        }
    }
    
    
}
