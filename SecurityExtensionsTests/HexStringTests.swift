// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Quick
import Nimble
import SecurityExtensions

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
            expect("".hexByteArray()) == [UInt8]()
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

        it("can convert long string that causes crash") {
            let hexBytes = longString.hexByteArray()
            expect(hexBytes?.count) > 0
            let convertedBack = hexBytes?.hexString()
            expect(convertedBack) == longString
        }
    }
}

let longString = "036c51ed3db70c99c0c28c586ae93a850fda250da8eb3e73a578a116b311542fe0a4b64893135fd4ad2f1a449fd414fbd3eca843effe8fdc403ff9537f349661b5cff6dbf16663064d9291cc840e8f14b144617a7733bc6d24b2931bde6f448e0a391cde86c805aa9e17ce60245c0c178a71aebc85740f2f389b610593f9b276d2855d486ed12f6a99d609cc2f7d8e45d3bc77a4fdbbc047a226fd2f007ceab9d6c643eded2abdf58e1557c1737cb6c34ab1668c4735feda2680a9135c0e26b7f11f5ef823cbe828ce4d0f001e7c002f0a9ea0bae301b95bb4103bdf187c89f255fd911f0896084b3632161eafe207fc6492511fcd8790b14f1f323cd2941fe61d423c5e14646d0a05b1ad83d9e32ea654a5984b1f523771ec6152af1e25b2a631c96432a2f6567245cecc5276bb026c60badeb6e5fe8864d6840b046a74362fcb06aa30141cea793573c03fb21fcdfb7bdfa47f977abf2d2c10d9a5d9026c8b7ce52ca21a492f21a71170b6b084d2c6909670a4b5990e010acf92aedddf431f946badd5b5e0d7d53c4670663c5e944f416246ee1c0b8b6649eb325a7efa2ca9e87ece49abbac70729c9bca8f2737840c2c46c58e6c8a9f0c3c9206746bdbeb74faf8b400db386af69ed8b9974b07234194a2319848977a44caaed497a4a47d7fd60662d792bb42a42f6a7ce034b01f7075046da4856d73153b11d6c3915ab8d5562fa492527826085b744f3654ec400fc614abe8e59e441db4549bb4249450db1ffc0484c71952e8c29975186002123d0a6429bd1dc7aa767a85b2bc152a0e40e3492ae7287951f1e1c82713380290978a94f1ec91ce91bcc399e53ccc265b08b5737bba6400048ff1e522aad172262c7cca6f46ee9cc0aa7bd93cac357dc8f61f3fd62aba01c7f870d2c804bb0c636a807e877a49409c081c43502560a25167d0491ae198cee0ac40e9d32728bdde0b0409c1e3cb82e11f4468d004b3aaa1f2ab14db76087b979f07c8c82099dc1a723a92aec516e22415006ade5f39ee05bc8d5416150d9bc708b242f24dc8d8098868771d62386e6686820d5f648d59f358869dafb749c210197e519e17514fac319cee1c6a4d7971668eb68c92f346a357b34cf3f7be40311b9dd0f311b8d4665dab1713211a1d96b299b9a2350b35fa262949e79c6c3c57a1cdf5d71a8f2bc5aa0db9479b8dbf69215836264af0c2cecca2fe504a04e12c2812f5dde27106b4121cf7437986cb06869274a0a7715d437fbd9d751ca8963858d40cb08726d14e12772d9d764814b46e3f60d6d27889e99d908de5e291d37670fcfdcc9aa907d2a55e1cfd120cac024f5948e3dba8edb7dac8aafa4b04a7267164da84a7e7632f535c3585c771fe22b71cd8bd11f482a4570f5525d2e8147918ddbd8f477d11b5a54af6bcc157418e84d2a49fbf8410e8664c3f94377327626c89ca0e668c06d445ee38fa75e73f5c8c4f96ed3018233d3e4eebfff6ae1202044b58f6425814870d449ef416aebb57c70632599229642231775c3cb5385cdae2a4dc8650147aa165ac05e52053afffec7f3ea330e8d65d41e1de6be049af6122f0b39e4b9828f64a1ebb2543a19dfa429bf9ad2b80b0a9b"
