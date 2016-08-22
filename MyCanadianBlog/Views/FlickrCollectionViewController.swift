//
//  FlickrCollectionViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 21/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import OAuthSwift

class FlickrCollectionViewController: UICollectionViewController {

    var FLickrPhotos: [FlickrPhoto] = [FlickrPhoto]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let oauthswift = OAuth1Swift(
            consumerKey:    Flickr.key,
            consumerSecret: Flickr.secret,
            requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
            authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
        )
        
        let url :String = "https://api.flickr.com/services/rest/"
        let parameters :Dictionary = [
            "method"         : "flickr.photos.search",
            "api_key"        : Flickr.key,
            "user_id"        : "145323529@N08",
            "format"         : "json",
            "nojsoncallback" : "1",
            "extras"         : "url_sq"
        ]
        
        oauthswift.client.get(url, parameters: parameters, success: { data, response in
            let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let photos = jsonDict["photos"] as? [String: AnyObject] {
                if let photos = photos["photo"] as? NSArray  {
                    for photo in photos {
                        self.FLickrPhotos.append(FlickrPhoto(representation: photo as! NSDictionary))
                    }
                    self.collectionView?.reloadData()
                }
            }
        }, failure: { error in
            print(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.FLickrPhotos.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FlickrImageCollectionViewCell", forIndexPath: indexPath) as! FlickrImageCollectionViewCell
    
        // Configure the cell
    
        return cell
    }
}
