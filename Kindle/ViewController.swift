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
        
        setupNavigationBarStyles()
        setupNavigationBarButtons()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellid")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        navigationItem.title = "Kindle"
        fetchBooks()
        
        
    }
    
    //Setting footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        
        segmentedControl.tintColor = .black
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(segmentedControl)
        
        //Constraints
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        //Grid button
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "icons8-data-grid-50").withRenderingMode(.alwaysOriginal), for: .normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(gridButton)
        
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        //Sort button
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "icons8-up-down-arrow-50-2").withRenderingMode(.alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)
        
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func setupNavigationBarButtons() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonIconPress))
    }
    
    @objc func handleMenuPress() {
        print("Menu pressed")
    }
    
    @objc func handleAmazonIconPress() {
        print("Amazon icon pressed")
    }
    
    
    func setupNavigationBarStyles() {

        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func fetchBooks() {
        print("fetching data...")
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Failed to fetch external json books: ", err)
                    return
                }

                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    guard let bookDictionaries = json as? [[String: Any]] else { return }
                    
                    self.books = []
                    for bookDictionary in bookDictionaries {
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                    print("Failed to parse JSON properly: ", jsonError)
                }
            }.resume()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
//        print(book?.title)
//        return
        
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        
        bookPageController.book = selectedBook
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
    
}

