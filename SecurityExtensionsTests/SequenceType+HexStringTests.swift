// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Quick
import Nimble

class SequenceType_HexStringTests: QuickSpec {
    override func spec() {
        it("can convert a byte array to a hex string") {
            let bytes: [UInt8] = [0, 1, 2, 255]
            expect(bytes.toHexString()) == "000102ff"
        }

        it("can convert an empty array") {
            let bytes: [UInt8] = []
            expect(bytes.toHexString()) == ""
        }
    }
}
