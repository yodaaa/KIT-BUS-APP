//
//  YViewController.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit
import UserNotifications

class YViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timetable: UIView!
    let screenSize: CGSize = UIScreen.main.bounds.size
    let screenRatioWidth: CGFloat = UIScreen.main.bounds.size.width / 320
    let screenRatioHeight: CGFloat = UIScreen.main.bounds.size.height / 568
    
    
    var timecardview: TimeCardView = TimeCardView()
    
    var copyIndexPath: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.timetable.frame = CGRect(x: 10, y: 40, width: 300, height: 600)
//        self.timetable.layer.cornerRadius = 10
//        self.timetable.layer.masksToBounds = false
//        self.timetable.layer.shadowOpacity = 0.7
//        self.timetable.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.timetable.layer.shadowRadius = 5
//        self.timetable.layer.shadowColor = UIColor.black.cgColor
        self.timetable.layer.cornerRadius = 10
        self.timetable.layer.masksToBounds = false
        self.timetable.layer.shadowOpacity = 0.7
        self.timetable.layer.shadowOffset = CGSize.zero
        self.timetable.layer.shadowRadius = 5
        self.timetable.layer.shadowColor = UIColor.black.cgColor
        
        timecardview.frame = CGRect(x: 5, y: 10, width: Int(screenSize.width - screenRatioWidth*20) , height: Int(screenSize.height * 0.78))

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
        

        //addTimeCard()
        print("---------")
        guard let data = try? getJSONData() else { return }
        print("data:\(data!)")
        guard let animals = try? JSONDecoder().decode(BusList.self, from: data!) else { return print("error") }

        print("animals.week:\(animals.duringTerm)")
        
        print("---------")
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        
        // -----
        let format = DateFormatter()
        format.dateFormat = "HH:mm"

        // 日時を取得
        let date = Date()
        // 日時判定を行ういクラスのインスタンス生成
        let determinationFromDateTime = DetermineDayOfTheWeekdays()
        // 日時(曜日に合わせて、表示する時刻表を変える)
        let setData: [[String]] = determinationFromDateTime.changeTimelinebyWeekday(date, true)
        Logger.debugLog(setData)
        
        if setData[0].isEmpty {
            //
            if indexPath.row == 0 {
                cell.busID.text = ""
                cell.arrivalTimeLabel.text = ""
                cell.arrowLabel.text = "本日のバスはありません。"
                cell.departureTimeLabel.text = ""
                //cell.notifyButton.isHidden = true
            } else {
                setTableEmpty(cell)
            }
            
        } else {
            if indexPath.row < setData[0].count {
                setTableDate(cell, format, indexPath, setData[0], setData[1])
            } else {
                setTableEmpty(cell)
            }
            
        }
        // -----
        
        return cell
    }
    
    // バスの便がなく, cellが空の場合
    func setTableEmpty(_ cell: TimeTableCell)  {
        cell.busID.text = ""
        cell.departureTimeLabel.text = ""
        cell.arrivalTimeLabel.text = ""
        cell.arrowLabel.text = ""
        cell.notifyButton.isHidden = true
    }
    
    // cellにぶバスの時刻などをセットする
    func setTableDate(_ cell: TimeTableCell, _ format: DateFormatter, _ indexPath: IndexPath, _ detime: [String], _ arrtime: [String]) {
        cell.busID.text = String(NSString(format: "%02d", indexPath.row+1))
        let deTimeStr = format.date(from: detime[indexPath.row])
        cell.departureTimeLabel.text = format.string(from: deTimeStr!)
        
        let arrTimeStr = format.date(from: arrtime[indexPath.row])
        cell.arrivalTimeLabel.text = format.string(from: arrTimeStr!)
        
        cell.notifyButton.isHidden = false
        cell.notifyButton.tag = (indexPath.section*100) + indexPath.row
        cell.notifyButton.addTarget(self, action: #selector(notifyButtonAction(_:)), for: UIControlEvents.touchUpInside)
    }
    
    // debug
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print(indexPath.row)
    }
    
    /// 通知のボタンのアクション
    @objc func notifyButtonAction(_ sender: UIButton) {
        // buttonのtagからsectionとrowを分解取得
        let section = sender.tag / 100
        let row = sender.tag % 100
        let indexPath = NSIndexPath(row: row, section: section)
        // setNotifyにindexPathを渡す
        self.setNotify(indexPath as IndexPath)
    }
    
    /// 通知を設定する
    func setNotify(_ indexPath: IndexPath)  {
        Logger.debugLog(indexPath) // [0, 0] ~ [0, 12]あたりが表示される
        
        // 通知許可ダイアログを表示
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // エラー処理
        }
        // 通知内容の設定
        let content = UNMutableNotificationContent()
        // 通知のタイトルを設定
        content.title = NSString.localizedUserNotificationString(forKey: "八束穂行きバス ", arguments: nil)
        // 通知の本文を設定
        content.body = NSString.localizedUserNotificationString(forKey: "発車まで あと15分です", arguments: nil)
        // 通知の音楽を設定
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        center.add(request) { (error : Error?) in
            if error != nil {
                // エラー処理
            }
        }
    }
}
