import Foundation

extension SecKey {
    
    /**
     * Provides the raw key data. Wraps `SecItemCopyMatching()`. Only works if the key is
     * available in the keychain. One common way of using this data is to derive a hash
     * of the key, which then can be used for other purposes.
     *
     * The format of this data is not documented. There's been some reverse-engineering:
     * https://devforums.apple.com/message/32089#32089
     * Apparently it is a DER-formatted sequence of a modulus followed by an exponent.
     * This can be converted to OpenSSL format by wrapping it in some additional DER goop.
     *
     * - returns: the key's raw data if it could be retrieved from the keychain, or `nil`
     */
    public var keyData: [UInt8]? {
        let query = [ kSecValueRef as String : self, kSecReturnData as String : true ]
        var out: AnyObject?
        guard errSecSuccess == SecItemCopyMatching(query, &out) else {
            return nil
        }
        guard let data = out as? NSData else {
            return nil
        }

        var bytes = [UInt8](count: data.length, repeatedValue: 0)
        data.getBytes(&bytes, length:data.length)
        return bytes
    }
    
}
