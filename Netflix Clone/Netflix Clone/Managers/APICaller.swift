//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-17.
//

import Foundation

struct Constants {
    static let API_KEY = "b95ae7c210bb534c29b482e4c96ccf29"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError : Error {
    case  failedToGetData
    
}

class APICaller {
    static let  shared = APICaller()
    
    func getTrendingMoview(completion:@escaping (Result<[Title],APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            completion(.failure(.failedToGetData))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                  !(200...209).contains(httpResponse.statusCode)  {
                completion(.failure(.failedToGetData))
                return
                
            }
            
            if error != nil {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data!)
                completion(.success(results.results))
//                let results = try JSONSerialization.jsonObject(with:data!, options: .fragmentsAllowed)
//               print(results)
            } catch(let error) {
                completion(.failure(.failedToGetData))
                print(error)
            }
            
            
            
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title],APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let response = response as? HTTPURLResponse,
               !(200...209).contains(response.statusCode){
                completion(.failure(.failedToGetData))
                return
            }
            
            if let error = error {
                print(error)
                completion(.failure(.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data!)
                completion(.success(results.results))
                
            }catch(let error) {
                completion(.failure(.failedToGetData))
                print(error)
            }
        }
        
        task.resume()
         
    }
    
//https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
    
    func getUpComingMoview(completion:@escaping (Result<[Title],APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            completion(.failure(.failedToGetData))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                  !(200...209).contains(httpResponse.statusCode)  {
                completion(.failure(.failedToGetData))
                return
                
            }
            
            if error != nil {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data!)
                completion(.success(results.results))
//                let results = try JSONSerialization.jsonObject(with:data!, options: .fragmentsAllowed)
//               print(results)
            } catch(let error) {
                completion(.failure(.failedToGetData))
                print(error)
            }
            
            
            
        }
        task.resume()
    }
    
    func getPopularMoview(completion:@escaping (Result<[Title],APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            completion(.failure(.failedToGetData))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                  !(200...209).contains(httpResponse.statusCode)  {
                completion(.failure(.failedToGetData))
                return
                
            }
            
            if error != nil {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data!)
                completion(.success(results.results))
//                let results = try JSONSerialization.jsonObject(with:data!, options: .fragmentsAllowed)
//               print(results)
            } catch(let error) {
                completion(.failure(.failedToGetData))
                print(error)
            }
            
            
            
        }
        task.resume()
    }
    
    func getTopRatedMoview(completion:@escaping (Result<[Title],APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            completion(.failure(.failedToGetData))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                  !(200...209).contains(httpResponse.statusCode)  {
                completion(.failure(.failedToGetData))
                return
                
            }
            
            if error != nil {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data!)
                completion(.success(results.results))
//                let results = try JSONSerialization.jsonObject(with:data!, options: .fragmentsAllowed)
//               print(results)
            } catch(let error) {
                completion(.failure(.failedToGetData))
                print(error)
            }
            
            
            
        }
        task.resume()
    }
    
//    func getData<T:Decodable>(of type:T.Type = T.self, completion: @escaping (Result<T,APIError>) -> Void) {
//
//    }
}
