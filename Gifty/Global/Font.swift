//
//  Font.swift
//  Gifty
//
//  Created by 주동석 on 2023/09/11.
//

import UIKit

enum Fonts: String {
    case NSB = "NanumSquareB"
    case NSR = "NanumSquareR"
    case NSEB = "NanumSquareEB"
    case NSL = "NanumSquareL"
    
    private func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
    static func nanumSquareB(size: CGFloat) -> UIFont {
        return Fonts.NSB.of(size: size)
    }
    
    static func nanumSquareR(size: CGFloat) -> UIFont {
        return Fonts.NSR.of(size: size)
    }
    
    static func nanumSquareEB(size: CGFloat) -> UIFont {
        return Fonts.NSEB.of(size: size)
    }
    
    static func nanumSquareL(size: CGFloat) -> UIFont {
        return Fonts.NSL.of(size: size)
    }
}
