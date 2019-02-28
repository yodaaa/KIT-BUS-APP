//
//  OViewController.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit

class OViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timetable: UIView!
    let screenSize: CGSize = UIScreen.main.bounds.size
    let screenRatioWidth: CGFloat = UIScreen.main.bounds.size.width / 320
    let screenRatioHeight: CGFloat = UIScreen.main.bounds.size.height / 568
    
    var timecardview: TimeCardView = TimeCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let week = DetermineDayOfTheWeekdays().getDayOfTheWeek()
        Logger.debugLog(week)
        
        let pre = DetermineDayOfTheWeekdays().getpre10min()
        
        self.timetable.layer.cornerRadius = 10
        self.timetable.layer.masksToBounds = false
        self.timetable.layer.shadowOpacity = 0.7
        self.timetable.layer.shadowOffset = CGSize.zero
        self.timetable.layer.shadowRadius = 5
        self.timetable.layer.shadowColor = UIColor.black.cgColor
        
        timecardview.frame = CGRect(x: 5, y: 10, width: Int(screenSize.width - screenRatioWidth*20) , height: Int(screenSize.height * 0.78))
        //        timecardview.frame = CGRect(x: Int(screenRatioWidth*1), y: 10, width: Int(screenSize.width - self.screenRatioWidth*20) , height: Int(screenSize.height))
        self.timecardview.delegate = self
        self.timecardview.dataSource = self
        //self.timecardview.frame = CGRect(x: 10, y: 40, width: 300, height: 600)
        //        self.timecardview.layer.cornerRadius = 10
        //        self.timecardview.layer.masksToBounds = false
        //        self.timecardview.layer.shadowOpacity = 0.7
        //        self.timecardview.layer.shadowOffset = CGSize.zero//CGSize(width: 5, height: 5)
        //        self.timecardview.layer.shadowRadius = 5
        //        self.timecardview.layer.shadowColor = UIColor.black.cgColor
        //self.timecardview.center = self.timetable.center
        self.timecardview.register(UINib(nibName: "TimeTableCell", bundle: nil), forCellReuseIdentifier: "TimeTableCell")
        
        self.timetable.addSubview(timecardview)
        // constraints
        self.timecardview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.detime.count
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableCell") as! TimeTableCell
        cell.layer.cornerRadius = 10
        
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        
        // 日時を取得
        let date = Date()
        // 日時判定を行ういクラスのインスタンス生成
        let determinationFromDateTime = DetermineDayOfTheWeekdays()
        // 日時(曜日に合わせて、表示する時刻表を変える)
        if  determinationFromDateTime.judgeHoliday(date) {
            // 祝日の場合
            cell.busID.text = ""
            cell.arrivalTimeLabel.text = ""
            
            if indexPath.row == 0 {
                cell.departureTimeLabel.text = "本日のバスはありません。"
            } else {
                cell.departureTimeLabel.text = ""
            }
            
        } else {
            // 祝日でない場合
            
            // 土曜日の場合
            if determinationFromDateTime.judgeSaturday(date) {
                cell.busID.text = String(NSString(format: "%02d", indexPath.row+1))
                let deTimeStr = format.date(from: Const().detime_goo_sat[indexPath.row])
                cell.departureTimeLabel.text = format.string(from: deTimeStr!)
                
                let arrTimeStr = format.date(from: Const().arrtime_goo_sat[indexPath.row])
                cell.arrivalTimeLabel.text = format.string(from: arrTimeStr!)
            } else if determinationFromDateTime.judgeSunday(date) {
                //日曜日の場合
                cell.busID.text = ""
                cell.arrivalTimeLabel.text = ""
                
                if indexPath.row == 0 {
                    cell.departureTimeLabel.text = "本日のバスはありません。"
                } else {
                    cell.departureTimeLabel.text = ""
                }
            } else {
                // 夏季休業・春季休業期間中に関する処理
                var dateS = Date()
                var dateE = Date()
                let formatYMD:DateFormatter = DateFormatter()
                formatYMD.dateFormat = "yyyy/MM/dd"
                dateS = formatYMD.date(from: "2019/03/01")!
                dateE = formatYMD.date(from: "2019/03/29")!
                
                if (dateS < date && date < dateE) {
                    // 夏季休業・春季休業期間中
                    // 平日
                    if indexPath.row < Const().arrtime_goo_longh.count {
                        cell.busID.text = String(NSString(format: "%02d", indexPath.row+1))
                        let deTimeStr = format.date(from: Const().detime_goo_longh[indexPath.row])
                        cell.departureTimeLabel.text = format.string(from: deTimeStr!)
                        
                        let arrTimeStr = format.date(from: Const().arrtime_goo_longh[indexPath.row])
                        cell.arrivalTimeLabel.text = format.string(from: arrTimeStr!)
                    } else {
                        cell.busID.text = ""
                        cell.departureTimeLabel.text = ""
                        cell.arrivalTimeLabel.text = ""
                    }
                } else {
                    // 平日
                    cell.busID.text = String(NSString(format: "%02d", indexPath.row+1))
                    let deTimeStr = format.date(from: Const().detime_goo[indexPath.row])
                    cell.departureTimeLabel.text = format.string(from: deTimeStr!)
                    
                    let arrTimeStr = format.date(from: Const().arrtime_goo[indexPath.row])
                    cell.arrivalTimeLabel.text = format.string(from: arrTimeStr!)
                }
                
                
                let formatter = DateIntervalFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                
                Logger.debugLog(formatter.string(from: dateS, to: dateE))
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
