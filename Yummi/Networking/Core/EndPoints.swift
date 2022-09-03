//
//  EndPoints.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var request: URLRequest? {
        guard let url = URL(string: "\(self.base)\(self.path)") else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    func postRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        guard var request = self.request else { return nil }
        var currentLanguage = ""
        if(Utility().currentApplicationLanguage() == Language.english){
            currentLanguage = "en"
        }else{
            currentLanguage = "ar"
        }
        request.addValue(currentLanguage, forHTTPHeaderField: "lang")
        request.addValue("ios", forHTTPHeaderField: "X-APP-OS")
        request.addValue("\(Bundle.main.buildNumber!)", forHTTPHeaderField: "X-APP-VERSION")
        request.httpMethod = HTTPMethod.post.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.postParametersEncodingFalure(description: "\(error)").customDescription)
            return nil
        }
        headers.forEach { request.addValue("\($0.header.value)", forHTTPHeaderField: $0.header.field) }
        return request
    }
    
    
    func postMultipartRequest(with boundary: String) -> URLRequest? {
        guard var request = self.request else { return nil }
        var currentLanguage = ""
        if(Utility().currentApplicationLanguage() == Language.english){
            currentLanguage = "en"
        }else{
            currentLanguage = "ar"
        }
        request.addValue(currentLanguage, forHTTPHeaderField: "lang")
        request.addValue("ios", forHTTPHeaderField: "X-APP-OS")
        request.addValue("\(Bundle.main.buildNumber!)", forHTTPHeaderField: "X-APP-VERSION")
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return request
        }
        request.addValue(token, forHTTPHeaderField: "access_token")
        return request
    }
    
    func getRequest(parameters: [String: String], headers: [HTTPHeader]) -> URLRequest? {
        guard var components = URLComponents(string: "\(self.base)\(self.path)") else { return nil }
        components.setQueryItems(with: parameters)
        var request = URLRequest(url: components.url!)
        var currentLanguage = ""
        if(Utility().currentApplicationLanguage() == Language.english){
            currentLanguage = "en"
        }else{
            currentLanguage = "ar"
        }
        request.addValue(currentLanguage, forHTTPHeaderField: "lang")
        request.addValue("ios", forHTTPHeaderField: "X-APP-OS")
        request.addValue("\(Bundle.main.buildNumber!)", forHTTPHeaderField: "X-APP-VERSION")
        request.httpMethod = HTTPMethod.get.rawValue
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return request
        }
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        headers.forEach { request.addValue("\($0.header.value)", forHTTPHeaderField: $0.header.field) }
        return request
        
    }
    
    func putRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        guard var request = self.request else { return nil }
        var currentLanguage = ""
        if(Utility().currentApplicationLanguage() == Language.english){
            currentLanguage = "en"
        }else{
            currentLanguage = "ar"
        }
        request.addValue(currentLanguage, forHTTPHeaderField: "lang")
        request.addValue("ios", forHTTPHeaderField: "X-APP-OS")
        request.addValue("\(Bundle.main.buildNumber!)", forHTTPHeaderField: "X-APP-VERSION")
        request.httpMethod = HTTPMethod.put.rawValue
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return request
        }
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.postParametersEncodingFalure(description: "\(error)").customDescription)
            return nil
        }
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        headers.forEach { request.addValue("\($0.header.value)", forHTTPHeaderField: $0.header.field) }
        return request
    }
    
    func deleteRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        guard var request = self.request else { return nil }
        var currentLanguage = ""
        if(Utility().currentApplicationLanguage() == Language.english){
            currentLanguage = "en"
        }else{
            currentLanguage = "ar"
        }
        request.addValue(currentLanguage, forHTTPHeaderField: "lang")
        request.addValue("ios", forHTTPHeaderField: "X-APP-OS")
        request.addValue("\(Bundle.main.buildNumber!)", forHTTPHeaderField: "X-APP-VERSION")
        request.httpMethod = HTTPMethod.delete.rawValue
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return request
        }
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.postParametersEncodingFalure(description: "\(error)").customDescription)
            return nil
        }
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        headers.forEach { request.addValue("\($0.header.value)", forHTTPHeaderField: $0.header.field) }
        return request
    }
}
