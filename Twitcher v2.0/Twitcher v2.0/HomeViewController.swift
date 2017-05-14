//
//  HomeViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 29/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var birdLogButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var birdLogLabel: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var aboutUsLabel: UILabel!
    
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    var imageArray = [UIImage]()
    var birds = [Bird]()
    var listBirds = [Bird]()
    var birdIndexs = [Int]()
    var currentPage = 0
    var numberOfPages = 0
    var bird:Bird? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScrollView.delegate = self
        initScrollViewHeight()
        addPicturesToScrollView()
        pageController.numberOfPages = imageArray.count
        autoScroll()
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0/255, green: 204/255, blue: 255/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addPicturesToScrollView(){
        loadBird()
        //homeScrollView.frame = view.frame
        
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
            imageView.frame = CGRect(x: xPosition, y: 0, width: width, height: height)
            imageView.contentMode = .scaleToFill
            
            homeScrollView.contentSize.width = width * CGFloat( j + 1)
            homeScrollView.addSubview(imageView)
            numberOfPages += 1
        }
    }
    
    func loadBird(){
        getRandomBirds()
        
        for bird in birds{
            for i in 0..<5{
                if let image = UIImage(named: "\(bird.index)_\(i)"){
                    imageArray.append(image)
                    listBirds.append(bird)
                    break
                }else{
                    print("image \(bird.index)_\(i) was not found")
                }
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
    
    func getRandomBirds(){
        let allBirds = Filter.getData()
        var randomNumber = 0
        while(birdIndexs.count < 10){
            randomNumber = Int(arc4random_uniform(230))
            while(!birdIndexs.contains(randomNumber)){
                birdIndexs.append(randomNumber)
            }
        }
        for i in birdIndexs {
            birds.append(allBirds[i])
        }
    }
    
    func initButtonsForIphone(){
        
        filterButton.frame = CGRect(x: 16, y: 342, width: 123, height: 68)
        filterButton.layer.cornerRadius = 0.1 * filterButton.bounds.size.width
        
        birdLogButton.frame = CGRect(x: 16, y: 422, width: 123, height: 68)
        birdLogButton.layer.cornerRadius = 0.1 * birdLogButton.bounds.size.width
        
        searchButton.frame = CGRect(x: 16, y: 502, width: 123, height: 68)
        searchButton.layer.cornerRadius = 0.1 * searchButton.bounds.size.width
        
        aboutUsButton.frame = CGRect(x: 16, y: 582, width: 123, height: 68)
        aboutUsButton.layer.cornerRadius = 0.1 * aboutUsButton.bounds.size.width
        
        discoverLabel.frame = CGRect(x: 150, y: 342, width: 212, height: 68)
        birdLogLabel.frame = CGRect(x: 150, y: 422, width: 212, height: 68)
        searchLabel.frame = CGRect(x: 150, y: 502, width: 212, height: 68)
        aboutUsLabel.frame = CGRect(x: 150, y: 582, width: 212, height: 68)
    }
    
    func initButtonsForPlus(){
        
        filterButton.frame = CGRect(x: 16, y: 382, width: 140, height: 68)
        filterButton.layer.cornerRadius = 0.1 * filterButton.bounds.size.width

        birdLogButton.frame = CGRect(x: 16, y: 472, width: 140, height: 68)
        birdLogButton.layer.cornerRadius = 0.1 * birdLogButton.bounds.size.width
        
        searchButton.frame = CGRect(x: 16, y: 562, width: 140, height: 68)
        searchButton.layer.cornerRadius = 0.1 * searchButton.bounds.size.width
        
        aboutUsButton.frame = CGRect(x: 16, y: 652, width: 140, height: 68)
        aboutUsButton.layer.cornerRadius = 0.1 * aboutUsButton.bounds.size.width
        
        discoverLabel.frame = CGRect(x: 170, y: 382, width: 234, height: 68)
        birdLogLabel.frame = CGRect(x: 170, y: 472, width: 234, height: 68)
        searchLabel.frame = CGRect(x: 170, y: 562, width: 234, height: 68)
        aboutUsLabel.frame = CGRect(x: 170, y: 652, width: 234, height: 68)
    }
    
    func initButtonsForSE(){
        
        filterButton.frame = CGRect(x: 16, y: 322, width: 110, height: 50)
        filterButton.layer.cornerRadius = 0.1 * filterButton.bounds.size.width

        birdLogButton.frame = CGRect(x: 16, y: 382, width: 110, height: 50)
        birdLogButton.layer.cornerRadius = 0.1 * birdLogButton.bounds.size.width
        
        searchButton.frame = CGRect(x: 16, y: 442, width: 110, height: 50)
        searchButton.layer.cornerRadius = 0.1 * searchButton.bounds.size.width
        
        aboutUsButton.frame = CGRect(x: 16, y: 502, width: 110, height: 50)
        aboutUsButton.layer.cornerRadius = 0.1 * aboutUsButton.bounds.size.width
        
        discoverLabel.frame = CGRect(x: 135, y: 322, width: 170, height: 50)
        birdLogLabel.frame = CGRect(x: 135, y: 382, width: 170, height: 50)
        searchLabel.frame = CGRect(x: 135, y: 442, width: 170, height: 50)
        aboutUsLabel.frame = CGRect(x: 135, y: 502, width: 170, height: 50)
    }
    
    func initButtonsForIpad(){
        
        filterButton.frame = CGRect(x: 16, y: 620, width: 150, height: 75)
        filterButton.layer.cornerRadius = 0.1 * filterButton.bounds.size.width
        
        birdLogButton.frame = CGRect(x: 16, y: 715, width: 150, height: 75)
        birdLogButton.layer.cornerRadius = 0.1 * birdLogButton.bounds.size.width
        
        searchButton.frame = CGRect(x: 16, y: 810, width: 150, height: 75)
        searchButton.layer.cornerRadius = 0.1 * searchButton.bounds.size.width
        
        aboutUsButton.frame = CGRect(x: 16, y: 905, width: 150, height: 75)
        aboutUsButton.layer.cornerRadius = 0.1 * aboutUsButton.bounds.size.width
        
        discoverLabel.frame = CGRect(x: 180, y: 620, width: 500, height: 75)
        birdLogLabel.frame = CGRect(x: 180, y:715, width: 500, height: 75)
        searchLabel.frame = CGRect(x: 180, y: 810, width: 500, height: 75)
        aboutUsLabel.frame = CGRect(x: 180, y: 905, width: 500, height: 75)
    }
    
    func makeCircle(button:UIButton){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let myPageWidth = homeScrollView.frame.width
        let number = currentPage%numberOfPages
        let page = homeScrollView.contentOffset.x / homeScrollView.frame.size.width
        pageController.currentPage = Int(page)
        currentPage = Int(page)
        if homeScrollView.contentOffset.x > homeScrollView.frame.size.width*CGFloat(numberOfPages-1) {
            homeScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(0), y:0), animated: true)
            currentPage = 0
        }
        if homeScrollView.contentOffset.x < 0 {
            homeScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(numberOfPages-1), y:0), animated: true)
            currentPage -= 1
        }
    }
    
    func autoScroll(){
        let timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector("scrollPages"), userInfo: nil, repeats: true)
    }
    
    func scrollToPage(number:Int){
        let myPageWidth = homeScrollView.frame.width
        if number != 0 {
            homeScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(number), y:0), animated: true)
        }else{
            homeScrollView.setContentOffset(CGPoint(x:myPageWidth*CGFloat(number), y:0), animated: false)
        }
    }
    
    func scrollPages(){
        scrollToPage(number: currentPage%numberOfPages)
        currentPage += 1
    }
    
    @IBAction func tapScrollView(_ sender: UITapGestureRecognizer) {
        let page = Int(homeScrollView.contentOffset.x / homeScrollView.frame.size.width)
        bird = listBirds[page]
        self.performSegue(withIdentifier: "homeToDetail", sender: bird)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToDetail"
        {
            if let oneBird = sender as? Bird{
                let controller = segue.destination as! SearchDetailViewController
                controller.bird = oneBird
            }else{
                let controller = segue.destination as! SearchDetailViewController
                controller.bird = bird!
            }
        }
    }
    
    func initScrollViewHeight(){
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        print(screenWidth)
        print(screenHeight)
        
        switch screenWidth {
        case 320:
            print("This is an Iphone SE")
            NSLayoutConstraint(item: homeScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 215/568, constant:0.0).isActive = true
            initButtonsForSE()
        case 375:
            print("This is an Iphone")
            NSLayoutConstraint(item: homeScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 250/667, constant:0.0).isActive = true
            initButtonsForIphone()
        case 414:
            print("This is an Iphone plus")
            NSLayoutConstraint(item: homeScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 276/736, constant:0.0).isActive = true
            initButtonsForPlus()
        case 768:
            print("This is an Ipad")
            NSLayoutConstraint(item: homeScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute:.height, multiplier: 512/1024, constant:0.0).isActive = true
            initButtonsForIpad()
        default:
            print("")
        }
    }
    
    
    
    
    
    
    
}
