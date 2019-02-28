//
//  CALayer+RuntimeAttribute.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit

extension CALayer {
    func setBorderIBColor(color: UIColor!) -> Void{
        self.borderColor = color.cgColor
    }
}
