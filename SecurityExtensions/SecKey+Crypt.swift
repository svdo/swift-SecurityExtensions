import Foundation

public extension SecKey {

    func encrypt(plainText: String) -> (cypherText:[UInt8], length:Int) {
        let blockSize = SecKeyGetBlockSize(self)
        var cypherText: [UInt8] = Array(count: Int(blockSize), repeatedValue: UInt8(0))
        var cypherLength: Int = blockSize
        let plainTextData: [UInt8] = [UInt8](plainText.utf8)
        let plainTextDataLength: Int = Int(plainText.utf8.count)
        let resultCode = SecKeyEncrypt(self, SecPadding.PKCS1, plainTextData, plainTextDataLength, &cypherText, &cypherLength)
        if errSecSuccess != resultCode {
            return ([], 0)
        }
        return (cypherText, cypherLength)
    }

    func decrypt(cypherText: [UInt8], _ cypherLength: Int) -> String {
        let blockSize = SecKeyGetBlockSize(self)
        var plainTextData: [UInt8] = Array(count: Int(blockSize), repeatedValue: UInt8(0))
        var plainTextDataLength: Int = blockSize
        let resultCode = SecKeyDecrypt(self, SecPadding.PKCS1, cypherText, cypherLength, &plainTextData, &plainTextDataLength)
        if errSecSuccess != resultCode {
            return ""
        }
        let plainText = NSString(bytes: plainTextData, length: Int(plainTextDataLength), encoding: NSUTF8StringEncoding)
        return plainText! as String
    }

}