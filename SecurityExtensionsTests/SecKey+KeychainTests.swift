// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Quick
import Nimble
import SecurityExtensions

class SecKey_KeychainTests: QuickSpec {
    override func spec() {
        it("can return the keychain tag of a key") {
            let keys = testKeyPair()
            expect(keys.privateKey.keychainTag) != ""
            expect(keys.publicKey.keychainTag) != ""
        }

        it("can retrieve a key by tag") {
            let keys = testKeyPair()
            let privTag = keys.privateKey.keychainTag
            let pubTag = keys.publicKey.keychainTag
            expect(privTag).toNot(beNil())
            expect(pubTag).toNot(beNil())
            if let privTag = privTag, let pubTag = pubTag {
                let retrievedPrivKey = SecKey.loadFromKeychain(tag: privTag)
                let retrievedPubKey = SecKey.loadFromKeychain(tag: pubTag)
                expect(retrievedPrivKey?.keyData) == keys.privateKey.keyData
                expect(retrievedPubKey?.keyData) == keys.publicKey.keyData
            }
        }
    }
}
