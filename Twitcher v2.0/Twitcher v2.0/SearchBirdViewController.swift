//
//  SearchBirdViewController.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 9/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        let scroll: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        scroll.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(scroll)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class SearchBirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var birds : [Bird] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.searchBarSetup()
        //get the data from core data
        getData()
        //reload the table
        tableView.reloadData()
        // hide the keyboard
        self.hideKeyboardWhenTappedAround()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func searchBarSetup(){
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty{
            getData()
            self.tableView.reloadData()
        }else{
            searchByKeyWord(keyWord: searchText)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")!
        
        let bird = birds[indexPath.row]
        
        // choose a picture from the picture list, if fail, choose the default one.
        var image = UIImage()
        if let image0 = UIImage(named: "\(bird.index)_0"){
            image = image0
        }else{
            image = UIImage(named: "noImage")!
        }
        let newImage = ImageHandler.resizeImage(image: image, targetSize: CGSize(width:1000, height:667))
        
        cell.textLabel?.text = bird.commonName
        cell.imageView?.image = newImage
        cell.imageView?.contentMode = .scaleToFill
        return cell
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            birds = try context.fetch(Bird.fetchRequest())
            print(birds.count)
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func searchByKeyWord(keyWord: String){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bird")
        let commonNamePredicate = NSPredicate(format:"commonName contains %@", keyWord.lowercased())
        let scientificNamePredicate = NSPredicate(format:"scientificName contains %@", keyWord.lowercased())
        let predicate = NSCompoundPredicate(type: .or, subpredicates: [commonNamePredicate, scientificNamePredicate])
        request.predicate = predicate
        
        do {
            birds = try context.fetch(request) as! [Bird]
            print(birds.count)
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue"
        {
            let controller = segue.destination as! SearchDetailViewController
            if let selectedCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = indexPath.row
                controller.bird = birds[selectedItem]
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
