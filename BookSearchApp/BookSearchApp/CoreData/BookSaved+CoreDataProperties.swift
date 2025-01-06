//
//  BookSaved+CoreDataProperties.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 1/1/25.
//
//

import Foundation
import CoreData


extension BookSaved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookSaved> {
        return NSFetchRequest<BookSaved>(entityName: "BookSaved")
    }

    @NSManaged public var title: String?
    @NSManaged public var authors: String?
    @NSManaged public var price: String?
    @NSManaged public var isbn: String?

}

extension BookSaved : Identifiable {

}
