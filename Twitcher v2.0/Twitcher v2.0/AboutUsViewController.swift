//
//  AboutUsViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 22/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    
    @IBOutlet weak var link1: UIButton!
    @IBOutlet weak var dataLabel1: UILabel!
    @IBOutlet weak var label22: UILabel!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var label33: UILabel!
    @IBOutlet weak var button33: UIButton!
    
    
    
    @IBOutlet weak var topNavigationBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About Us"
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0/255, green: 204/255, blue: 255/255, alpha: 1)
        initComponents()
    }
    
    func openUrl(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }

    func initComponents(){
        dataLabel1.text = "Data Sources\nBird details and descriptions:\n©Nicole Bouglouan"
        label22.text = "Bird sounds: \nXeno-Canto licenced under CC BY-NC-SA 4.0"
        label33.text = "Bird list: \n“List of birds of Australia” by Wikipedia licenced under CC BY-SA 3.0"
        link1.setTitle("www.oiseaux-birds.com", for: .normal)
        button22.setTitle("www.xeno-canto.org", for: .normal)
        button33.setTitle("https://en.wikipedia.org/wiki/List_of_birds_of_Australia", for: .normal)
    }
    
    @IBAction func link1Tapped(_ sender: UIButton) {
        openUrl(urlStr: "http://www.oiseaux-birds.com")
    }
    
    @IBAction func link2Tapped(_ sender: UIButton) {
        openUrl(urlStr: "http://www.xeno-canto.org")
    }
    
    @IBAction func link3Tapped(_ sender: UIButton) {
        openUrl(urlStr: "https://en.wikipedia.org/wiki/List_of_birds_of_Australia")
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
