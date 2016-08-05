import Foundation

extension SecKey {
    
    /// Provides the raw key data. Wraps `SecItemCopyMatching()`.
    public var keyData: [UInt8] {
        let query = [ kSecValueRef as String : self, kSecReturnData as String : true ]
        var out: AnyObject?
        guard errSecSuccess == SecItemCopyMatching(query, &out) else {
            return []
        }
        guard let data = out as? NSData else {
            return []
        }

        var bytes = [UInt8](count: data.length, repeatedValue: 0)
        data.getBytes(&bytes, length:data.length)
        return bytes
    }
    
}
