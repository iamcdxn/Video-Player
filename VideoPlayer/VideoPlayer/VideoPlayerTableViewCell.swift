//
//  VideoPlayerTableViewCell.swift
//  VideoPlayer
//
//  Created by CdxN on 2017/9/6.
//  Copyright © 2017年 CdxN.io. All rights reserved.
//

import UIKit

class VideoPlayerTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()

    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implementd")

    }

    func setUpViews() {

        self.bounds = CGRect(x: 0, y: 0, width: 375.0, height: 667.0)

    }

}
