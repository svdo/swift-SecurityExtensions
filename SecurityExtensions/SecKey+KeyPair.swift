import Foundation
import Security

extension SecKey {

    /**
     * Generates an RSA private-public key pair. Wraps `SecKeyGeneratePair()`.
     *
     * - parameter ofSize: the size of the keys in bits
     * - returns: The generated key pair.
     * - throws: An `NSError` when something went wrong.
     */
    public static func generateKeyPair(ofSize bits:UInt) throws -> (privateKey:SecKey, publicKey:SecKey) {
        let pubKeyAttrs = [ kSecAttrIsPermanent as String: true ]
        let privKeyAttrs = [ kSecAttrIsPermanent as String: true ]
        let params: NSDictionary = [ kSecAttrKeyType as String : kSecAttrKeyTypeRSA as String,
                       kSecAttrKeySizeInBits as String : bits,
                       kSecPublicKeyAttrs as String : pubKeyAttrs,
                       kSecPrivateKeyAttrs as String : privKeyAttrs ]
        var pubKey: SecKey?
        var privKey: SecKey?
        let status = SecKeyGeneratePair(params, &pubKey, &privKey)
        if (status != errSecSuccess) {
            throw SecKeyError.GenerateKeyPairFailed(osStatus: nil)
        }
        guard let pub = pubKey, priv = privKey else {
            throw SecKeyError.GenerateKeyPairFailed(osStatus: nil)
        }
        return (priv, pub)
    }
    
    /**
     * The block size of the key. Wraps `SecKeyGetBlockSize()`.
     */
    public var blockSize: Int {
        return SecKeyGetBlockSize(self)
    }
}

public enum SecKeyError: ErrorType {
    case GenerateKeyPairFailed(osStatus: OSStatus?)
}