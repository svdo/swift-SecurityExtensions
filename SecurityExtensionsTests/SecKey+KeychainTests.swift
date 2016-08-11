// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Quick
import Nimble

class SecKey_KeychainTests: QuickSpec {
    override func spec() {
        it("can return the keychain tag of a key") {
            expect { Void->Void in
                let (privKey, pubKey) = try SecKey.generateKeyPair(ofSize: 512)
                expect(privKey.keychainTag) != ""
                expect(pubKey.keychainTag) != ""
            }.toNot(throwError())
        }

        it("can retrieve a key by tag") {
            expect { Void->Void in
                let (privKey, pubKey) = try SecKey.generateKeyPair(ofSize: 512)
                let privTag = privKey.keychainTag
                let pubTag = pubKey.keychainTag
                expect(privTag).toNot(beNil())
                expect(pubTag).toNot(beNil())
                if let privTag = privTag, pubTag = pubTag {
                    let retrievedPrivKey = SecKey.loadFromKeychain(tag: privTag)
                    let retrievedPubKey = SecKey.loadFromKeychain(tag: pubTag)
                    expect(retrievedPrivKey?.keyData) == privKey.keyData
                    expect(retrievedPubKey?.keyData) == pubKey.keyData
                }
            }.toNot(throwError())
        }
    }
}
