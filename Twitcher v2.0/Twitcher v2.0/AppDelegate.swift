//
//  AppDelegate.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 9/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        preloadBirdTag()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Twitcher_v2_0")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("change has been saved")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Read data from CSV file
    
    func parseCSV () -> [(
        theIndex:Int,
        commonName:String,
        ScientificName:String,
        category:String,
        order:String,
        family:String,
        colour1:String,
        colour2:String,
        colour3:String,
        minLength:Int,
        maxLength:Int,
        minWeight:Int,
        maxWeight:Int,
        birdDescription:String,
        diet:String,
        isInVic:Int,
        isInNsw:Int,
        isInQld:Int,
        isInAct:Int,
        isInNt:Int,
        isInSa:Int,
        isInTas:Int,
        isInWa:Int,
        isSeen:Int
        )]? {
        
        
        var arrayBirds = NSMutableArray()
            
            //create vars for each column
                    
            var theIndex:Int
            var commonName:String
            var ScientificName:String
            var category:String
            var order:String
            var family:String
            var colour1:String
            var colour2:String
            var colour3:String
            var minLength:Int
            var maxLength:Int
            var minWeight:Int
            var maxWeight:Int
            var birdDescription:String
            var diet:String
            var isInVic:Int
            var isInNsw:Int
            var isInQld:Int
            var isInAct:Int
            var isInNt:Int
            var isInSa:Int
            var isInTas:Int
            var isInWa:Int
            var isSeen:Int
            
            
            
            //test the new CSV parser
            if let path = Bundle.main.path(forResource: "birdListVersion6", ofType: "csv")
            {
            do {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let csv = CSwiftV(with:data)
                let rows = csv.rows
                //print(rows.count)
                // get every row in csv
                for birdInfo in rows {
                    //print(row) // ["first column", "sceond column", "third column"]
                    if Int(birdInfo[1]) != nil{
                        theIndex = Int(birdInfo[1])!
                    }else{
                        theIndex = -1
                    }
                    
                    if birdInfo[2] != ""{
                        commonName = birdInfo[2].lowercased()
                    }else{
                        commonName = "no value"
                    }
                    
                    if birdInfo[3] != ""{
                        ScientificName = birdInfo[3].lowercased()
                    }else{
                        ScientificName = "no value"
                    }
                    
                    if birdInfo[4] != ""{
                        category = birdInfo[4]
                    }else{
                        category = "no value"
                    }
                    
                    if birdInfo[5] != ""{
                        order = birdInfo[5]
                    }else{
                        order = "no value"
                    }
                    
                    if birdInfo[6] != ""{
                        family = birdInfo[6]
                    }else{
                        family = "no value"
                    }
                    
                    if birdInfo[7] != ""{
                        colour1 = birdInfo[7]
                    }else{
                        colour1 = "no value"
                    }
                    
                    if birdInfo[8] != ""{
                        colour2 = birdInfo[8]
                    }else{
                        colour2 = "no value"
                    }
                    
                    if birdInfo[9] != ""{
                        colour3 = birdInfo[9]
                    }else{
                        colour3 = "no value"
                    }
                    
                    
                    if birdInfo[10] != ""{
                        minLength = Int(Double(birdInfo[10])!)
                    }else{
                        minLength = 0
                    }
                    
                    if birdInfo[11] != ""{
                        maxLength = Int(Double(birdInfo[11])!)
                    }else{
                        maxLength = 500
                    }
                    
                    if birdInfo[12] != ""{
                        minWeight = Int(Double(birdInfo[12])!)
                    }else{
                        minWeight = 0
                    }
                    
                    if birdInfo[13] != ""{
                        maxWeight = Int(Double(birdInfo[13])!)
                    }else{
                        maxWeight = 100000
                    }
                    
                    if birdInfo[15] != ""{
                        birdDescription = birdInfo[15]
                    }else{
                        birdDescription = "no value"
                    }
                    
                    if birdInfo[16] != ""{
                        diet = birdInfo[16]
                    }else{
                        diet = "no value"
                    }
                    
                    if birdInfo[18] == "1.0"{
                        isInVic = 1
                    }else{
                        isInVic = 0
                    }
                    
                    if birdInfo[19] == "1.0"{
                        isInNsw = 1
                    }else{
                        isInNsw = 0
                    }
                    
                    if birdInfo[20] == "1.0"{
                        isInQld = 1
                    }else{
                        isInQld = 0
                    }
                    
                    if birdInfo[21] == "1.0"{
                        isInAct = 1
                    }else{
                        isInAct = 0
                    }
                    
                    if birdInfo[22] == "1.0"{
                        isInNt = 1
                    }else{
                        isInNt = 0
                    }
                    
                    if birdInfo[23] == "1.0"{
                        isInSa = 1
                    }else{
                        isInSa = 0
                    }
                    
                    if birdInfo[24] == "1.0"{
                        isInTas = 1
                    }else{
                        isInTas = 0
                    }
                    
                    if birdInfo[25] == "1.0"{
                        isInWa = 1
                    }else{
                        isInWa = 0
                    }
                    
                    if birdInfo[26] == "1.0"{
                        isSeen = 1
                    }else{
                        isSeen = 0
                    }
                    
                    let bird = (theIndex:theIndex, commonName:commonName, ScientificName:ScientificName, category:category, order:order, family:family, colour1:colour1, colour2:colour2, colour3:colour3, minLength:minLength, maxLength:maxLength, minWeight:minWeight, maxWeight:maxWeight, birdDescription:birdDescription, diet:diet, isInVic:isInVic, isInNsw:isInNsw, isInQld:isInQld, isInAct:isInAct, isInNt:isInNt, isInSa:isInSa, isInTas:isInTas, isInWa:isInWa, isSeen:isSeen)
                    
                    arrayBirds.add(from: bird)
                }
                // get row by int subscript
                //csv[10] // the No.10 row
                
                // get column by string subscript
                //csv["id"] // column with header key "id"
                
            }catch {
                // Error handing
            }
            }

            return (arrayBirds as! [(theIndex: Int, commonName: String, ScientificName: String, category: String, order: String, family: String, colour1: String, colour2: String, colour3: String, minLength: Int, maxLength: Int, minWeight:Int, maxWeight:Int, birdDescription: String, diet: String, isInVic: Int, isInNsw: Int, isInQld: Int, isInAct: Int, isInNt: Int, isInSa: Int, isInTas: Int, isInWa: Int, isSeen: Int)])
    }
    
    //MARK: - Remove all data in core data
    
    func removeData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var birds = [Bird]()
        do {
            birds = try context.fetch(Bird.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        
        if !birds.isEmpty {
            for task in birds {
                context.delete(task)
            }
        }
    }
    
    
    //MARK: - Preload data from file to core data
    func preloadData(){
        removeData()
        let rawBirds = parseCSV()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for rawBird in rawBirds!{
            
            let newBird = NSEntityDescription.insertNewObject(forEntityName: "Bird", into: context) as! Bird
            //newBird.name = rawTask.name
            newBird.index = Int16(rawBird.theIndex)
            newBird.commonName = rawBird.commonName
            newBird.scientificName = rawBird.ScientificName
            newBird.category = rawBird.category
            newBird.order = rawBird.order
            newBird.family = rawBird.family
            // test for new fetch function
            newBird.colour1 = rawBird.colour1.lowercased() + " " + rawBird.colour2.lowercased() + " " + rawBird.colour3.lowercased() + " "
            //newBird.colour1 = rawBird.colour1
            //newBird.colour2 = rawBird.colour2
            newBird.colour3 = rawBird.colour3
            newBird.minLength = Int16(rawBird.minLength)
            newBird.maxLength = Int16(rawBird.maxLength)
            newBird.minWeight = Int32(rawBird.minWeight)
            newBird.maxWeight = Int32(rawBird.maxWeight)
            newBird.birdDescription = rawBird.birdDescription
            newBird.diet = rawBird.diet
            newBird.isInVic = Int16(rawBird.isInVic)
            newBird.isInNsw = Int16(rawBird.isInNsw)
            newBird.isInQld = Int16(rawBird.isInQld)
            newBird.isInAct = Int16(rawBird.isInAct)
            newBird.isInNt = Int16(rawBird.isInNt)
            newBird.isInSa = Int16(rawBird.isInSa)
            newBird.isInTas = Int16(rawBird.isInTas)
            newBird.isInWa = Int16(rawBird.isInWa)
            newBird.isSeen = Int16(rawBird.isSeen)
            
            var location = ""
            if rawBird.isInVic == 1{
                location += "vic "
            }
            if rawBird.isInNsw == 1{
                location += "nsw "
            }
            if rawBird.isInQld == 1{
                location += "qld "
            }
            if rawBird.isInAct == 1{
                location += "act "
            }
            if rawBird.isInNt == 1{
                location += "nt "
            }
            if rawBird.isInSa == 1{
                location += "sa "
            }
            if rawBird.isInTas == 1{
                location += "tas "
            }
            if rawBird.isInWa == 1{
                location += "wa "
            }
            newBird.colour2 = location
        }
    }
    
    func preloadBirdTag(){
        removeBirdTag()
        let rawBirdTags = readBirdTag()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for rawBirdTag in rawBirdTags{
            
            let newBirdTag = NSEntityDescription.insertNewObject(forEntityName: "BirdTag", into: context) as! BirdTag
            newBirdTag.birdIndex = Int16(rawBirdTag.birdTagIndex)
            newBirdTag.isSeen = Int16(rawBirdTag.isSeen)
        }
    }
    
    func removeBirdTag(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var birdTags = [BirdTag]()
        do {
            birdTags = try context.fetch(BirdTag.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        
        if !birdTags.isEmpty {
            for birdTag in birdTags {
                context.delete(birdTag)
            }
        }
    }
    
    func readBirdTag() -> [(birdTagIndex:Int, isSeen:Int)]{
        var birdTagIndex:Int
        var isSeen:Int
        var arrayBirdTags = NSMutableArray()
        
        //if let path = Bundle.main.path(forResource: "birdLogVersion1", ofType: "csv")
        if let path:String? = Filter.loadTagCsv().path
        {
            do {
                let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                let csv = CSwiftV(with:data)
                let rows = csv.rows
                print(rows)
                print(rows.count)
                // get every row in csv
                for tagInfo in rows {
                    birdTagIndex = Int(tagInfo[0])!
                    if tagInfo[1] == "1" || tagInfo[1] == "1.0"{
                        isSeen = 1
                    }else{
                        isSeen = 0
                    }
                    let birdTag = (birdTagIndex:birdTagIndex,isSeen:isSeen)
                    arrayBirdTags.add(from: birdTag)
                }
            }catch{
                // error handling
            }
        }
        return arrayBirdTags as! [(birdTagIndex:Int, isSeen:Int)]
    }
    
    func writeBirdTag(){
        
    }
}
