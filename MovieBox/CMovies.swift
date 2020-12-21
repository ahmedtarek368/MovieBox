//
//  CMovies.swift
//  MovieBox
//
//  Created by Ahmed Tarek on 8/5/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//

import UIKit
import CoreData
@objc(Movies)
class CMovies: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var image: NSData
    @NSManaged var rating: Float
    @NSManaged var releaseyear: Int
    @NSManaged var genre: [String]
}
