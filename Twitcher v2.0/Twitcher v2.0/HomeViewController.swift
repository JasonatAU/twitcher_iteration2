//
//  HomeViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 29/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var birdLogButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleButton.isEnabled = false
        initButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Filter(_ sender: UIButton) {
        
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
}
