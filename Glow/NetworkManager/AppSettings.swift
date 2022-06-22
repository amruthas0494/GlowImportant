//
//  AppSettings.swift
//  Skylor
//
//  Created by Harsha on 9/11/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation


final class AppSettings: NSObject {
    
    class var vendorUUIDString: String? {
        get {
            return self.objectValue(forKey: "app.vendorUUIDString") as? String
        }
        set {
            self.setObjectValue(newValue as NSObject?, forKey: "app.vendorUUIDString")
        }
    }
}

extension AppSettings
{
    class func booleanValue(forKey key : String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func setBooleanValue(_ value : Bool, forKey key : String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func integerValue(forKey key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func setIntegerValue(_ value: Int, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func objectValue<T : NSObject>(forKey key : String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }
    
    class func setObjectValue<T : NSObject>(_ object : T?, forKey key : String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setArrayValue(_ value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func arrayValue(forKey key : String)->[String]? {
        return UserDefaults.standard.object(forKey: key) as? [String]
    }
    class func removeObjectValue(_ key : String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
   class func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded,forKey: key)
          //  UserDefaults.setValue(encoded, forKey: key)
        }
    }
    
     class func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            print("Couldnt find key")
            return nil
        }
    }
    // TODO: Need to conform to NSSecureCoding or NSCoding
    class func setObjectByArchiving<T : NSObject>(_ object : T?, forKey key : String) {
        if let theObject = object {
            let archivedData = try? NSKeyedArchiver.archivedData(withRootObject: theObject, requiringSecureCoding: true)
            self.setObjectValue(archivedData as NSObject?, forKey: key)
        } else {
            self.removeObjectValue(key)
        }
    }
    
    class func objectByUnarchiving<T : NSObject>(forKey key : String) -> T? {
        guard let archivedData = self.objectValue(forKey: key) as? Data else {
            return nil
        }        
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData) as? T
    }
    
    class func setStringValue(_ value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func removeStringValue(_ key : String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func stringValue(forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
        
    }
    
}
