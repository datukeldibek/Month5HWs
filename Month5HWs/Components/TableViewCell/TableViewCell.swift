//
//  TableViewCell.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseId = String(describing: TableViewCell.self)
    static let nibName = String(describing: TableViewCell.self)
    
    @IBOutlet weak var imageTV: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func display(item: Product) {
        let data = try? Data(contentsOf: URL(string: item.thumbnail)!)
        imageTV.image = UIImage(data: data!)
        title.text = item.title
        rating.text = String(item.rating)
        price.text = "\(item.price)$"
        desc.text = item.description
    }
}
