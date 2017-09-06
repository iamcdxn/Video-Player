//
//  VideoPlayerTableViewController.swift
//  VideoPlayer
//
//  Created by CdxN on 2017/9/6.
//  Copyright © 2017年 CdxN.io. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerTableViewController: UITableViewController {

    var searchController: UISearchController!

    let fullScreenSize = UIScreen.main.bounds.size

    let toolbar = UIToolbar()

    var searchURL = String()

    override func viewDidLoad() {

        super.viewDidLoad()

        setUpSearchBar()

        searchController.searchBar.delegate = self

        setUpToolBar()

        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.estimatedRowHeight = fullScreenSize.height

        self.tableView.register(VideoPlayerTableViewCell.self, forCellReuseIdentifier: "VideoPlayerTableViewCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//
//    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//
//    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        return 40.0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fullScreenSize.height - 100.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayerTableViewCell", for: indexPath)

        let videoURL = NSURL(string: self.searchURL)

        let player = AVPlayer(url: videoURL! as URL)

        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.frame = cell.bounds

        cell.layer.addSublayer(playerLayer)

        player.play()

        return cell

    }

    func setUpSearchBar() {

        // 建立 UISearchController 並設置搜尋控制器為 nil
        self.searchController =
            UISearchController(searchResultsController: nil)

        // 將更新搜尋結果的對象設為 self
        self.searchController.searchResultsUpdater = self as? UISearchResultsUpdating

        // 搜尋時是否隱藏 NavigationBar
        // 這個範例沒有使用 NavigationBar 所以設置什麼沒有影響
        self.searchController
            .hidesNavigationBarDuringPresentation = false

        // 搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
        self.searchController
            .dimsBackgroundDuringPresentation = false

        // 搜尋框的樣式
        self.searchController.searchBar.searchBarStyle = .prominent

        // 設置搜尋框的尺寸為自適應
        // 因為會擺在 tableView 的 header
        // 所以尺寸會與 tableView 的 header 一樣
        self.searchController.searchBar.sizeToFit()

        self.searchController.searchBar.text = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"

        // 將搜尋框擺在 tableView 的 header
        self.tableView.tableHeaderView = self.searchController.searchBar

    }

    func setUpToolBar() {

        let browserToolbar =  UIToolbar(frame:CGRect(x:0, y:20, width:320, height:44))

        browserToolbar.backgroundColor = UIColor.white

        let btn1 =  UIBarButtonItem(barButtonSystemItem:.compose, target:nil, action:nil);
        let btn2 =  UIBarButtonItem(barButtonSystemItem:.add, target:nil, action:nil);
        let btn3 =  UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target:nil, action:nil);
        let btn4 =  UIBarButtonItem(barButtonSystemItem:.reply, target:nil, action:nil);

        browserToolbar.setItems([btn1, btn2, btn3, btn4], animated: false)

        self.tableView.tableFooterView = browserToolbar

    }

}

extension VideoPlayerTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        guard let textToSearch = searchBar.text  else { return }

        self.searchURL = textToSearch

        self.tableView.reloadData()

    }

}
