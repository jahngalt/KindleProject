//
//  ViewController.swift
//  Kindle
//
//  Created by Oleg Kudimov on 2/25/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit



class ViewController: UITableViewController {

    var books: [Book]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellid")
        
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Kindle"
       
        setupBooks()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: bookPageController)
        present(navController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        cell.book = book
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = books?.count {
            return count
        }
        
        return 0
        
    }
    
    func setupBooks() {
        let page1 = Page(number: 1, text: "Some text for page 1")
        let page2 = Page(number: 2, text: "Another text for page 2")
        
        let pages = [page1, page2]
         
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steve"), pages: pages)
        
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Bechcraft", image: #imageLiteral(resourceName: "bill"), pages: [
        Page(number: 1, text: "Text for page 1"),
        Page(number: 2, text: "Text for page 2"),
        Page(number: 3, text: "Text for page 3"),
        Page(number: 4, text: "Text for page 4")
        ])
        
        self.books = [book, book2]
    }
}

