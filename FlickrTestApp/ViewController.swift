//
//  ViewController.swift
//  FlickrTestApp
//
//  Created by Gareth.K.Mensah on 9/11/16.
//  Copyright © 2016 Gareth.K.Mensah. All rights reserved.
//

import UIKit
import ReactiveCocoa
import AsyncDisplayKit

final class ViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate, UISearchBarDelegate {
    
    //MARK: Properties
    private let searchBar: UISearchBar
    private let flickrTableView: ASTableView
    internal var flickrArray: [NSURL] = []
    
    //MARK: Initializers
    required init(coder aDecoder: NSCoder) { fatalError("storyboards are incompatible with truth and beauty") }
    
    init() {
        self.searchBar = UISearchBar()
        self.flickrTableView = ASTableView()
        super.init(nibName: nil, bundle: nil)
    }

    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flickrTableView.frame = Constants.kFlickrTableViewRect
        self.flickrTableView.asyncDataSource = self
        self.flickrTableView.asyncDelegate = self
        self.flickrTableView.separatorStyle = .None
        self.flickrTableView.backgroundColor = UIColor.whiteColor()
        
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .Minimal
        self.showSearchBar()
        
        self.view.addSubview(self.flickrTableView)
        self.view.addSubview(self.searchBar)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        FlickrViewModel().getInterestingListSignal()
            .observeOn(UIScheduler())
            .on(next: { collection in
                self.flickrTableView.beginUpdates()
                self.flickrArray = collection as! Array<NSURL>
                self.flickrTableView.reloadData()
                self.flickrTableView.endUpdates()
            })
            .start()
    }
    
    
    //MARK: ASTableView methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return flickrArray.count }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        print(flickrArray[indexPath.row].absoluteString)
        return FlickrCell(imageURL: flickrArray[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.imageTapped(indexPath.row)
    }
    
    func showSearchBar() {
        self.searchBar.alpha = 0.0
        UIView.animateWithDuration(0.5, animations: {
            self.searchBar.alpha = 1.0
            self.searchBar.showsCancelButton = true
            self.searchBar.tintColor = UIColor.blackColor()
            self.searchBar.barTintColor = UIColor.blackColor()
            self.searchBar.frame = Constants.kSearchRect
            self.searchBar.endEditing(true)
            }, completion: { _ in self.searchBar.becomeFirstResponder() })
    }
    
    
    //MARK: Full Screen
    func imageTapped(index: Int) {
        let newImageView = UIImageView(image: UIImage(data: NSData(contentsOfURL: flickrArray[index])!))
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) { sender.view?.removeFromSuperview() }
    
    
    //MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 2 {
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool { return true }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) { searchBar.resignFirstResponder() }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) { searchBar.resignFirstResponder() }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) { searchBar.resignFirstResponder() }
}

