//
//  AuthorViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 22/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AuthorViewController: UIViewController, MKMapViewDelegate {

    var author: Author?
    
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorDescription: UITextView!
    @IBOutlet weak var authorLocation: MKMapView!
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorLocation.delegate = self
        
        self.authorName.text = self.author!.name
        
        Alamofire.request(.GET, self.author!.avatar_URL!)
            .responseImage { response in
                if let image = response.result.value {
                    self.authorImage.image = image
            }
        }
        
        Alamofire.request(.GET, self.author!.profile_URL!+".json")
            .responseJSON { response in
                if let json = response.result.value {
                    let response  = ((json as! NSDictionary).valueForKey("entry") as! NSArray)[0] as! NSDictionary
                    
                    print(response)
                    
                    self.authorDescription.text = response.valueForKey("aboutMe") as! String
                    
                    let address = response.valueForKey("currentLocation") as! String
                    let geocoder = CLGeocoder()
                    
                    geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                        if((error) != nil){
                            print("Error", error)
                        }
                        if let placemark = placemarks?.first {
                            let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                            let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            
                            self.authorLocation.setRegion(region, animated: true)
                        }
                    })
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
