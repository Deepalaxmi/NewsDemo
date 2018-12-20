//
//  CustomImageView.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String, newsItemId: String) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if !Helper.isInternetAvailable() {
            let imageName = newsItemId + ".png"
            if let image = getImageFromLocal(imageName: imageName){
                self.image = image
                return
            }
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                    self.saveImage(imageToCache: imageToCache, urlString: urlString, newsItemId: newsItemId)
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
            
        }).resume()
    }
    
    
    func saveImage(imageToCache:UIImage,urlString: String, newsItemId: String ){
        let fileManager = FileManager.default
        let documentsURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentPath = documentsURL.path
        let filePath = documentsURL.appendingPathComponent("\(newsItemId).png")
//        print(filePath)
        // Check for existing image data
        do {
            // Look through array of files in documentDirectory
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            
            for file in files {
                // If we find existing image filePath delete it to make way for new imageData
                if "\(documentPath)/\(file)" == filePath.path {
                    try fileManager.removeItem(atPath: filePath.path)
                }
            }
        } catch {
            print("Could not add image from document directory: \(error)")
        }
        
        // Create imageData and write to filePath
        if let data = imageToCache.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: filePath)
            } catch {
                print("error saving file to documents:", error)
            }
        }
    }
    
    func getImageFromLocal(imageName:String) -> UIImage? {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: paths){
            print("image found")
            if let contentsOfFilePath = UIImage(contentsOfFile: paths) {
                return contentsOfFilePath
            }
            return nil
        }else{
            return nil
        }
    }

    
}

