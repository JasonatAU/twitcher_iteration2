//
//  Filter.swift
//  Twitcher v2.0
//
//  Created by Qiuye Jin on 20/4/17.
//  Copyright © 2017 Qiuye Jin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Filter{
    
    
    
    class func filterBySize(size:String, colours:[String]) -> [Bird]{
        return checkBirdsByColours(options: colours)
    }
    
    class func filterByColour(colours:[String]) -> [Bird]{
        return checkBirdsByColours(options: colours)
    }
    
    class func filterByLocation(colours:[String], size:String, locations:[String]) -> [Bird]{
        return checkBirdsByColours(options: colours)
    }
    
    class func getData() -> [Bird]{
        var birds = [Bird]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try birds = context.fetch(Bird.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        
        return birds
    }
    
    // MARK: functions for filtering by colours
    
    class func checkBirdsByColours(options: [String]) -> [Bird]{
        if options.count > 3{
            return [Bird]()
        }
        if options.count == 1{
            return oneOption(options: options)
        }
        if options.count == 2{
            return twoOption(options: options)
        }
        if options.count == 3{
            return threeOption(options: options)
        }
        return getData()
    }
    
    class func oneOption(options:[String]) -> [Bird]{
        var result = [Bird]()
        let birds = getData()
        for bird in birds{
            if bird.colour1 == options[0] || bird.colour2 == options[0] || bird.colour2 == options[0]{
                result.append(bird)
            }
        }
        return result
    }
    
    class func twoOption(options:[String]) -> [Bird]{
        var result = [Bird]()
        
        
        return result
    }
    
    class func threeOption(options:[String]) -> [Bird]{
        var result = [Bird]()
        
        
        return result
    }
    
    // MARK: test for new colour search based on fetch
    class func filterByColours(options: [String]) -> [Bird]{
        var birds = [Bird]()
        var colour1 = " "
        var colour2 = " "
        var colour3 = " "
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bird")
        if options.count == 0{
            return getData()
        }
        if options.count == 1{
            colour1 = options[0]
        }
        if options.count == 2{
            colour1 = options[0]
            colour2 = options[1]
        }
        if options.count == 3{
            colour1 = options[0]
            colour2 = options[1]
            colour3 = options[2]
        }
        if options.count > 3{
            return [Bird]()
        }
        
        
        
        let colour1Predicate = NSPredicate(format:"colour1 contains %@", colour1.lowercased())
        let colour2Predicate = NSPredicate(format:"colour1 contains %@", colour2.lowercased())
        let colour3Predicate = NSPredicate(format:"colour1 contains %@", colour3.lowercased())
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [colour1Predicate, colour2Predicate, colour3Predicate])
        request.predicate = predicate
        
        do {
            
            //birds = try context.fetch(predicate)
            birds = try context.fetch(request) as! [Bird]
            print(birds.count)
        }
        catch {
            print("Fetching Failed")
        }
        
        return birds
    }
    
    
    
    
    
    // MARK: functions for filtering by size
    
    class func filterByColourAndSize(options:[String], size:String){
        var minimam = 0;
        var maximam = 0;
        
        switch size {
        case "Small":
            minimam = 0
            maximam = 20
        case "Medium":
            minimam = 21
            maximam = 50
        case "Big":
            minimam = 101
            maximam = 150
        case "Huge":
            minimam = 151
            maximam = 500
        default:
            minimam = 0
            maximam = 1000
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bird")

    }
    
    class func filter(colours:[String], size:String, locations:[String]) ->[Bird]{
        var birds = [Bird]()
        var colour1 = " "
        var colour2 = " "
        var colour3 = " "
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bird")
        
        // if nothing is chosen, return the whole list
        if colours.isEmpty && size == "" && locations.isEmpty{
            return getData()
        }
        
        // assign colours value to 3 colour options
        if colours.count == 0{
            //return getData()
        }
        if colours.count == 1{
            colour1 = colours[0]
        }
        if colours.count == 2{
            colour1 = colours[0]
            colour2 = colours[1]
        }
        if colours.count == 3{
            colour1 = colours[0]
            colour2 = colours[1]
            colour3 = colours[2]
        }
        if colours.count > 3{
            return [Bird]()
        }
        // generate 3 colour predicate
        let colour1Predicate = NSPredicate(format:"colour1 contains %@", colour1.lowercased())
        let colour2Predicate = NSPredicate(format:"colour1 contains %@", colour2.lowercased())
        let colour3Predicate = NSPredicate(format:"colour1 contains %@", colour3.lowercased())
        
        // assign value to minimam and maximam value of size based on size
        var minimam = 0;
        var maximam = 0;
        
        switch size {
        case "small":
            minimam = 0
            maximam = 30
        case "medium":
            minimam = 20
            maximam = 60
        case "large":
            minimam = 40
            maximam = 120
        case "huge":
            minimam = 80
            maximam = 500
        default:
            minimam = 0
            maximam = 1000
        }
        
        // generate 2 size predicate
        
        let size1Predicate = NSPredicate(format:"minLength >= %@", NSNumber(value: Int16(minimam)))
        let size2Predicate = NSPredicate(format:"maxLength <= %@", NSNumber(value: Int16(maximam)))
        
        // use the locations in locations to generate predicates
        let location1Predicate = NSPredicate(format: "colour2 contains %@", locations[0].lowercased())
        let location2Predicate = NSPredicate(format: "colour2 contains %@", locations[1].lowercased())
        let location3Predicate = NSPredicate(format: "colour2 contains %@", locations[2].lowercased())
        let location4Predicate = NSPredicate(format: "colour2 contains %@", locations[3].lowercased())
        let location5Predicate = NSPredicate(format: "colour2 contains %@", locations[4].lowercased())
        let location6Predicate = NSPredicate(format: "colour2 contains %@", locations[5].lowercased())
        let location7Predicate = NSPredicate(format: "colour2 contains %@", locations[6].lowercased())
        let location8Predicate = NSPredicate(format: "colour2 contains %@", locations[7].lowercased())
        
        // assign those completed predicates to predicate
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [colour1Predicate, colour2Predicate, colour3Predicate, size1Predicate, size2Predicate, location1Predicate, location2Predicate, location3Predicate, location4Predicate, location5Predicate, location6Predicate, location7Predicate, location8Predicate])
        request.predicate = predicate
        
        do {
            birds = try context.fetch(request) as! [Bird]
            print(birds.count)
        }
        catch {
            print("Fetching Failed")
        }
        
        return birds
    }
    
}
