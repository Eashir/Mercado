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
	
	var item: Item!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		photoImageView.sd_cancelCurrentImageLoad()
		
	}
	
	func configure(_ item: Item) {
		self.item = item
		nameLabel.text = item.name
//		detailLabel.text = String(item.amount)
		
		Item.getImage(id: item.id) { (urlString) in
			let imageURL = URL(string: urlString)
			self.photoImageView.sd_setImage(with: imageURL)
		}
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.accessoryType = selected ? .checkmark : .none
	}
	
}
