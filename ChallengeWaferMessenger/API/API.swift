
//
//  API.swift
//  ChallengeWaferMessenger
//
//  Created by Fernanda de Lima on 21/08/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import UIKit

class API{
    
    class func get(
        success:@escaping (_ item: [Country]) -> Void,
        fail:@escaping (_ error: Error) -> Void) -> Void
    {
        //create request to API
        var request = URLRequest(url: URL(string: "https://restcountries.eu/rest/v2/all")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create session to connection
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                //verify response
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200{ //it's ok
                        //verify if have response data
                        if let data = data{
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode([Country].self, from: data)
                            success(responseModel)
                        }
                    }
                }
                
            } catch {
                fail(error)
            }
            
        })
        
        task.resume()
    }
    
}
