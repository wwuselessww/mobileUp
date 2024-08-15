//
//  KeychainManager.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import Foundation

class KeychainManager {
    
    enum KeychainErrors: Error {
        case duplicateEntry
        case unknownError(OSStatus)
    }
    
    static func save(service: String, account: String, token: Data) throws{
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: token as AnyObject,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainErrors.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainErrors.unknownError(status)
        }
        
        print("saved")
        
    }
    
    static func fetch(service: String, account: String) throws -> Data?{
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        print("fetched", status)
        return result as? Data
    }
    
    static func delete(service: String, account: String) throws{
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]

        let status = SecItemDelete(query as CFDictionary)
        print("deleted", status)
    }
}
