//
//  ItemTableViewCell.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {
	
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		photoImageView.sd_cancelCurrentImageLoad()
	}
	
	func configure(_ item: Item) {
		nameLabel.text = item.name
//		detailLabel.text = String(item.amount)
		
		Item.getImage(id: item.id) { (urlString) in
			let imageURL = URL(string: urlString)
			self.photoImageView.sd_setImage(with: imageURL)
		}
	}
	
}
