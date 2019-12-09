//
//  NetworkRouter.swift
//  Mercado
//
//  Created by Eashir Arafat on 12/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Alamofire

public enum NetworkRouter: URLRequestConvertible {
	
	static let baseURLPath = "http://bjss-basket.appspot.com"
	
	case goods
	case image(String)
	
	var method: HTTPMethod {
		switch self {
		case .goods:
			return .get
		case .image:
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .goods:
			return "/goods"
		case .image(let id):
			return "/images/\(id)"
		}
		
	}
	
	public func asURLRequest() throws -> URLRequest {
		let url = try NetworkRouter.baseURLPath.asURL()
		var request = URLRequest(url: url.appendingPathComponent(path))
		
		request.httpMethod = method.rawValue
		request.timeoutInterval = TimeInterval(10 * 1000)
		
		return try URLEncoding.default.encode(request, with: [:])
	}
	
}

