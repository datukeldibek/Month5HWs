//
//  CollectionViewACell.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class CollectionViewACell: UICollectionViewCell {
    static let reuseId = String(describing: CollectionViewACell.self)
    static let nibName = String(describing: CollectionViewACell.self)
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    override func layoutSubviews() {
        setUpSubViews()
        imageView.image = UIImage(systemName: "star.fill")
        textLabel.text = "Delivery"
    }
    func setUpSubViews() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .orange
        imageView.tintColor = .white
        textLabel.textColor = .white
    }
    
}
