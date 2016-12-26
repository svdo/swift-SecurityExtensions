import Foundation
import Quick
import Nimble
@testable import SecurityExtensions

class KeyPairTests : QuickSpec {
    
    override func spec() {
        
        it("can generate key pair") {
            let keys = testKeyPair()
            expect(keys.privateKey.blockSize) == 512/8
            expect(keys.publicKey.blockSize) == 512/8
        }
    }
}
