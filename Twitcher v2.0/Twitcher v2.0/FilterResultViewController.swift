//
//  FilterResultViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 21/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class FilterResultViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topNavigationBar: UINavigationItem!
    
    var birds = [Bird]()
    var bird:Bird? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if birds.count == 1{
            performSegue(withIdentifier: "filterCellToDetail", sender: birds[0])
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bird = birds[indexPath.row]
        
        // common table view cell for backup
        //let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")!
        //cell.textLabel?.text = bird.commonName
        //cell.detailTextLabel?.text = bird.scientificName
        
        
        var image = UIImage()
        if let image0 = UIImage(named: "\(bird.index)_0"){
            image = image0
        }else{
            image = UIImage(named: "noImage")!
        }
        let cell = Bundle.main.loadNibNamed("LargePictureTableViewCell", owner: self, options: nil)?.first as! LargePictureTableViewCell
        cell.mianImageView.image = image
        cell.mainLabel.text = Filter.captitaliseFirstCharacter(aString: bird.commonName!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bird = birds[indexPath.row]
        self.performSegue(withIdentifier: "filterCellToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 281
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterCellToDetail"
        {
            //let nav = segue.destination as! UINavigationController
            //let controller = nav.viewControllers[0] as! SearchDetailViewController
            
            if let oneBird = sender as? Bird{
                let controller = segue.destination as! SearchDetailViewController
                controller.bird = oneBird
            }else{
                let controller = segue.destination as! SearchDetailViewController
                controller.bird = bird!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
