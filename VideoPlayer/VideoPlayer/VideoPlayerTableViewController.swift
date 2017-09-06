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

    var shouldPlay = true

    var shouldmute = true

    override func viewDidLoad() {

        super.viewDidLoad()

        setUpSearchBar()

        searchController.searchBar.delegate = self

        setUpToolBar()

        self.searchController.searchBar.barStyle = .black

        self.tableView.tableFooterView?.backgroundColor = UIColor.black

        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.estimatedRowHeight = fullScreenSize.height

        self.tableView.register(VideoPlayerTableViewCell.self, forCellReuseIdentifier: "VideoPlayerTableViewCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return fullScreenSize.height - 100.0

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayerTableViewCell", for: indexPath) as! VideoPlayerTableViewCell
        //swiftlint:enable force_cast

        cell.player = AVPlayer(url: NSURL(string: self.searchURL)! as URL)

        let playerLayer = AVPlayerLayer(player: cell.player)

        playerLayer.frame = cell.bounds

        cell.player.addObserver(self, forKeyPath: "rate", options:NSKeyValueObservingOptions(), context: nil)

        cell.layer.addSublayer(playerLayer)

        cell.player.play()

        cell.selectionStyle = .none

        print(indexPath)

        return cell

    }

    private func deallocObservers(player: AVPlayer) {
        player.removeObserver(self, forKeyPath: "rate")
    }

    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        print("oberved")

    }

    func setUpSearchBar() {

        self.searchController =
            UISearchController(searchResultsController: nil)

        self.searchController.searchResultsUpdater = self as? UISearchResultsUpdating

        self.searchController
            .hidesNavigationBarDuringPresentation = false

        self.searchController
            .dimsBackgroundDuringPresentation = false

        self.searchController.searchBar.searchBarStyle = .prominent

        self.searchController.searchBar.sizeToFit()

        self.searchController.searchBar.text = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"

        self.tableView.tableHeaderView = self.searchController.searchBar

    }

    func setUpToolBar() {

        let browserToolbar =  UIToolbar(frame:CGRect(x:0, y:20, width:320, height:44))

        browserToolbar.backgroundColor = UIColor.black

        let playPauseButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playPause))

        playPauseButton.tintColor = UIColor.white

        let space =  UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target:nil, action: nil)

        let muteButton =  UIBarButtonItem(title: "mute", style: .plain, target: self, action: #selector(muteUnmute))

        muteButton.tintColor = UIColor.white

        browserToolbar.setItems([playPauseButton, space, muteButton], animated: false)

        self.tableView.tableFooterView = browserToolbar

    }

    func playPause() {

        print("PlayPause")

        guard let videoCell = self.tableView.cellForRow(at: [0, 0]) as? VideoPlayerTableViewCell else { return }

        if shouldPlay {

            videoCell.player.pause()

            shouldPlay = false

        } else {

            videoCell.player.play()

            shouldPlay = true

        }

    }

    func muteUnmute() {

        print("Mute / Unmute")

        guard let videoCell = self.tableView.cellForRow(at: [0, 0]) as? VideoPlayerTableViewCell else { return }

        if shouldPlay {

            videoCell.player.isMuted = true

            shouldmute = false

        } else {

            videoCell.player.isMuted = false

            shouldmute = true

        }

    }

}

extension VideoPlayerTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let textToSearch = searchBar.text  else { return }

        self.searchURL = textToSearch

        self.tableView.reloadData()

    }

}
