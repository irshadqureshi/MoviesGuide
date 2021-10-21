//
//  APIManager.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 16/10/2021.
//

import Foundation
import UIKit

protocol APIManagerProtocol {
    func requestApi(apiUrl: String, params: String?, handler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func cancelNetworkRequest() 
}

public class APIManager: NSObject, APIManagerProtocol {
    
    private weak var dataTask: URLSessionDataTask?
    
    public func requestApi(apiUrl: String, params: String?, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        if let url = URL.with(string: apiUrl, param: params) {
            let session = URLSession.shared
            dataTask = session.dataTask(with: url) { data, response, error in
                handler(data, response, error)
            }
            dataTask?.resume()
        }
    }
    
    public func cancelNetworkRequest() {
        guard let task = self.dataTask else { return }
        task.cancel()
    }
}

