//
//  BookCell.swift
//  Kindle
//
//  Created by Oleg Kudimov on 3/17/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            
            guard  let coverImageUrl = book?.coverImageUrl else { return }
             
            guard let url = URL(string: coverImageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                
                if let err = error {
                    print("Failed to retrieve our book cover images: ", err)
                    return
                }
                
                guard let imageData = data else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
                
                
            }.resume()
        }
    }
    
    private let coverImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "This is the title for the title of our book inside our cell"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
      
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "This is some author for the book that we have in this row"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        // add image cover
        addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        // add titleLabel
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        
        // add authorLabel
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
