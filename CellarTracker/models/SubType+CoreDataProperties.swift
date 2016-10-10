//
//  SubType+CoreDataProperties.swift
//  CellarTracker
//
//  Created by Damien Bannerot on 29/09/2016.
//  Copyright © 2016 Damien Bannerot. All rights reserved.
//

import Foundation
import CoreData
import 

extension SubType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubType> {
        return NSFetchRequest<SubType>(entityName: "SubType");
    }

    @NSManaged public var value: String?
    @NSManaged public var typeSubType: Type?

}
