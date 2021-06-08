// Copyright (c) 2016 Stefan van den Oord. All rights reserved.
import Foundation

extension Sequence where Iterator.Element == UInt8 {
    /**
     * Creates a string representation of a byte array (`[UInt8]`) by concatenating
     * the hexadecimal representation of all bytes. The string _does not_ include
     * the prefix '0x' that is commonly used to indicate hexadecimal representations.
     *
     * - returns: the hexadecimal representation of the byte array
     */
    public func hexString() -> String {
        return self.reduce("", { $0 + String(format: "%02x", $1)})
    }
}

extension String {
    /**
     * Converts a string containing the hexadecimal representation of a byte
     * to a byte array. The string must not contain anything else. It may
     * optionally start with the prefix '0x'. Conversion is case insensitive.
     *
     * - returns: the parsed byte array, or nil if parsing failed
     */
    public func hexByteArray() -> [UInt8]? {
        guard self.count % 2 == 0 else {
            return nil
        }
        let stringToConvert: String
        let prefixRange = self.range(of: "0x")
        if let r = prefixRange, r.lowerBound == self.startIndex && r.upperBound != r.lowerBound {
            stringToConvert = String(self[r.upperBound...])
        }
        else {
            stringToConvert = self
        }
        return stringToByteArray(stringToConvert)
    }
}

private func stringToByteArray(_ string: String) -> [UInt8]? {
    var result = [UInt8]()
    for byteIndex in 0 ..< string.count/2 {
        let start = string.index(string.startIndex, offsetBy: byteIndex*2)
        let end = string.index(start, offsetBy: 2)
        let byteString = string[start ..< end]
        guard let byte = scanHexByte(String(byteString)) else {
            return nil
        }
        result.append(byte)
    }
    return result
}

private func scanHexByte(_ byteString: String) -> UInt8? {
    var scanned: UInt64 = 0
    let scanner = Scanner(string: byteString)
    guard scanner.scanHexInt64(&scanned) && scanner.isAtEnd else {
        return nil
    }
    return UInt8(scanned)
}
