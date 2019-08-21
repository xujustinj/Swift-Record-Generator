//
//  DictionaryHelper.swift
//  Record
//
//  Created by Justin Xu on 2019-07-01.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(identifier: "UTC")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    return formatter
}()

extension Dictionary where Key == String, Value == AnyObject {
    // Int
    @inline(__always) func getInt(key: String) -> Int? {
        return self[key] as? Int
    }
    @inline(__always) func getIntByForce(key: String) -> Int {
        return self[key] as! Int
    }
    @inline(__always) mutating func setInt(key: String, _ int: Int?) {
        self[key] = int as AnyObject?
    }
    @inline(__always) mutating func setIntByForce(key: String, _ int: Int) {
        self[key] = int as AnyObject
    }
    
    // UInt
    @inline(__always) func getUInt(key: String) -> UInt? {
        return self[key] as? UInt
    }
    @inline(__always) func getUIntByForce(key: String) -> UInt {
        return self[key] as! UInt
    }
    @inline(__always) mutating func setUInt(key: String, _ uInt: UInt?) {
        self[key] = uInt as AnyObject?
    }
    @inline(__always) mutating func setUIntByForce(key: String, _ uInt: UInt) {
        self[key] = uInt as AnyObject
    }
    
    // Double
    @inline(__always) func getDouble(key: String) -> Double? {
        return self[key] as? Double
    }
    @inline(__always) func getDoubleByForce(key: String) -> Double {
        return self[key] as! Double
    }
    @inline(__always) mutating func setDouble(key: String, _ double: Double?) {
        self[key] = double as AnyObject?
    }
    @inline(__always) mutating func setDoubleByForce(key: String, _ double: Double) {
        self[key] = double as AnyObject
    }
    
    // Bool
    @inline(__always) func getBool(key: String) -> Bool? {
        return self[key] as? Bool
    }
    @inline(__always) func getBoolByForce(key: String) -> Bool {
        return self[key] as! Bool
    }
    @inline(__always) mutating func setBool(key: String, _ bool: Bool?) {
        self[key] = bool as AnyObject?
    }
    @inline(__always) mutating func setBoolByForce(key: String, _ bool: Bool) {
        self[key] = bool as AnyObject
    }
    
    // String
    @inline(__always) func getString(key: String) -> String? {
        return self[key] as? String
    }
    @inline(__always) func getStringByForce(key: String) -> String {
        return self[key] as! String
    }
    @inline(__always) mutating func setString(key: String, _ string: String?) {
        self[key] = string as AnyObject?
    }
    @inline(__always) mutating func setStringByForce(key: String, _ string: String) {
        self[key] = string as AnyObject
    }
    
    // Date
    @inline(__always) func getDate(key: String) -> Date? {
        guard let string = self[key] as? String else { return nil }
        return dateFormatter.date(from: string)
    }
    @inline(__always) func getDateByForce(key: String) -> Date {
        return dateFormatter.date(from: self[key] as! String)!
    }
    @inline(__always) mutating func setDate(key: String, _ date: Date?) {
        if let date = date { self[key] = dateFormatter.string(from: date) as AnyObject } else { self[key] = nil }
    }
    @inline(__always) mutating func setDateByForce(key: String, _ date: Date) {
        self[key] = dateFormatter.string(from: date) as AnyObject
    }
    
    // Int array
    @inline(__always) func getArrayInt(key: String) -> [Int]? {
        return self[key] as? [Int]
    }
    @inline(__always) func getArrayIntByForce(key: String) -> [Int] {
        return self[key] as! [Int]
    }
    @inline(__always) mutating func setArrayInt(key: String, _ array: [Int]?) {
        self[key] = array as AnyObject?
    }
    @inline(__always) mutating func setArrayIntByForce(key: String, _ array: [Int]) {
        self[key] = array as AnyObject
    }
    
    // UInt array
    @inline(__always) func getArrayUInt(key: String) -> [UInt]? {
        return self[key] as? [UInt]
    }
    @inline(__always) func getArrayUIntByForce(key: String) -> [UInt] {
        return self[key] as! [UInt]
    }
    @inline(__always) mutating func setArrayUInt(key: String, _ array: [UInt]?) {
        self[key] = array as AnyObject?
    }
    @inline(__always) mutating func setArrayUIntByForce(key: String, _ array: [UInt]) {
        self[key] = array as AnyObject
    }
    
    // Double array
    @inline(__always) func getArrayDouble(key: String) -> [Double]? {
        return self[key] as? [Double]
    }
    @inline(__always) func getArrayDoubleByForce(key: String) -> [Double] {
        return self[key] as! [Double]
    }
    @inline(__always) mutating func setArrayDouble(key: String, _ array: [Double]?) {
        self[key] = array as AnyObject?
    }
    @inline(__always) mutating func setArrayDoubleByForce(key: String, _ array: [Double]) {
        self[key] = array as AnyObject
    }
    
    // Bool array
    @inline(__always) func getArrayBool(key: String) -> [Bool]? {
        return self[key] as? [Bool]
    }
    @inline(__always) func getArrayBoolByForce(key: String) -> [Bool] {
        return self[key] as! [Bool]
    }
    @inline(__always) mutating func setArrayBool(key: String, _ array: [Bool]?) {
        self[key] = array as AnyObject?
    }
    @inline(__always) mutating func setArrayBoolByForce(key: String, _ array: [Bool]) {
        self[key] = array as AnyObject
    }
    
