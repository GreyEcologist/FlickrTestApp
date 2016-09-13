//
//  FlickrCollectionCell.swift
//  FlickrTestApp
//
//  Created by Gareth.K.Mensah on 9/12/16.
//  Copyright © 2016 Gareth.K.Mensah. All rights reserved.
//

import AsyncDisplayKit
import WebASDKImageManager

final class FlickrCell: ASCellNode {
    private let picNode: ASNetworkImageNode
    
    init(imageURL: NSURL) {
        self.picNode = ASNetworkImageNode(webImage: ())
        self.picNode.URL = imageURL
        self.picNode.contentMode = .ScaleAspectFill
        self.picNode.preferredFrameSize = CGSize(width: 50, height: 50)
        super.init()
        self.addSubnode(self.picNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.picNode.flexBasis = ASRelativeDimension(type: .Percent, value: 1)
        
        return ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: Constants.kPadding, left: Constants.kPadding, bottom: Constants.kPadding, right: 2 * Constants.kPadding),
            child: self.picNode),
            background: nil)
    }
}
