//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-28.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError:Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
        
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion:@escaping (Result<Void, DatabaseError>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.id = Int64(model.id)
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do {
            try context.save()
            completion(.success(()))
        } catch(let error) {
            print(error.localizedDescription)
            completion(.failure(.failedToSaveData))
        }
        
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[TitleItem],DatabaseError >) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request:NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
            
        } catch {
            print(error.localizedDescription)
            completion(.failure(.failedToFetchData))
        }
    }
    
    func deleteTitleWithModel(model: TitleItem, completion: @escaping (Result<Void,DatabaseError>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success( () ))
        }catch {
            print(error.localizedDescription)
            completion(.failure(.failedToDeleteData))
        }
    }
}
