//
//  Extentions.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-18.
//

import Foundation

extension String {
    
    func capatalieFirstLetter() -> String {
        
      // print(self.prefix(1).uppercased() + self.lowercased().dropFirst())
       return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
