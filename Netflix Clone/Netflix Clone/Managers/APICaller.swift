//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-17.
//

import Foundation

struct Constants {
    static let API_KEY = ""
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = ""
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
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
    
    func getDiscoverMovies(completion:@escaping (Result<[Title],APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
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
    
    func search(with query:String,completion:@escaping (Result<[Title],APIError>) -> Void ) {
    
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
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
    
    func getMovie(with query:String,completion:@escaping (Result< VideoElement,APIError>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string:"\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
                      
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
                let results = try JSONDecoder().decode(YoutybeSearchResponse.self, from: data!)
                completion(.success(results.items[0]))
               
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
