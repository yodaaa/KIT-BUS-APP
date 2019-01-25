//
//  bulistJSON.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/29.
//  Copyright © 2018 yodaaa. All rights reserved.
//

import Foundation

struct BusList: Codable {
    var Weekday: Bool
    var duringTerm: Bool
    var buslist: [String]
    
}



//let data = jsonstr.data(using: .utf8)!



func createBusList(from jsonText: String) -> BusList? {
    guard let data = jsonText.data(using: String.Encoding.utf8) else { return nil }
    
    var buslist:BusList
    do {
        let decoder = JSONDecoder()
        buslist = try decoder.decode(BusList.self, from: data)
    } catch {
        print(error.localizedDescription)
        return nil
    }
    return buslist
}


func getJSONData() throws -> Data? {
    guard let path = Bundle.main.path(forResource: "buslist_go_y", ofType: "json") else { return nil }
    print(path)
    let url = URL(fileURLWithPath: path)
    print("url:\(url)")
    
    return try Data(contentsOf: url)
}


