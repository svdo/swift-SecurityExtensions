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
        
    }
    
}
