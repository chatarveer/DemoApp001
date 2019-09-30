//
//  ImageUploader.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

public typealias URLResponse = Result<(data: Data, response: HTTPURLResponse)>

open class ImageUploader {
    
    public static let shared = ImageUploader()
    var uploadTask: URLSessionDataTask!
    
    private init() { }
    
    deinit { }
    
    open func uploadImage(_ data: Data, urlToUpladImg: String, completionHandler: @escaping (URLResponse) -> Void) {
        
        var r  = URLRequest(url: URL(string: urlToUpladImg)!)
        r.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let parameters = ["file": "car_front.jpeg",
                          "upload_preset": "yond2thp"]
        
        r.httpBody = createBody(parameters: parameters,
                                boundary: boundary,
                                data: data,
                                mimeType: "image/jpg",
                                filename: "hello.jpg")
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: r as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let data = data, let response = response as? HTTPURLResponse {
                completionHandler(URLResponse(success: (data, response)))
            } else {
                completionHandler(URLResponse(failure: error ?? NSError(domain: "com.sandbox.DemoApp001",
                                                                        code: 9999,
                                                                        userInfo: [:])))
            }
        })
        dataTask.resume()
    }
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
}
