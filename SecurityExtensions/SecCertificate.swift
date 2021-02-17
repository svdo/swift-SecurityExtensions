import Security
import Foundation

public extension SecCertificate {

    /**
     * Loads a certificate from a DER encoded file. Wraps `SecCertificateCreateWithData`.
     *
     * - parameter file: The DER encoded file from which to load the certificate
     * - returns: A `SecCertificate` if it could be loaded, or `nil`
     */
    static func create(derEncodedFile file: String) -> SecCertificate? {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: file)) else {
            return nil
        }
        let cfData = CFDataCreateWithBytesNoCopy(nil, (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), data.count, kCFAllocatorNull)
        return SecCertificateCreateWithData(kCFAllocatorDefault, cfData!)
    }

    /**
     * Returns the data of the certificate by calling `SecCertificateCopyData`.
     *
     * - returns: the data of the certificate
     */
    var data: Data {
        return SecCertificateCopyData(self) as Data
    }

    /**
     * Tries to return the public key of this certificate. Wraps `SecTrustCopyPublicKey`.
     * Uses `SecTrustCreateWithCertificates` with `SecPolicyCreateBasicX509()` policy.
     *
     * - returns: the public key if possible
     */
    var publicKey: SecKey? {
        let policy: SecPolicy = SecPolicyCreateBasicX509()
        var uTrust: SecTrust?
        let resultCode = SecTrustCreateWithCertificates([self] as CFArray, policy, &uTrust)
        if (resultCode != errSecSuccess) {
            return nil
        }
        let trust: SecTrust = uTrust!
        return SecTrustCopyPublicKey(trust)
    }

}
