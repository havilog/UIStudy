//
//  Photo.swift
//  CollectionView
//
//  Created by 한상진 on 2021/07/08.
//

import UIKit

struct Photo: Hashable {
    
    var caption: String
    var comment: String
    var image: UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }
    
    init?(dictionary: [String: String]) {
        guard
            let caption = dictionary["Caption"],
            let comment = dictionary["Comment"],
            let photo = dictionary["Photo"],
            let bundle = Bundle(identifier: "com.havi.CollectionView"),
            let image = UIImage(named: photo, in: bundle, with: nil)
        else {
            return nil
        }
        
        self.init(caption: caption, comment: comment, image: image)
    }
    
    static func allPhotos() -> [Photo] {
        var photos = [Photo]()
        guard let bundle = Bundle(identifier: "com.havi.CollectionView"),
              let URL = bundle.url(forResource: "Photos", withExtension: "plist"),
              let photosFromPlist = NSArray(contentsOf: URL) as? [[String:String]] else {
            return photos
        }
        for dictionary in photosFromPlist {
            if let photo = Photo(dictionary: dictionary) {
                photos.append(photo)
            }
        }
        return photos
    }
    
}
