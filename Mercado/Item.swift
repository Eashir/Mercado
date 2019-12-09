//
//  Item.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import Alamofire

class Item: Decodable {
	
	let id: Int
	let name: String
	let amount: Int
	let currency: String
	let container: String
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case amount = "amount"
		case price = "price"
		case currency = "currency"
		case container = "container"
	}
	
	required init(from decoder: Decoder) throws {
		let itemArrayDict = try decoder.container(keyedBy: CodingKeys.self)
		id = try itemArrayDict.decode(Int.self, forKey: .id)
		name = try itemArrayDict.decode(String.self, forKey: .name)
		let price = try itemArrayDict.nestedContainer(keyedBy: CodingKeys.self, forKey: .price)
		amount = try price.decode(Int.self, forKey: .amount)
		currency = try price.decode(String.self, forKey: .currency)
		container = try itemArrayDict.decode(String.self, forKey: .container)
	}
	
	class func getItems( completion: @escaping ([Item]? ) -> Void) {
		Alamofire.request(NetworkRouter.goods).responseData { (response) in
			do {
				let decoder = JSONDecoder()
				let items = try decoder.decode([Item].self, from: response.data!)
				completion(items)
			} catch let parsingError {
				print("Error", parsingError)
			}
		}
	}
	
}

