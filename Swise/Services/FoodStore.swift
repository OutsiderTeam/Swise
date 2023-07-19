//
//  FoodStore.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import Foundation
import CryptoSwift

class FoodStore: FoodService {
    public static let shared = FoodStore()
    private let urlSession = URLSession.shared
    
    private var timestamp: String {
        get { return String(Int(Date().timeIntervalSince1970)) }
    }
    
    private var nonce: String {
        get {
            var string: String = ""
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let char = Array(letters)
            
            for _ in 1...7 { string.append(char[Int(arc4random()) % char.count]) }
            
            return string
        }
    }
    
    //    func fetchFoods(params: [String : String]?, successHandler: @escaping (FoodsResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
    //        <#code#>
    //    }
    
    func fetchFood(id: Int, successHandler: @escaping (FoodDetailResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        FoodParams.params = ["format":String("json"), "method":String("food.get.v3"), "food_id":String(id)] as Dictionary
        
        let components = generateSignature()
        foodRequest(with: components) { data in
            guard let data = data else { return }
            let food = self.retrieve(data: data, type: FoodDetailResponse.self)
            DispatchQueue.main.async {
                successHandler(food!)
            }
        }
        
    }
    
    func searchFood(query: String, successHandler: @escaping (FoodsResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        FoodParams.params = ["format":String("json"), "method":String("foods.search"), "max_results":String("10"), "search_expression":String(query)] as Dictionary
        
        let components = generateSignature()
        foodRequest(with: components) { data in
            guard let data = data else { return }
            let model = self.retrieve(data: data, type: FoodsResponse.self)
            let search = model
            successHandler(search ?? FoodsResponse(foods: Foods(maxResults: "", pageNumber: "", totalResults: "", food: [])))
        }
    }
}

extension FoodStore {
    fileprivate func foodRequest(with components: URLComponents, completion: @escaping (_ data: Data?)-> ()) {
        var request = URLRequest(url: URL(string: String(describing: components).replacingOccurrences(of: "+", with: "%2B"))!)
        request.httpMethod = FoodParams.httpType
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let model = self.retrieve(data: data, type: [String:FSError].self)
                    if model != nil {
                        let error = model!["error"]
                        try self.checkForError(with: error!.code)
                    }
                    
                    completion(data)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    fileprivate func retrieve<T: Decodable>(data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decode = try decoder.decode(type, from: data)
            return decode
        } catch {
            return nil
        }
    }

    fileprivate func generateSignature() -> URLComponents {
        FoodParams.oAuth.updateValue(self.timestamp, forKey: "oauth_timestamp")
        FoodParams.oAuth.updateValue(self.nonce, forKey: "oauth_nonce")

        var components = URLComponents(string: FoodParams.url)!
        components.componentsForOAuthSignature(from: Array<String>().parameters)
        
        let parameters = components.getURLParameters()
        let encodedURL = FoodParams.url.addingPercentEncoding(withAllowedCharacters: CharacterSet().percentEncoded)!
        let encodedParameters = parameters.addingPercentEncoding(withAllowedCharacters: CharacterSet().percentEncoded)!
        let signatureBaseString = "\(FoodParams.httpType)&\(encodedURL)&\(encodedParameters)".replacingOccurrences(of: "%20", with: "%2520")
        let signature = String().getSignature(key: FoodParams.key, params: signatureBaseString)
        
        components.queryItems?.append(URLQueryItem(name: "oauth_signature", value: signature))
        return components
    }
    
    fileprivate func checkForError(with code: Int) throws {
        switch code {
        case 5:
            throw HTTPError.invalidKey
        case 8:
            throw HTTPError.invalidSignature
        default:
            throw HTTPError.unknown
        }
    }
}
