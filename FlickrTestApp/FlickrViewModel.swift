//
//  FlickrViewModel.swift
//  FlickrTestApp
//
//  Created by Gareth.K.Mensah on 9/12/16.
//  Copyright © 2016 Gareth.K.Mensah. All rights reserved.
//

import ReactiveCocoa
import FlickrKit
import Result


struct FlickrViewModel {

    func getInterestingListSignal() -> SignalProducer<AnyObject, NSError> {
        return SignalProducer { observer, disposable in
            FlickrKit.sharedFlickrKit().initializeWithAPIKey(Constants.kFlickrKey, sharedSecret: Constants.kFlickrSecret)
            let flickrInteresting = FKFlickrInterestingnessGetList()
            flickrInteresting.per_page = "15"
            FlickrKit.sharedFlickrKit().call(flickrInteresting) { (response, error) -> Void in
                guard let collection = response else { observer.sendCompleted(); return }
                let topPhotos = collection["photos"] as! [NSObject: AnyObject]
                let photoArray = topPhotos["photo"] as! [[NSObject: AnyObject]]
                let photoURLArray = photoArray.map({ photoDictionary in FlickrKit.sharedFlickrKit().photoURLForSize(FKPhotoSizeSmall240, fromPhotoDictionary: photoDictionary) })
                observer.sendNext(photoURLArray)
                observer.sendCompleted()
            }
        }
    }
    
    func searchSignal(searchToken searchToken: String) -> SignalProducer<AnyObject, NoError> {
        return SignalProducer { observer, disposable in
            FlickrKit.sharedFlickrKit().initializeWithAPIKey(Constants.kFlickrKey, sharedSecret: Constants.kFlickrSecret)
            FlickrKit.sharedFlickrKit().call("flickr.photos.search", args: ["per_page": "15", "text": searchToken], maxCacheAge: FKDUMaxAgeNeverCache) { (response, error) -> Void in
                guard let collection = response else { observer.sendCompleted(); return }
                let topPhotos = collection["photos"] as! [NSObject: AnyObject]
                let photoArray = topPhotos["photo"] as! [[NSObject: AnyObject]]
                let photoURLArray = photoArray.map({ photoDictionary in FlickrKit.sharedFlickrKit().photoURLForSize(FKPhotoSizeSmall240, fromPhotoDictionary: photoDictionary) })
                observer.sendNext(photoURLArray)
                observer.sendCompleted()
            }
        }
    }
}
