import Quick
import Nimble
@testable import SecurityExtensions

class SecKey_KeyDataTests: QuickSpec {

    override func spec() {

        it("can get public key data") {
            expect { Void->Void in
                let (_, pub) = try SecKey.generateKeyPair(ofSize: 512)
                let keyData = pub.keyData
                expect(keyData).toNot(beNil())
                if let data = keyData {
                    expect(data.count) > 512/8
                }
            }.toNot(throwError())
        }

        it("can create a SecKey from data") {
            expect { Void->Void in
                let (_, pub) = try SecKey.generateKeyPair(ofSize: 512)
                let keyData = pub.keyData
                if let data = keyData {
                    let pub2 = SecKey.create(withData: data)
                    expect(pub2).toNot(beNil())
                    if let p2 = pub2 {
                        expect(p2.keyData) == data
                    }
                }
            }.toNot(throwError())
        }

        it("can create the SecKey even if it already existed in the keychain") {
            expect { Void->Void in
                let (_, pub) = try SecKey.generateKeyPair(ofSize: 512)
                let keyData = pub.keyData
                if let data = keyData {
                    let _ = SecKey.create(withData: data)
                    let pub3 = SecKey.create(withData: data)
                    expect(pub3).toNot(beNil())
                    if let p3 = pub3 {
                        expect(p3.keyData) == data
                    }
                }
            }.toNot(throwError())
        }
    }

}
