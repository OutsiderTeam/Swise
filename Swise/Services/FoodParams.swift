//
//  FoodParams.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import Foundation

internal struct FoodParams {
    /// OAuth Parameters
    static var oAuth = ["oauth_consumer_key":"74cd5cdecdba4685858edd2600c5c061",
                        "oauth_signature_method":"HMAC-SHA1",
                        "oauth_timestamp":"",
                        "oauth_nonce":"",
                        "oauth_version":"1.0"] as Dictionary
    static var params = [:] as Dictionary<String, String>
    /// Fat Secret Consumer Secret Key
    static var key = "ba6d2c7c5d3140d7bc796b8a97ab170c"
    /// Fat Secret API URL
    static let url = "https://platform.fatsecret.com/rest/server.api"
    /// Fat Secret HTTP Request Method
    static let httpType = "GET"
}
