import Foundation

public extension SecIdentity {
    
    /**
     * Retrieves the identity's private key. Wraps `SecIdentityCopyPrivateKey()`.
     *
     * - returns: the identity's private key, if possible
     */
    public var privateKey: SecKey? {
        var privKey : SecKey?
        guard SecIdentityCopyPrivateKey(self, &privKey) == errSecSuccess else {
            return nil
        }
        return privKey
    }
    
}