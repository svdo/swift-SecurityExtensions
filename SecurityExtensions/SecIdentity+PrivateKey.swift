import Foundation

extension SecIdentity {
    
    /**
     * Helper to retrieve the identity's private key. Wraps `SecIdentityCopyPrivateKey()`.
     */
    public var privateKey: SecKey? {
        var privKey : SecKey?
        guard SecIdentityCopyPrivateKey(self, &privKey) == errSecSuccess else {
            return nil
        }
        return privKey
    }
    
}