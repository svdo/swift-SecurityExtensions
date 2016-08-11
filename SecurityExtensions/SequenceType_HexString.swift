// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

extension SequenceType where Generator.Element == UInt8 {
    /**
     * Creates a string representation of a byte array (`[UInt8]`) by printing
     * the hexadecimal representation of all bytes. The string _does not_ include
     * the prefix '0x' that is commonly used to indicate hexadecimal representations.
     *
     * - returns: the hexadecimal representation of the byte array
     */
    public func toHexString() -> String {
        return self.reduce("", combine: { $0 + String(format: "%02x", $1)})
    }
}
