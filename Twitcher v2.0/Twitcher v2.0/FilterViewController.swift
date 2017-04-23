//
//  FilterViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 22/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
