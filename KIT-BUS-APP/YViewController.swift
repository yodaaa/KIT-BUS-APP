//
//  YViewController.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit

class YViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timetable: UIView!
    let screenSize: CGSize = UIScreen.main.bounds.size
    let screenRatioWidth: CGFloat = UIScreen.main.bounds.size.width / 320
    let screenRatioHeight: CGFloat = UIScreen.main.bounds.size.height / 568
    
    let detime = ["8:20", "8:40", "9:20"]
    let arrtime = ["8:50", "9:10", "9:50"]
    
    var timecardview: TimeCardView = TimeCardView()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.timetable.frame = CGRect(x: 10, y: 40, width: 300, height: 600)
//        self.timetable.layer.cornerRadius = 10
//        self.timetable.layer.masksToBounds = false
//        self.timetable.layer.shadowOpacity = 0.7
//        self.timetable.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.timetable.layer.shadowRadius = 5
//        self.timetable.layer.shadowColor = UIColor.black.cgColor
        
        
//        timecardview.frame = CGRect(x: Int(screenRatioWidth*1), y: 10, width: Int(screenSize.width - self.screenRatioWidth*22) , height: Int(screenSize.height))
        timecardview.frame = CGRect(x: Int(screenRatioWidth*1), y: 10, width: Int(screenSize.width - self.screenRatioWidth*20) , height: Int(screenSize.height))
        self.timecardview.delegate = self
        self.timecardview.dataSource = self
        //self.timecardview.frame = CGRect(x: 10, y: 40, width: 300, height: 600)
        self.timecardview.layer.cornerRadius = 10
        self.timecardview.layer.masksToBounds = false
        self.timecardview.layer.shadowOpacity = 0.7
        self.timecardview.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.timecardview.layer.shadowRadius = 5
        self.timecardview.layer.shadowColor = UIColor.black.cgColor

        self.timecardview.register(UINib(nibName: "TimeTableCell", bundle: nil), forCellReuseIdentifier: "TimeTableCell")

        self.timetable.addSubview(timecardview)
        

        //addTimeCard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.detime.count
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableCell") as! TimeTableCell
        cell.layer.cornerRadius = 10
        
        cell.busID.text = String(indexPath.row + 1)
        //cell.departureTimeLabel.text = detime[indexPath.row]
//        cell.arrivalTimeLabel.text = arrtime[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print(indexPath.row)
    }
    
}
