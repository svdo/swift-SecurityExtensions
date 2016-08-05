import Foundation

extension SecIdentity {

    class func encrypt(plainText: String, _ key: SecKey) -> (cypherText:[UInt8], length:Int) {
        let blockSize = SecKeyGetBlockSize(key)
        var cypherText: [UInt8] = Array(count: Int(blockSize), repeatedValue: UInt8(0))
        var cypherLength: Int = blockSize
        let plainTextData: [UInt8] = [UInt8](plainText.utf8)
        let plainTextDataLength: Int = Int(plainText.utf8.count)
        let resultCode = SecKeyEncrypt(key, SecPadding.PKCS1, plainTextData, plainTextDataLength, &cypherText, &cypherLength)
        if errSecSuccess != resultCode {
            return ([], 0)
        }
        return (cypherText, cypherLength)
    }

    class func decrypt(cypherText: [UInt8], _ cypherLength: Int, _ key: SecKey) -> String {
        let blockSize = SecKeyGetBlockSize(key)
        var plainTextData: [UInt8] = Array(count: Int(blockSize), repeatedValue: UInt8(0))
        var plainTextDataLength: Int = blockSize
        let resultCode = SecKeyDecrypt(key, SecPadding.PKCS1, cypherText, cypherLength, &plainTextData, &plainTextDataLength)
        if errSecSuccess != resultCode {
            return ""
        }
        let plainText = NSString(bytes: plainTextData, length: Int(plainTextDataLength), encoding: NSUTF8StringEncoding)
        return plainText! as String
    }
}