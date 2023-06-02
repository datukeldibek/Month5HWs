//
//  CollectionViewBCell.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseId = String(describing: CategoryCollectionViewCell.self)
    static let nibName = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    func display(category: Category) {
        imageView.image = UIImage(named: category.image)
        textLabel.text = category.title
    }

}
