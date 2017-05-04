//
//  AboutUsViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 22/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var topNavigationBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About Us"
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0/255, green: 204/255, blue: 255/255, alpha: 1)
        tabBarController?.tabBar.tintColor = UIColor(colorLiteralRed: 0/255, green: 204/255, blue: 255/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
