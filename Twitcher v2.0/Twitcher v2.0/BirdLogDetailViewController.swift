//
//  BirdLogDetailViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 2/5/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class BirdLogDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var bird:Bird? = nil
    var birdTags = [BirdTag]()
    
    @IBOutlet weak var topNavigationBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        birdTags = Filter.filterTagByIndex(birdIndex: Int(bird!.index))
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birdTags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birdLogDetailCell")!
        let birdTag = birdTags[indexPath.row]
        //cell.textLabel?.text = "\(bird!.index), No.\(indexPath.row),latitude: \(birdTag.latitude), longitude:\(birdTag.longitude), date: \(birdTag.date)"
        cell.textLabel?.text = "Number \(indexPath.row + 1): Found on \(Filter.displayDate(date:birdTag.date!))"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "birdLogDetailToTag"
        {
            let controller = segue.destination as! BirdTagDetailViewController
            if let selectedCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = indexPath.row
                controller.latitude = birdTags[selectedItem].latitude
                controller.longitude = birdTags[selectedItem].longitude
                controller.date = birdTags[selectedItem].date!
                controller.birdName = bird!.commonName!
            }
            
        }
    }
    
}
