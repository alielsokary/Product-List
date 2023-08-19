//
//  APIRouter.swift
//  HICH
//
//  Created by Sajjad Sarkoobi on 3.09.2022.
//

import Foundation

struct APIRouter {
    
    struct GetProducts: Request {
        typealias ReturnType = Products
        var path: String = "/products-test.json"
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        init(queryParams: APIParameters.ProductParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
}
