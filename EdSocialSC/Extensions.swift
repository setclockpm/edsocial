//
//  Extensions.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/26/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit

let imageCache = NSCache < NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}
