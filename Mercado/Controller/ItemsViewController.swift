//
//  ItemsViewController.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
	
	var items = [Item]()
	let ItemCellIdentifier = "ItemCell"
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.allowsMultipleSelection = true
		tableView.allowsMultipleSelectionDuringEditing = true
		
		Item.getItems { (items) in
			guard let validItems = items else {
				return
			}
			self.items = validItems
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	
	}
	
}

// MARK: - UITableViewDataSource

extension ItemsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ItemCellIdentifier, for: indexPath) as! ItemTableViewCell
		cell.configure(items[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}
	
}

// MARK: - UITableViewDelegate

extension ItemsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = items[indexPath.row]
		let cell = tableView.cellForRow(at: indexPath)
		if cell!.isSelected {
			CheckoutCart.shared.addItem(item)
		} else {
			CheckoutCart.shared.removeItem(item)
		}
	}
	
}

	

