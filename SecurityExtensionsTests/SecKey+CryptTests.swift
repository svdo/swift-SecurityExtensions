import Quick
import Nimble

class SecKey_CryptTests: QuickSpec {
    override func spec() {
        it("can decrypt encrypted utf8 strings") {
            expect { Void->Void in
                let (privKey, pubKey) = try SecKey.generateKeyPair(ofSize: 512)
                let text = "This is some text"
                let encrypted = pubKey.encrypt(text)
                let decrypted = privKey.decryptUtf8(encrypted!)
                expect(decrypted) == text
            }.toNot(throwError())
        }

        it("can decrypt encrypted data") {
            expect { Void->Void in
                let (privKey, pubKey) = try SecKey.generateKeyPair(ofSize: 512)
                let data: [UInt8] = [1, 42, 255, 128, 33, 183]
                let encrypted = pubKey.encrypt(data)
                let decrypted = privKey.decrypt(encrypted!)
                expect(decrypted) == data
            }.toNot(throwError())
        }

        it("cannot decrypt rubbish") {
            expect { Void->Void in
                let (privKey, _) = try SecKey.generateKeyPair(ofSize: 512)
                expect(privKey.decrypt([1,2,3])).to(beNil())
            }.toNot(throwError())
        }

        it("cannot encrypt with private key") {
            expect { Void->Void in
                let (privKey, _) = try SecKey.generateKeyPair(ofSize: 512)
                expect(privKey.encrypt([1,2,3])).to(beNil())
            }.toNot(throwError())
        }
    }
}