    // String array
    @inline(__always) func getArrayString(key: String) -> [String]? {
        return self[key] as? [String]
    }
    @inline(__always) func getArrayStringByForce(key: String) -> [String] {
        return self[key] as! [String]
    }
    @inline(__always) mutating func setArrayString(key: String, _ array: [String]?) {
        self[key] = array as AnyObject?
    }
    @inline(__always) mutating func setArrayStringByForce(key: String, _ array: [String]) {
        self[key] = array as AnyObject
    }
    
    // Date array
    @inline(__always) func getArrayDate(key: String) -> [Date]? {
        return (self[key] as? [String])?.compactMap { dateFormatter.date(from: $0) }
    }
    @inline(__always) func getArrayDateByForce(key: String) -> [Date] {
        return (self[key] as! [String]).map { dateFormatter.date(from: $0)! }
    }
    @inline(__always) mutating func setArrayDate(key: String, _ array: [Date]?) {
        self[key] = array?.map { dateFormatter.string(from: $0) } as AnyObject?
    }
    @inline(__always) mutating func setArrayDateByForce(key: String, _ array: [Date]) {
        self[key] = array.map { dateFormatter.string(from: $0) } as AnyObject
    }
    
    // Int dictionary
    @inline(__always) func getDictionaryInt(key: String) -> [String : Int]? {
        return self[key] as? [String : Int]
    }
    @inline(__always) func getDictionaryIntByForce(key: String) -> [String : Int] {
        return self[key] as! [String : Int]
    }
    @inline(__always) mutating func setDictionaryInt(key: String, _ dictionary: [String : Int]?) {
        self[key] = dictionary as AnyObject?
    }
    @inline(__always) mutating func setDictionaryIntByForce(key: String, _ dictionary: [String : Int]) {
        self[key] = dictionary as AnyObject
    }
    
    // UInt dictionary
    @inline(__always) func getDictionaryUInt(key: String) -> [String : UInt]? {
        return self[key] as? [String : UInt]
    }
    @inline(__always) func getDictionaryUIntByForce(key: String) -> [String : UInt] {
        return self[key] as! [String : UInt]
    }
    @inline(__always) mutating func setDictionaryUInt(key: String, _ dictionary: [String : UInt]?) {
        self[key] = dictionary as AnyObject?
    }
    @inline(__always) mutating func setDictionaryUIntByForce(key: String, _ dictionary: [String : UInt]) {
        self[key] = dictionary as AnyObject
    }
    
    // Double dictionary
    @inline(__always) func getDictionaryDouble(key: String) -> [String : Double]? {
        return self[key] as? [String : Double]
    }
    @inline(__always) func getDictionaryDoubleByForce(key: String) -> [String : Double] {
        return self[key] as! [String : Double]
    }
    @inline(__always) mutating func setDictionaryDouble(key: String, _ dictionary: [String : Double]?) {
        self[key] = dictionary as AnyObject?
    }
    @inline(__always) mutating func setDictionaryDoubleByForce(key: String, _ dictionary: [String : Double]) {
        self[key] = dictionary as AnyObject
    }
    
    // Bool dictionary
    @inline(__always) func getDictionaryBool(key: String) -> [String : Bool]? {
        return self[key] as? [String : Bool]
    }
    @inline(__always) func getDictionaryBoolByForce(key: String) -> [String : Bool] {
        return self[key] as! [String : Bool]
    }
    @inline(__always) mutating func setDictionaryBool(key: String, _ dictionary: [String : Bool]?) {
        self[key] = dictionary as AnyObject?
    }
    @inline(__always) mutating func setDictionaryBoolByForce(key: String, _ dictionary: [String : Bool]) {
        self[key] = dictionary as AnyObject
    }
    
    // String dictionary
    @inline(__always) func getDictionaryString(key: String) -> [String : String]? {
        return self[key] as? [String : String]
    }
    @inline(__always) func getDictionaryStringByForce(key: String) -> [String : String] {
        return self[key] as! [String : String]
    }
    @inline(__always) mutating func setDictionaryString(key: String, _ dictionary: [String : String]?) {
        self[key] = dictionary as AnyObject?
    }
    @inline(__always) mutating func setDictionaryStringByForce(key: String, _ dictionary: [String : String]) {
        self[key] = dictionary as AnyObject
    }
    
    // Date dictionary
    @inline(__always) func getDictionaryDate(key: String) -> [String : Date]? {
        guard let strings = self[key] as? [String : String] else { return nil }
        return Dictionary<String, Date>(uniqueKeysWithValues: strings.compactMap { (pair: (key: String, value: String)) -> (key: String, value: Date)? in
            if let date = dateFormatter.date(from: pair.value) {
                return (key: pair.key, value: date)
            } else {
                return nil
            }
        })
    }
    @inline(__always) func getDictionaryDateByForce(key: String) -> [String : Date] {
        return (self[key] as! [String : String]).mapValues { dateFormatter.date(from: $0)! }
    }
    @inline(__always) mutating func setDictionaryDate(key: String, _ dictionary: [String : Date]?) {
        self[key] = dictionary?.mapValues { dateFormatter.string(from: $0) } as AnyObject?
    }
    @inline(__always) mutating func setDictionaryDateByForce(key: String, _ dictionary: [String : Date]) {
        self[key] = dictionary.mapValues { dateFormatter.string(from: $0) } as AnyObject
    }
}
