// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Quick
import Nimble

class HexStringTests: QuickSpec {
    override func spec() {
        it("can convert a byte array to a hex string") {
            let bytes: [UInt8] = [0, 1, 2, 255]
            expect(bytes.hexString()) == "000102ff"
        }

        it("can convert an empty array") {
            let bytes: [UInt8] = []
            expect(bytes.hexString()) == ""
        }

        it("can convert an empty string to a byte array") {
            expect("".hexByteArray()) == []
        }

        it("cannot convert an odd-sized string") {
            expect("1".hexByteArray()).to(beNil())
            expect("123".hexByteArray()).to(beNil())
            expect("12345".hexByteArray()).to(beNil())
        }

        it("can convert string with single byte") {
            expect("01".hexByteArray()) == [1]
        }

        it("can convert string with multiple bytes") {
            let hexString = "deadbeef"
            let expected: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
            expect(hexString.hexByteArray()) == expected
        }

        it("cannot convert string with invalid chars") {
            expect("xy".hexByteArray()).to(beNil())
        }

        it("can convert string that starts with 0x") {
            let hexString = "0xdeadbeef"
            let expected: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
            expect(hexString.hexByteArray()) == expected
        }

        it("cannot convert string that has 0x somewhere else") {
            expect("120x34".hexByteArray()).to(beNil())
        }

        it("is not case sensitive") {
            let hexString = "DEADBEEF"
            let expected: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
            expect(hexString.hexByteArray()) == expected
        }
    }
}
