import Quick
import Nimble
@testable import SecurityExtensions
import IDZSwiftCommonCrypto

class SecKey_SigningTests: QuickSpec {
    
    override func spec() {
        it("can sign") {
            let keys = testKeyPair()
            let bytes:[UInt8] = [1,2,3,4,5,6,7,8]

            let signedBytes = keys.privateKey.sign(data: bytes)
            expect(signedBytes).toNot(beNil())
            if let signature = signedBytes {
                expect(signedBytes?.count) > bytes.count

                let sha1 = Digest(algorithm: .sha1)
                _ = sha1.update(buffer: bytes, byteCount: bytes.count)
                let hash = sha1.final()

                expect(SecKeyRawVerify(keys.publicKey, .PKCS1SHA1, hash, hash.count, signature, signature.count)) == errSecSuccess
            }
        }
    }
}
