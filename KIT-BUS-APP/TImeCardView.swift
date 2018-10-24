//
//  XibView.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit

class TimeCardView: UITableView {
    func loadNib(){
        let view = Bundle.main.loadNibNamed("TimeCardView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    


}
