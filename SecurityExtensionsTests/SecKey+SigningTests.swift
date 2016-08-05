import Quick
import Nimble
@testable import SecurityExtensions
import IDZSwiftCommonCrypto

class SecKey_SigningTests: QuickSpec {
    
    override func spec() {
        it("can sign") {
            expect { Void -> Void in
                let (privKey, pubKey) = try SecKey.generateKeyPair(ofSize: 512)
                let bytes:[UInt8] = [1,2,3,4,5,6,7,8]
                
                let signedBytes = privKey.sign(data: bytes)
                expect(signedBytes.count) > bytes.count
                
                let sha1 = Digest(algorithm: .SHA1)
                sha1.update(bytes)
                let hash = sha1.final()
                
                expect(SecKeyRawVerify(pubKey, .PKCS1SHA1, hash, hash.count, signedBytes, signedBytes.count)) == errSecSuccess
            }.toNot(throwError())
        }
    }
}
