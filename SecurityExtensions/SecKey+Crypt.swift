import Foundation

public extension SecKey {

    /**
     * Encrypt the given bytes. Requires that this key is a public key. Encryption uses PKCS1 padding.
     *
     * - parameter bytes: the content that needs to be encrypted
     * - returns: the encrypted bytes, or `nil` if the encryption failed.
     */
    func encrypt(bytes: [UInt8]) -> [UInt8]? {
        let blockSize = SecKeyGetBlockSize(self)
        var cypherText: [UInt8] = Array(count: Int(blockSize), repeatedValue: UInt8(0))
        var cypherLength: Int = blockSize

        let resultCode = SecKeyEncrypt(self, SecPadding.PKCS1, bytes, bytes.count, &cypherText, &cypherLength)
        if errSecSuccess != resultCode {
            return nil
        }
        return Array(cypherText[0 ..< cypherLength])
    }

    /**
     * Encrypt the given string by encrypting its UTF-8 encoded bytes. Requires that this key is a public key.
     * Encryption uses PKCS1 padding.
     *
     * - parameter utf8Text: the string that needs to be encrypted
     * - returns: the encrypted bytes, or `nil` if the encryption failed.
     */
    func encrypt(utf8Text: String) -> [UInt8]? {
        let plainTextData: [UInt8] = [UInt8](utf8Text.utf8)
        return encrypt(plainTextData)
    }

    /**
     * Decrypts the given bytes. Requires that this key is a private key. Decrypts using PKCS1 padding.
     *
     * - parameter cypherText: the data that needs to be decrypted
     * - returns: the decrypted content, or `nil` if decryption failed
     */
    func decrypt(cypherText: [UInt8]) -> [UInt8]? {
        let blockSize = SecKeyGetBlockSize(self)
        var plainTextData: [UInt8] = Array(count: Int(blockSize), repeatedValue: UInt8(0))
        var plainTextDataLength: Int = blockSize
        let resultCode = SecKeyDecrypt(self, SecPadding.PKCS1, cypherText, cypherText.count, &plainTextData, &plainTextDataLength)
        if errSecSuccess != resultCode {
            return nil
        }
        return Array(plainTextData[0 ..< plainTextDataLength])
    }

    /**
     * Decrypts the given bytes to a string by interpreting the decrypted result as an UTF-8 encoded string.
     * Requires that this key is a private key. Decrypts using PKCS1 padding.
     *
     * - parameter cypherText: the data that needs to be decrypted
     * - returns: the decrypted UTF-8 string, or `nil` if decryption failed
     */
    func decryptUtf8(cypherText: [UInt8]) -> String? {
        guard let plainTextData = decrypt(cypherText) else {
            return nil
        }
        let plainText = NSString(bytes: plainTextData, length: plainTextData.count, encoding: NSUTF8StringEncoding)
        return plainText as? String
    }

}