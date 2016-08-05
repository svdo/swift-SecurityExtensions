import Security

extension SecCertificate {

    public var data: NSData {
        return SecCertificateCopyData(self) as NSData
    }
    
    public var publicKey: SecKey? {
        let policy: SecPolicy = SecPolicyCreateBasicX509()
        var uTrust: SecTrust?
        let resultCode = SecTrustCreateWithCertificates([self], policy, &uTrust)
        if (resultCode != errSecSuccess) {
            return nil
        }
        let trust: SecTrust = uTrust!
        return SecTrustCopyPublicKey(trust)
    }

}