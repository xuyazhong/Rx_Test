//
//  SearchModel.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/3.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import Foundation
import EVReflection

class SearchModel: EVObject {
    
    var msg : String?
    
    var status: String?
    
    var data: [SearchItem]?
    
}

class SearchItem: EVObject {
    
    var prompt: String?
    var prompt_id: String?
    var prompt_encoded_id: String?
    var prompt_type: String?
    var city_name: String?
    var country_name: String?
    
}