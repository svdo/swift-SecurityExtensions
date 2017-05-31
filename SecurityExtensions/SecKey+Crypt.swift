import Foundation

public extension SecKey {

    /**
     * Encrypt the given bytes. Requires that this key is a public key. Encryption uses PKCS1 padding.
     *
     * - parameter bytes: the content that needs to be encrypted
     * - returns: the encrypted bytes, or `nil` if the encryption failed.
     */
    func encrypt(_ bytes: [UInt8]) -> [UInt8]? {
        let blockSize = SecKeyGetBlockSize(self)

        // From SecKeyEncrypt:
        // When PKCS1 padding is performed, the maximum length of data that can be
        // encrypted is 11 bytes less than the value returned by the SecKeyGetBlockSize
        // function (secKeyGetBlockSize() - 11)
        let maxDataLength = blockSize - 11

        var encryptedBytes = [UInt8]()

        let numBlocks = Int(ceil(Float(bytes.count) / Float(maxDataLength)))
        for i in 0 ..< numBlocks {
            let start = i * maxDataLength
            let end = min((i+1) * maxDataLength, bytes.count)
            let block = Array(bytes[start ..< end])

            var cypherText: [UInt8] = Array(repeating: UInt8(0), count: Int(blockSize))
            var cypherLength: Int = blockSize

            let resultCode = SecKeyEncrypt(self, SecPadding.PKCS1, block, block.count, &cypherText, &cypherLength)
            guard resultCode == errSecSuccess else {
                return nil
            }
            encryptedBytes += cypherText[0 ..< cypherLength]
        }
        return encryptedBytes
    }

    /**
     * Encrypt the given string by encrypting its UTF-8 encoded bytes. Requires that this key is a public key.
     * Encryption uses PKCS1 padding.
     *
     * - parameter utf8Text: the string that needs to be encrypted
     * - returns: the encrypted bytes, or `nil` if the encryption failed.
     */
    func encrypt(_ utf8Text: String) -> [UInt8]? {
        let plainTextData: [UInt8] = [UInt8](utf8Text.utf8)
        return encrypt(plainTextData)
    }

    /**
     * Decrypts the given bytes. Requires that this key is a private key. Decrypts using PKCS1 padding.
     *
     * - parameter cypherText: the data that needs to be decrypted
     * - returns: the decrypted content, or `nil` if decryption failed
     */
    func decrypt(_ cypherText: [UInt8]) -> [UInt8]? {
        let blockSize = SecKeyGetBlockSize(self)

        var decryptedBytes = [UInt8]()

        let numBlocks = Int(ceil(Float(cypherText.count) / Float(blockSize)))
        for i in 0 ..< numBlocks {
            let start = i * blockSize
            let end = min((i+1)*blockSize, cypherText.count)
            let block = Array(cypherText[start ..< end])

            var plainTextData: [UInt8] = Array(repeating: UInt8(0), count: Int(blockSize))
            var plainTextDataLength: Int = blockSize
            let resultCode = SecKeyDecrypt(self, SecPadding.PKCS1, block, block.count, &plainTextData, &plainTextDataLength)
            guard resultCode == errSecSuccess else {
                return nil
            }
            decryptedBytes += Array(plainTextData[0 ..< plainTextDataLength])
        }

        return decryptedBytes
    }

    /**
     * Decrypts the given bytes to a string by interpreting the decrypted result as an UTF-8 encoded string.
     * Requires that this key is a private key. Decrypts using PKCS1 padding.
     *
     * - parameter cypherText: the data that needs to be decrypted
     * - returns: the decrypted UTF-8 string, or `nil` if decryption failed
     */
    func decryptUtf8(_ cypherText: [UInt8]) -> String? {
        guard let plainTextData = decrypt(cypherText) else {
            return nil
        }
        let plainText = NSString(bytes: plainTextData, length: plainTextData.count, encoding: String.Encoding.utf8.rawValue)
        return plainText as String?
    }

}
