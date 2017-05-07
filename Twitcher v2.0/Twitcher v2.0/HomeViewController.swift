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
    
    var imageArray = [UIImage]()
    var birds = [Bird]()
    var birdIndexs = [Int]()
    var currentPage = 0
    var numberOfPages = 0
    var bird:Bird? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScrollView.delegate = self
        addPicturesToScrollView()
        pageController.numberOfPages = imageArray.count
        autoScroll()
        initButtons()
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
        homeScrollView.frame = view.frame
        for j in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.image = imageArray[j]
            imageView.contentMode = .scaleToFill
            let xPosition = self.view.frame.width * CGFloat(j)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.homeScrollView.frame.width, height: 250)//self.pictureScrollView.frame.height)
            
            homeScrollView.contentSize.width = homeScrollView.frame.width * CGFloat( j + 1)
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
                    break
                }else{
                    print("image \(bird.index)_\(i) was not found")
                }
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
        print(birdIndexs)
    }
    
    func initButtons(){
        //birdLogButton.frame = CGRect(x: birdLogButton.frame.origin.x, y: birdLogButton.frame.origin.y, width: 100, height: 50)
        birdLogButton.layer.cornerRadius = 0.1 * birdLogButton.bounds.size.width
        //filterButton.frame = CGRect(x: filterButton.frame.origin.x, y: filterButton.frame.origin.y, width: 100, height: 100)
        filterButton.layer.cornerRadius = 0.1 * filterButton.bounds.size.width
        searchButton.layer.cornerRadius = 0.1 * searchButton.bounds.size.width
        aboutUsButton.layer.cornerRadius = 0.1 * aboutUsButton.bounds.size.width
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
        print(page)
        bird = birds[page]
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
    
    
    
    
    
    
    
    
    
}
