//
//  Restaurant+CoreDataProperties.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/9.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant");
    }

    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var rating: String?
    @NSManaged public var location: String
    @NSManaged public var isVisited: Bool
    @NSManaged public var image: NSData?

}
