//
//  URLResquestExtension.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

extension URLRequest {
    
    public static func downloadSingleImage(urlString: String, completionHandler: @escaping ([String: UIImage]) -> ()) {
        
        DispatchQueue.global(qos: .background).async {
            
            guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { completionHandler([urlString: image]) }
        }
    }
    
    public static func downloadManyImages(urlsString: [String], completionHandler: @escaping ([String: UIImage]) -> ()) {
        
        var images: [String: UIImage] = [:]
        
        for urlString in urlsString {
            
            URLRequest.downloadSingleImage(urlString: urlString) { (imageDict) in
                
                images[imageDict.first?.key ?? ""] = imageDict.first?.value ?? UIImage()
                completionHandler(images)
            }
        }
    }
}
