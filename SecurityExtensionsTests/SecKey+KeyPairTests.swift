import Foundation
import Quick
import Nimble
@testable import SecurityExtensions

class KeyPairTests : QuickSpec {
    
    override func spec() {
        
        it("can generate key pair") {
            expect { Void->Void in
                let (privKey, pubKey) = try SecKey.generateKeyPair(ofSize: 512)
                expect(privKey.blockSize) == 512/8
                expect(pubKey.blockSize) == 512/8
            }.toNot(throwError())
        }
        
    }
    
}
