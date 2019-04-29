//
//  TweetsTableViewController.swift
//  Tweeties
//
//  Created by mac on 4/28/19.
//  Copyright © 2019 Developers Academy. All rights reserved.
//

import UIKit
import Twitter

class TweetsTableViewController: UITableViewController {
    
    private var tweets = [[Tweet]]()
    var searchText: String? {
        didSet {
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
        }
    }
    
   private func twitterRequest() -> Request? {
        if let queryText = searchText, !queryText.isEmpty {
            return Request(search: queryText, count: 100)
        }
        return nil
    }
    
    private var lastTwitterRequest: Request?
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            self.lastTwitterRequest = request

            request.fetchTweets { [weak self] newTweets in
                if request == self?.lastTwitterRequest {
                    self?.tweets.insert(newTweets, at: 0)
                    print(self?.tweets)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText = "Constantine05419547"
    }
}



