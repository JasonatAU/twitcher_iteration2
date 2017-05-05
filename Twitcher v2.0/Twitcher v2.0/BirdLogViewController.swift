//
//  BirdLogViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 22/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit

class BirdLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var birds = [Bird]()
    
    @IBOutlet weak var topNavigationBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        birds = Filter.readTaggedBird()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Bird Log"
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0/255, green: 204/255, blue: 255/255, alpha: 1)
        //tabBarController?.tabBar.tintColor = UIColor(colorLiteralRed: 0/255, green: 204/255, blue: 255/255, alpha: 1)
        if let rect = self.navigationController?.navigationBar.frame {
            let y = -rect.size.height - rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake( y, 0, 0, 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        birds = Filter.readTaggedBird()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birdLogCell")!
        
        let bird = birds[indexPath.row]
        
        // choose a picture from the picture list, if fail, choose the default one.
        var image = UIImage()
        
        for i in 0...4{
            if let image0 = UIImage(named: "\(bird.index)_\(i)"){
                image = image0
                break
            }else{
                image = UIImage(named: "noImage")!
            }
        }
        
        let newImage = ImageHandler.resizeImage(image: image, targetSize: CGSize(width:1000, height:667))
        
        cell.textLabel?.text = Filter.captitaliseFirstCharacter(aString: bird.commonName!)
        cell.detailTextLabel?.text = "\(Filter.filterTagByIndex(birdIndex: Int(bird.index)).count) Tags"
        cell.imageView?.image = newImage
        cell.imageView?.contentMode = .scaleToFill
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "birdLogCellToDetail"
        {
            let controller = segue.destination as! BirdLogDetailViewController
            if let selectedCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = indexPath.row
                controller.bird = birds[selectedItem]
            }
            
        }
    }
}
