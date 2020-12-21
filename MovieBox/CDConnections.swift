//
//  CDConnections.swift
//  MovieBox
//
//  Created by Ahmed Tarek on 8/7/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//
import UIKit
import Foundation
import CoreData

func isAttributeExist(Title: String) -> Bool {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesC")
    fetchRequest.predicate = NSPredicate(format: "title == %@" , Title)
    let res = try! managedContext.fetch(fetchRequest)
    if res.count > 0{
        print("Data Exist")
        return true
    }else{
        print("Data Not Exist")
        return false
    }
}

func CDInsertion(Title: String, Rating: Float, releaseYear: String , Genre: [String], Image: UIImage, OverView: String){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "MoviesC" , in: managedContext)
    let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
    
    movie.setValue(Title, forKey: "title")
    movie.setValue(Rating, forKey: "rating")
    movie.setValue(releaseYear, forKey: "releaseyear")
    movie.setValue(Genre, forKey: "genre")
    movie.setValue(OverView, forKey: "overview")
    
    let imgData = Image.jpegData(compressionQuality: 1)
    movie.setValue(imgData, forKey: "image")
    do{
        try managedContext.save()
    }catch{print("error")}

    print("Data Inserted")
}

func CDDeletion(Title: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest : NSFetchRequest<MoviesC> = MoviesC.fetchRequest()
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "title == %@" , Title)
    let objs = try! managedContext.fetch(fetchRequest)
    for i in objs{
        managedContext.delete(i)
                }
}

func CDFetching() -> (Array<Dictionary<String,Any>>){
    
    var Movies : Array<Dictionary<String,Any>>=[]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesC")
    fetchRequest.returnsObjectsAsFaults = false
    let MovD = try! managedContext.fetch(fetchRequest)
    
    for i in 0..<MovD.count{
        let genre : Array<String> = (MovD[i] as AnyObject).value(forKey: "genre") as! Array
        
        Movies.append(["title":(MovD[i] as AnyObject).value(forKey: "title")!,"vote_average":(MovD[i] as AnyObject).value(forKey: "rating")!,"release_date":(MovD[i] as AnyObject).value(forKey: "releaseyear")!,"poster_path":(MovD[i] as AnyObject).value(forKey: "image")!,"overview":(MovD[i] as AnyObject).value(forKey: "overview")!,"genre":genre])
    }
    return Movies
}

func CDFetchAndPrintInConsole(Title: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesC")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "title == %@" , Title)
                let res = try! managedContext.fetch(fetchRequest)
                print(res)

}
