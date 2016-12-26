//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import SecurityExtensions

func testKeyPair() -> KeyPair {
    var keyPair: KeyPair? = nil
    do {
        keyPair = try SecKey.generateKeyPair(ofSize: 512)
    } catch let e {
        // Logic testing (without test host app) doesn't work on iOS 10 simulator. More info:
        //
        // https://forums.developer.apple.com/thread/62847
        //
        // Bottom line: for the keychain to work on iOS simulator, code signing is required,
        // but code signing my framework target and unit tests doesn't seem to do the job.
        print("Generation of key pair raised exception: \(e). Note: logic testing on iOS simulator does NOT"
            + " work on iOS 10 simulator, please use iOS 9.3 simulator.")
    }
    return keyPair!
}
