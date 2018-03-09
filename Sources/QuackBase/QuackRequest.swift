//
//  QuackRequest.swift
//  QuackBase
//
//  Created by Christoph Pageler on 18.12.17.
//

import Foundation


public extension Quack {
    
    public struct Request {
        
        public enum Encoding {
            case url
            case noUrlEncoding
            case json
        }
        
        public var method: HTTP.Method
        public var uri: String
        public var headers: [String: String]
        public var body: [String: Any]? = nil
        public var encoding: Encoding = .url
        
        public init(method: HTTP.Method, uri: String, headers: [String: String], body: [String: Any]) {
            self.method = method
            self.uri = uri
            self.headers = headers
            self.body = body
        }
        
    }
    
}
