//
//  SearchCell.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/3.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import Foundation
import UIKit

class SearchCell: UITableViewCell {
    var title = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        var rect = self.frame
        rect.origin.x = 20
        rect.size.width -= 40
        title.frame = rect
        title.textColor = UIColor.blackColor()
    }
    
    func refresh(str:String) {
        title.text = str
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}