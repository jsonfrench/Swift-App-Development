//
//  GasPumpsModel .swift
//
//  Created by CS589 on 10/4/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import Foundation

struct GasPump:Codable
{
    var name:String
    var city:String
    var longitude:Double
    var latitude:Double
    var county: String
    var objectId: Int
    var address: String
    var address2: String
    var price: Double
    var brand: String = "generic"
    
    enum CodingKeys: String, CodingKey {
        case name = "SITE_NAME"
        case city = "CITY"
        case longitude = "LONGITUDE"
        case latitude = "LATITUDE"
        case county = "COUNTY"
        case objectId = "OBJECTID"
        case address = "ADDRESS_LINE_1"
        case address2 = "ADDRESS_LINE_2"
        case price = "PRICE"
    }
}


class GasPumpsModel {
    var gasPumps:[GasPump] = []

    // make the class object a Singleton
    static let sharedInstance = GasPumpsModel()
        
    // method to return the singleton instance 
    static func getInstance() -> GasPumpsModel {
        return sharedInstance
    }
    
    // constructor
    private init() {
        readPumpsData()
    }

    
    func readPumpsData() {
        if let filename = Bundle.main.path(forResource: "NJ-GasStations", ofType: "json") {
            do {
                let jsonStr  = try String (contentsOfFile: filename, encoding: .utf8)
                // print (jsonStr)
                let jsonData = jsonStr.data(using: .utf8)!
                gasPumps = try! JSONDecoder().decode([GasPump].self, from: jsonData)
            } catch {
                print("The file could not be loaded")
            }
        } else {
            print ("The file could not be found")
        }
    }
    
    func getPumps() -> [GasPump] {
        return self.gasPumps
    }

    // 1. get gas pump info - You need to implement this method
    func getPumpInfo(stationId: Int) -> GasPump? {
        if let gas_pump = gasPumps.first(where: {$0.objectId == stationId}) {
            return gas_pump
        } else {
            return nil
        }
    }

    
    // 2. update the gas pump price - You need to implement method
    func updatePrice(stationId: Int, updated_price: Double) -> Void {
        var update_index = gasPumps.firstIndex(where: {$0.objectId == stationId})
//        print(update_index!, gasPumps[update_index!])
        gasPumps[update_index!].price = updated_price
        
    }
    
    
//    func updateVisited (teamId: Int, visited visted: Bool) -> Bool {
//        if let index = nflTeams.firstIndex(where: {$0.id == teamId}) {
//            nflTeams[index].visited = visted
//            print (nflTeams[index])
//            return true
//        } else {
//            return false
//        }
//    }

    
}
