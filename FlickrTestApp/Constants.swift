//
//  Constants.swift
//  FlickrTestApp
//
//  Created by Gareth.K.Mensah on 9/11/16.
//  Copyright © 2016 Gareth.K.Mensah. All rights reserved.
//

import UIKit

struct Constants {
    static let kFlickrKey: String = "efa44569d964ac57f4cc5bbd3e77d2fd"
    static let kFlickrSecret: String = "a0a3689d555f734c"
    static let kFlickrUser: String = "GreyEcologist"
    static let kPadding: CGFloat = 5.0
    static let kScreenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    static let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    static let kStatusViewRect: CGRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: 20)
    static let kSearchRect: CGRect = CGRect(x: kPadding, y: kStatusViewRect.height + kPadding, width: kScreenWidth, height: 48)
    static let kTablePositionY: CGFloat = kSearchRect.height + kSearchRect.origin.y
    static let kFlickrTableViewRect: CGRect = CGRect(x: kPadding, y: kTablePositionY + kPadding, width: kScreenWidth - 2 * kPadding, height: kScreenHeight - (kTablePositionY + 2 * kPadding))
}
