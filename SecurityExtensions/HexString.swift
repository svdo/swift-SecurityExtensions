// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

extension SequenceType where Generator.Element == UInt8 {
    /**
     * Creates a string representation of a byte array (`[UInt8]`) by concatenating
     * the hexadecimal representation of all bytes. The string _does not_ include
     * the prefix '0x' that is commonly used to indicate hexadecimal representations.
     *
     * - returns: the hexadecimal representation of the byte array
     */
    public func hexString() -> String {
        return self.reduce("", combine: { $0 + String(format: "%02x", $1)})
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
        guard self.characters.count % 2 == 0 else {
            return nil
        }
        let stringToConvert: String
        let prefixRange = self.rangeOfString("0x")
        if let r = prefixRange
            where r.startIndex == self.startIndex && r.endIndex != r.startIndex {
            stringToConvert = self.substringFromIndex(r.endIndex)
        }
        else {
            stringToConvert = self
        }
        return stringToByteArray(stringToConvert)
    }
}

private func stringToByteArray(string: String) -> [UInt8]? {
    guard string.characters.count > 0 else {
        return []
    }
    let split = string.startIndex.advancedBy(2)
    let head = string.substringToIndex(split)
    let tail = string.substringFromIndex(split)
    guard let headByte = scanHexByte(head) else {
        return nil
    }
    guard let tailBytes = stringToByteArray(tail) else {
        return nil
    }
    return [headByte] + tailBytes
}

private func scanHexByte(byteString: String) -> UInt8? {
    var scanned: UInt32 = 0
    let scanner = NSScanner(string: byteString)
    guard scanner.scanHexInt(&scanned) && scanner.atEnd else {
        return nil
    }
    return UInt8(scanned)
}
