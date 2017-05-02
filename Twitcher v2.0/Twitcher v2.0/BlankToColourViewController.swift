//
//  BlankToColourViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 2/5/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class BlankToColourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "blankToColour", sender: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
