//
//  NSAttributedStringExtensions.swift
//  MazeTv
//
//  Created by Karolina Attekita on 12/02/22.
//

import Foundation

extension NSAttributedString {
    
    static func fromHTML(html: String) -> NSAttributedString? {
        let style = "<style>body{font-family: sans-serif; font-size:18px; color: gray; }</style>"
        let data = Data(html.appending(String(format: style)).utf8)
        let attributedString = try? NSAttributedString(data: data,
                                                       options: [.documentType: NSAttributedString.DocumentType.html],
                                                       documentAttributes: nil)
        return attributedString
    }
}
