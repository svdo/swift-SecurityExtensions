import Foundation
import Security

extension SecIdentity {

    public var certificate: SecCertificate? {
        var uCert: SecCertificateRef?
        let status = SecIdentityCopyCertificate(self, &uCert)
        if (status != errSecSuccess) {
            return nil
        }
        return uCert
    }

}
