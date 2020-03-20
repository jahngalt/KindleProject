//
//  Models.swift
//  Kindle
//
//  Created by Oleg Kudimov on 3/13/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let pages: [Page]
    let coverImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""

        
        var bookPage = [Page]()
        
        if let pagesDictionaries = dictionary["pages"] as? [[String: Any ]] {
            for pageDictionary in pagesDictionaries {
                if let pageText = pageDictionary["text"] as? String {
                    let page = Page(number: 1, text: pageText)
                    bookPage.append(page)
                }
            }
        }
        pages = bookPage
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
        
            
    }
}
