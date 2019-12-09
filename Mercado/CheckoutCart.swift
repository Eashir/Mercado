//
//  CheckoutCart.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Foundation

final class CheckoutCart {
	
	static let shared = CheckoutCart()
	
	private init() {
		// private
	}
	
	private var items: [Item] = []
	
	var cart: [Item] {
		return items
	}
	
	var canPay: Bool {
		return !items.isEmpty
	}
	
	var total: Int {
		return items.reduce(0) { (result, item) -> Int in
			return result + item.amount
		}
	}
	
	func addItem(_ item: Item) {
		guard !items.contains(item) else {
			return
		}
		items.append(item)
	}
	
	func removeItem(_ item: Item) -> Bool {
		guard let index = items.firstIndex(of: item) else {
			return false
		}
		items.remove(at: index)
		return true
	}
	
}

