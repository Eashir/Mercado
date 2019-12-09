//
//  CheckoutViewController.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
	
	private enum Section: Int {
		case items = 0
		case total
		
		static func cellIdentifier(for section: Section) -> String {
			switch section {
			case .items:
				return "CheckoutItemTableViewCell"
			case .total:
				return "CheckoutTotalTableViewCell"
			}
		}
	}
	
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Checkout"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tableView.reloadData()
	}
	
	@IBAction func continueDidTap(_ sender: Any) {
		// 1
		guard CheckoutCart.shared.canPay else {
			let alertController = UIAlertController(title: "Warning", message: "Your cart is empty", preferredStyle: .alert)
			let alertAction = UIAlertAction(title: "OK", style: .default)
			alertController.addAction(alertAction)
			present(alertController, animated: true)
			return
		}
	}
}

// MARK: - UITableViewDataSource
extension CheckoutViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == Section.items.rawValue {
			return CheckoutCart.shared.cart.count
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let section = Section(rawValue: indexPath.section) else {
			fatalError("Section not found")
		}
		let identifier = Section.cellIdentifier(for: section)
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		switch cell {
		case let cell as CheckoutItemTableViewCell:
			let puppy = CheckoutCart.shared.cart[indexPath.row]
			cell.configure(with: puppy)
		case let cell as CheckoutTotalTableViewCell:
			let total = CheckoutCart.shared.total
			cell.configure(with: total)
		default:
			fatalError("Cell does not match the correct type")
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if indexPath.section == Section.items.rawValue {
			return true
		} else {
			return false
		}
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else {
			return
		}
		let item = CheckoutCart.shared.cart[indexPath.row]
		let isRemoved = CheckoutCart.shared.removeItem(item)
		if isRemoved {
			tableView.beginUpdates()
			tableView.deleteRows(at: [indexPath], with: .automatic)
			tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
			tableView.endUpdates()
		}
	}
}
