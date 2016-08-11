// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Quick
import Nimble

class HexStringTests: QuickSpec {
    override func spec() {
        it("can convert a byte array to a hex string") {
            let bytes: [UInt8] = [0, 1, 2, 255]
            expect(bytes.toHexString()) == "000102ff"
        }

        it("can convert an empty array") {
            let bytes: [UInt8] = []
            expect(bytes.toHexString()) == ""
        }

        it("can convert an empty string to a byte array") {
            expect("".toByteArray()) == []
        }

        it("cannot convert an odd-sized string") {
            expect("1".toByteArray()).to(beNil())
            expect("123".toByteArray()).to(beNil())
            expect("12345".toByteArray()).to(beNil())
        }

        it("can convert string with single byte") {
            expect("01".toByteArray()) == [1]
        }

        it("can convert string with multiple bytes") {
            let hexString = "deadbeef"
            let expected: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
            expect(hexString.toByteArray()) == expected
        }

        it("cannot convert string with invalid chars") {
            expect("xy".toByteArray()).to(beNil())
        }

        it("can convert string that starts with 0x") {
            let hexString = "0xdeadbeef"
            let expected: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
            expect(hexString.toByteArray()) == expected
        }

        it("cannot convert string that has 0x somewhere else") {
            expect("120x34".toByteArray()).to(beNil())
        }

        it("is not case sensitive") {
            let hexString = "DEADBEEF"
            let expected: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
            expect(hexString.toByteArray()) == expected
        }
    }
}
