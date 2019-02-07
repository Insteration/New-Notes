//
//  Notes.swift
//  New Notes
//
//  Created by Artem Karmaz on 2/7/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

class Note {
    var contents: String
    var title: String {
        let lines = contents.components(separatedBy: CharacterSet.newlines)
        return lines[0]
    }
    
    init(text: String) {
        contents = text
    }
    
}
