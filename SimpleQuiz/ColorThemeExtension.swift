//
//  ColorThemeExtension.swift
//  SimpleQuiz
//
//  Created by Felix Hedlund on 2016-11-06.
//  Copyright © 2016 Felix Hedlund. All rights reserved.
//

import UIKit

extension UIColor{
    static let quizRed = UIColor.HexToColor("#ffb3ba", alpha: 1.0)
    static let quizOrange = UIColor.HexToColor("#ffdfba", alpha: 1.0)
    static let quizYellow = UIColor.HexToColor("#ffffba", alpha: 1.0)
    static let quizGreen = UIColor.HexToColor("#baffc9", alpha: 1.0)
    static let quizBlue = UIColor.HexToColor("#bae1ff", alpha: 1.0)
}

extension UIColor{
    static func HexToColor(_ hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    static fileprivate func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
