//
//  TimeTableCell.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit

class TimeTableCell: UITableViewCell{
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var busID: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    


}
