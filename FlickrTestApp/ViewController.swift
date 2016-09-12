//
//  ViewController.swift
//  FlickrTestApp
//
//  Created by Gareth.K.Mensah on 9/11/16.
//  Copyright © 2016 Gareth.K.Mensah. All rights reserved.
//

import Foundation
import AsyncDisplayKit

final class ViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate, UISearchBarDelegate {
    
    //MARK: Properties
    private let searchBar: UISearchBar
    private let flickrTableView: ASTableView
    
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
        
        FlickrViewModel().getInterestingListSignal().start()
        
        self.flickrTableView.frame = Constants.kFlickrTableViewRect
        self.flickrTableView.asyncDataSource = self
        self.flickrTableView.asyncDelegate = self
        self.flickrTableView.separatorStyle = .None
        self.flickrTableView.backgroundColor = UIColor.blackColor()
        
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .Minimal
        self.showSearchBar()
        
        self.view.addSubview(self.flickrTableView)
    }
    
    
    //MARK: ASTableView methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let node: ASCellNode = ASCellNode()
        return node
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func showSearchBar() {
        guard self.view.subviews.contains(self.searchBar) == false else { return hideSearchBar() }
        self.searchBar.alpha = 0.0
        UIView.animateWithDuration(0.5, animations: {
            self.searchBar.alpha = 1.0
            self.searchBar.showsCancelButton = true
            self.searchBar.tintColor = UIColor.whiteColor()
            self.searchBar.barTintColor = UIColor.whiteColor()
            self.searchBar.frame = Constants.kSearchRect
            self.view.addSubview(self.searchBar)
            self.searchBar.endEditing(true)
            }, completion: { _ in self.searchBar.becomeFirstResponder() })
    }
    
    func hideSearchBar() {
        UIView.animateWithDuration(0.3, animations: {
            self.searchBar.alpha = 0 }, completion: { _ in self.searchBar.removeFromSuperview()
        })
    }
    
    
    //MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 2 {
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) { self.hideSearchBar() }
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool { return true }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) { searchBar.resignFirstResponder() }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) { searchBar.resignFirstResponder() }
}

