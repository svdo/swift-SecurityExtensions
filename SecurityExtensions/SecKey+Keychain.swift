// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Foundation
import Security
import IDZSwiftCommonCrypto

extension SecKey {
    /**
     * Returns the tag that was used to store the key in the keychain.
     * You can use this tag to retrieve the key using `loadFromKeychain(tag:)`
     *
     * - returns: the tag of the key
     */
    public var keychainTag: String? {
        guard let keyData = self.keyData else {
            return nil
        }
        return SecKey.keychainTag(forKeyData: keyData)
    }

    /**
     * Returns the tag of a key that is represented by the given key data.
     * Normally you should prefer using the instance property `keychainTag`
     * instead.
     */
    static public func keychainTag(forKeyData data: [UInt8]) -> String {
        let sha1 = Digest(algorithm: .sha1)
        _ = sha1.update(buffer: data, byteCount: data.count)
        let digest = sha1.final()
        return digest.hexString()
    }

    /**
     * Loads a key from the keychain given its tag. The tag is the string returned by
     * the property `keychainTag`.
     *
     * - parameter tag: the tag as returned by `keychainTag`
     * - returns: the retrieved key, if found
     */
    static public func loadFromKeychain(tag: String) -> SecKey? {
        let query: [String:AnyObject] = [
                kSecClass as String: kSecClassKey,
                kSecAttrApplicationTag as String: tag as AnyObject,
                kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                kSecReturnRef as String: true as AnyObject
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard let resultObject = result, status == errSecSuccess
                  && CFGetTypeID(resultObject) == SecKeyGetTypeID() else {
            return nil
        }
        return (resultObject as! SecKey)
    }
}
