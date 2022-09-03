//
//  APiClient.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation
import UIKit

protocol APIClient {
    var session: URLSession { get }
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    typealias JSONVoidTaskCompetionHandler = (Bool, APIError?) -> Void
    
    private func decodingMultipart<T: Decodable>(with request: URLRequest, decodingType: T.Type, data: Data, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionUploadTask {
        let task = session.uploadTask(with: request, from: data) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "No description"))
                return
            }
            guard httpResponse.statusCode == 200  else {
                completion(nil, .responseUnsuccessful(description: "\(httpResponse.statusCode)\n\(String(describing: response))"))
                return
            }
            guard let data = data else { completion(nil, .invalidData); return }
            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch let err {
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        return task
    }

    
    func handlerDirectWithCodable<T: Decodable, E: Error & Decodable> (with request: URLRequest, decodingType: T.Type, errorModel: E.Type, completionHandler completion:  @escaping (Result<T, DataLayerError<E>>) -> Void) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) {  data, response, error in

            do {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(Result.failure(DataLayerError.network(error!.localizedDescription)))
                    return
                }
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode <= 600) {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                        let object = try JSONDecoder().decode(errorModel.self, from: data!)
                    completion(Result.failure(DataLayerError.backend(object)))
                }
                else if httpResponse.statusCode == 200 {
                    let object = try JSONDecoder().decode(decodingType.self, from: data!)
                    completion(Result.success(object))
                    
                }
            }catch {
                if let httpresponse = response as? HTTPURLResponse {
                    if httpresponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    completion(Result.failure(DataLayerError.parsing(error.localizedDescription, httpresponse.statusCode)))
                }
            }
        }
        return task
    }
    
    func handlerWithoutResponse<E>(with request: URLRequest, errorModel: E.Type, completionHandler completion: @escaping (Result<Bool, DataLayerError<E>>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data,response,error in
            do {
                guard let httpResponse = response as? HTTPURLResponse else {
                        completion(Result.failure(DataLayerError.network(error!.localizedDescription)))
                        return
                }
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode <= 600) {
                        if httpResponse.statusCode == 401 {
                            print("UnAuthorized ")
                            print("REquest \(request)")
                            self.handleUnAuthorizedUser()
                            return
                        }
                            let object = try JSONDecoder().decode(errorModel.self, from: data!)
                        completion(Result.failure(DataLayerError.backend(object)))
                }
                else if httpResponse.statusCode == 200 {
                    completion(Result.success(true))
                    
                }
            }catch {
                if let httpresponse = response as? HTTPURLResponse {
                    if httpresponse.statusCode == 401 {
                        print("UnAuthorized ")
                        print("Request \(request)")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    completion(Result.failure(DataLayerError.parsing(error.localizedDescription, httpresponse.statusCode)))
                }
            }
        }
        return task
    }
    
    
    /// success respone executed on main thread.
    func fetchMultipart<T: Decodable>(with request: URLRequest, data: Data, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingMultipart(with: request, decodingType: T.self, data: data) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                    return
                }
                guard let value = decode(json) else { completion(.failure(.jsonDecodingFailure)); return }
                completion(.success(value))
            }
        }
        task.resume()
    }
    
    
    func fetchHandler<T: Decodable, E: Error & Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, DataLayerError<E>>) -> Void) {
        let task = handlerDirectWithCodable(with: request, decodingType: T.self, errorModel: E.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    completion(Result.success(success))
                case .failure(let error):
                    completion(Result.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchHandlerWithoutResponse<E>(with request: URLRequest, completion: @escaping (Result<Bool, DataLayerError<E>>) -> Void)  {
        let task = handlerWithoutResponse(with: request, errorModel: E.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    completion(Result.success(success))
                case .failure(let error):
                    completion(Result.failure(error))
                }
            }
        }
        task.resume()

    }
    
    func fetchVoid(with request: URLRequest, completion: @escaping (Result<Bool, APIError>) -> Void) {
        let task = decodingTaskVoid(with: request) { (success, error) in
            DispatchQueue.main.async {
                if success {
                    completion(.success(true))
                }
                else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    private func decodingTaskVoid(with request: URLRequest, completionHandler completion: @escaping JSONVoidTaskCompetionHandler ) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false, .requestFailed(description: error?.localizedDescription ?? "No description"))
                return
            }
            if httpResponse.statusCode == 200 {
                completion(true, nil)
            }
            else {
                completion(false, .responseUnsuccessful(description: "\(httpResponse.statusCode)\n\(String(describing: response))"))
            }
        }
        return task
    }
}



extension APIClient{

    func handleUnAuthorizedUser() {

        let standard = UserDefaults.standard

        let domain = Bundle.main.bundleIdentifier!
        standard.removePersistentDomain(forName: domain)
        standard.synchronize()
        DispatchQueue.main.async {
            navigateToMain(StoryboardName: "Main", IdentifierName: "LoginNavigationController")

        }
    }
}


func navigateToMain(StoryboardName: String ,IdentifierName : String) {
    let main = UIStoryboard(name: StoryboardName, bundle: nil).instantiateViewController(withIdentifier: IdentifierName)
    
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
        window.rootViewController = main
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
