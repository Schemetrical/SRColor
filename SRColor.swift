//
//  SRColor.swift
//  Created by Schemetrical (Yichen Cao)
//  Inspired by Eric Sadun's Color Pack, which was contributed by Poltras, Millenomi, Eridius, Nownot, WhatAHam, jberry, and everyone else who helped out but whose name was inadvertantly omitted
//
//

/*
GPL v2 License.

This work 'as-is' I provide.
No warranty express or implied.
I've done my best,
to debug and test.
Liability for damages denied.
*/

import Foundation

extension UIColor {
    
    var canProvideRGBComponents:Bool {
        switch self.colorSpaceModel {
        case 0, 1:
            return true
        default:
            return false
        }
    }
    
    var colorSpaceModel:Int32 {
        return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)).value
    }
}

@infix func += (inout left: UIColor!, right: UIColor!) {
    left = left + right
}

@infix func + (left: UIColor, right: UIColor) -> UIColor? {
//    assert(left.canProvideRGBComponents, "Must be a RGB color to use arithmetic operations")
//    assert(right.canProvideRGBComponents, "Must be a RGB color to use arithmetic operations")
    
    var (lr:CGFloat, lg:CGFloat, lb:CGFloat, la:CGFloat) = (0.0,0.0,0.0,0.0)
    var (rr:CGFloat, rg:CGFloat, rb:CGFloat, ra:CGFloat) = (0.0,0.0,0.0,0.0)
    if !left.getRed(&lr, green: &lg, blue: &lb, alpha: &la) {return nil}
    if !left.getRed(&rr, green: &rg, blue: &rb, alpha: &ra) {return nil}
    
    return UIColor(
        red: <>(lr + rr),
        green: <>(lg + rg),
        blue: <>(lb + rb),
        alpha: <>(la + ra)
    )
}

operator prefix <> {}

/// Clamp prefix
@prefix func <> (float: CGFloat) -> CGFloat {
    return cgfmax(0.0, cgfmin(1.0, float))
}

func cgfmin(a:CGFloat, b:CGFloat) -> CGFloat {
    return a < b ? a : b
}

func cgfmax(a:CGFloat, b:CGFloat) -> CGFloat {
    return a > b ? a : b
}