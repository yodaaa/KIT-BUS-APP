//
//  InfiniteHarassmentButton.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2019/03/07.
//  Copyright © 2019 yodaaa. All rights reserved.
//

import UIKit
/// 何回閉じても無駄ですよ
/// https://qiita.com/ottijp/items/004e88172a49bd7c7a1f
class InfiniteHarassmentButton: UIAlertController {
    
    public func showAlert() {
        let message = """
　∧_∧　ババババ
（ ・ω・)=つ≡つ
（っ ≡つ=つ
`/　　)
(ノΠＵ
何回閉じても無駄ですよ?ww
m9（＾Д＾）プギャー！！
"""
        
        let dialog = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "閉じる", style: .default, handler: { _ in
            self.showAlert()
        }))
        var baseView = UIApplication.shared.keyWindow?.rootViewController
        while ((baseView?.presentedViewController) != nil)  {
            baseView = baseView?.presentedViewController
        }
        baseView?.present(dialog, animated: true, completion: nil)
    }
}
