import Foundation
import Security

public extension SecIdentity {

    /**
     * Returns the certificate that belongs to the identity. Wraps `SecIdentityCopyCertificate`.
     * 
     * - returns: the certificate, if possible
     */
    public var certificate: SecCertificate? {
        var uCert: SecCertificateRef?
        let status = SecIdentityCopyCertificate(self, &uCert)
        if (status != errSecSuccess) {
            return nil
        }
        return uCert
    }

}
