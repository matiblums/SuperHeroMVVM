//
//  APIClient.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 13/05/2021.
//

import Foundation
import Alamofire

typealias ArrayErrorResponse = ([ListElement]?, Error?) -> Void
typealias StringResponse = (String?) -> Void

class APIClient : NSObject {
    
    static let sharedInstance = APIClient()
    
    func retriveDataList(completionHandler: @escaping ArrayErrorResponse, errorHandler:@escaping StringResponse) {
        
        guard let url = URL(string: "https://dev.consultr.net/superhero.json") else { return }
        
        Alamofire.request(url).responseJSON { response in
            
            if let data = response.data {
                do {
                    let list = try JSONDecoder().decode(List.self, from: data)
                    completionHandler(list, nil)
                }catch {
                    print("LN123 Parsing ranking from api fullError? ->> \(error)")
                }
            }
            else{
                errorHandler("The request is invalid.")
            }
        }
    }
    
}
