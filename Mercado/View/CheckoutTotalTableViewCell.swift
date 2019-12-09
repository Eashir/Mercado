//
//  CheckoutTotalTableViewCell.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class CheckoutTotalTableViewCell: UITableViewCell {
	
	@IBOutlet var totalLabel: UILabel!
	
	func configure(with total: Int) {
		totalLabel.text = NumberFormat.format(value: total)
	}
	
}

