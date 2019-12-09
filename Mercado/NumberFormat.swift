//
//  NumberFormat.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Foundation

final class NumberFormat {
	
	private static let shared = NumberFormat()
	
	private lazy var formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.maximumFractionDigits = 2
		formatter.numberStyle = .currency
		formatter.currencyCode = "usd"
		return formatter
	}()
	
	private init() {
		// private
	}
	
	static func format(value: Int) -> String {
		let number = NSDecimalNumber(value: value)
		let numberDividedByOneHundred = number.dividing(by: NSDecimalNumber(value: 100))
		guard let formattedString = shared.formatter.string(from: numberDividedByOneHundred) else {
			fatalError("\(value) cannot be formatted correctly")
		}
		return formattedString
	}
	
}
