//
//  FoodService.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import Foundation

protocol FoodService {
    
//    func fetchFoods(params: [String: String]?, successHandler: @escaping (_ response: FoodsResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchFood(id: Int, successHandler: @escaping (_ response: FoodDetailResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func searchFood(query: String, successHandler: @escaping (_ response: FoodsResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

public enum HTTPError: LocalizedError {
    case invalidKey
    case invalidSignature
    case unknown

    public var errorDescription: String? {
        switch self {
        case .invalidKey:
            return NSLocalizedString("Error: Invalid key", comment: "error")
        case .invalidSignature:
            return NSLocalizedString("Error: Invalid signature", comment: "error")
        default:
            return NSLocalizedString("Error: Unknown", comment: "error")
        }
    }
}
