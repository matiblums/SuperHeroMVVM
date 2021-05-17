//
//  APIClient.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 13/05/2021.
//

import Foundation
import Alamofire
import RxSwift

typealias ArrayErrorResponse = ([ListElement]?, Error?) -> Void
typealias StringResponse = (String?) -> Void

class APIClient : NSObject {
    
    static let sharedInstance = APIClient()
    
    func retriveDataListAlamofire(completionHandler: @escaping ArrayErrorResponse, errorHandler:@escaping StringResponse) {
        
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
    
    func retriveDataListURLSession(completionHandler: @escaping ArrayErrorResponse, errorHandler:@escaping StringResponse) {
        
        guard let url = URL(string: "https://dev.consultr.net/superhero.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            do {
                let list = try JSONDecoder().decode(List.self, from: data!)
                completionHandler(list, nil)
            } catch let error {
                print("ha ocurrido un error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func retriveDataListRxSwift() -> Observable<List> {
        
        return Observable.create { observer in
            
            //********************************************************************
            let url = URL(string: "https://dev.consultr.net/superhero.json")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                do {
                    let list = try JSONDecoder().decode(List.self, from: data!)
                    
                    observer.onNext(list)
                } catch let error {
                    observer.onError(error)
                    print("ha ocurrido un error: \(error.localizedDescription)")
                }
                observer.onCompleted()
            }.resume()
            //********************************************************************
            return Disposables.create {
                URLSession.shared.finishTasksAndInvalidate()
            }
        }
    }
    
}
