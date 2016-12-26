import Quick
import Nimble
import SecurityExtensions

class SecCertificateTests: QuickSpec {
    override func spec() {
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "Staat der Nederlanden EV Root CA", ofType: "der")!

        it("can load from file") {
            let cert = SecCertificate.create(derEncodedFile: filePath)
            expect(cert).toNot(beNil())
        }

        it("cannot load from nonexisting file") {
            let cert = SecCertificate.create(derEncodedFile: "non-existing")
            expect(cert).to(beNil())
        }

        it("can return the cert data") {
            let cert = SecCertificate.create(derEncodedFile: filePath)!
            let certData = cert.data
            let fileData = NSData(contentsOfFile: filePath)!
            expect(certData) == fileData as Data
        }

        it("can return the public key") {
            let cert = SecCertificate.create(derEncodedFile: filePath)!
            expect(cert.publicKey).toNot(beNil())
        }
    }
}

