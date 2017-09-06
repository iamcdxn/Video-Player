//
//  VideoPlayerTableViewCell.swift
//  VideoPlayer
//
//  Created by CdxN on 2017/9/6.
//  Copyright © 2017年 CdxN.io. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerTableViewCell: UITableViewCell {

    var videoURL = NSURL()

    var player = AVPlayer()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()

    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implementd")

    }

    func setUpViews() {

        self.backgroundColor = UIColor(red: 8.0 / 255.0, green: 21.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)

    }
    
    
}
