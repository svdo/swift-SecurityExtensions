# SecurityExtensions for Swift
[![CocoaPods Version Badge](https://img.shields.io/cocoapods/v/SecurityExtensions.svg)](https://cocoapods.org/pods/SecurityExtensions)
[![License Badge](https://img.shields.io/cocoapods/l/SecurityExtensions.svg)](https://github.com/svdo/swift-SecurityExtensions/blob/master/LICENSE.txt)
![Supported Platforms Badge](https://img.shields.io/cocoapods/p/SecurityExtensions.svg)
[![Percentage Documented Badge](https://img.shields.io/cocoapods/metrics/doc-percent/SecurityExtensions.svg)](http://cocoadocs.org/docsets/SecurityExtensions)

This framework intends to make it easier to use some of Apple's Security framework APIs from Swift. I tested this on iOS. It may also work on OS X, didn't look into that. You're welcome to create pull requests :)

Overview
--------
This framework provides the following primitives. There are unit tests; have a look at them for examples.

### SecCertificate Extensions

#### Create(derEncodedFile:)
Create a certificate by loading its content from a DER-encoded file:

    SecCertificate.create(derEncodedFile file: String) -> SecCertificate?

#### data
Get the certificate data in DER format:

    let cert: SecCertificate = ...
    let data: NSData = cert.data

#### publicKey
Get the certificate's public key:

    let cert: SecCertificate = ...
    let pubKey: SecKey? = cert.publickKey

### SecIdentity Extensions

#### certificate
Get the certificate associated with an identity:

    let identity: SecIdentity =  ...
    let cert: SecCertificate? = identity.certificate

#### privateKey
Get the identity's private key:

    let identity: SecIdentity =  ...
    let privateKey: SecKey? = identity.privateKey

### SecKey Extensions
Please note that encrypting only works if the key is a public key, and decrypting only works if the key is a private key. This is not verified by this framework, your application logic has to make sure it is done correctly.

#### encrypt()
Encrypt data or a string using the key. Make sure that the key is a public key, not a private key! Encryption uses PKCS1 padding.

    let plainText = "This is some plain text."
    let encrypted: [UInt8]? = publicKey.encrypt(plainText)

or:

    let plainBytes: [UInt8] = [1, 2, 3]
    let encrypted: [UInt8]? = publicKey.encrypt(plainBytes)

#### decrypt()
Decrypt to data or a string using the key. Make sure that the key is a private key, not a public key! Decryption uses PKCS1 padding.

    let encryptedBytes: [UInt8] = ...
    let plainText: String? = privateKey.decryptUtf8(encryptedBytes)

or:

    let encryptedBytes: [UInt8] = ...
    let plainBytes: [UInt8]? = privateKey.decrypt(encryptedBytes)

#### keyData
Returns the key's data if it could be retrieved from the keychain. In other words: this only works if the key is present in the keychain! See API documentation for details about data format.

    let key: SecKey = ...
    let keyData: [UInt8]? = key.keyData

#### create(withData:)
Creates a SecKey based on its raw data, as provided by `keyData`. The key is also imported into the keychain. If the key already existed in the keychain, it will simply be returned.

    let keyData: [UInt8] = ...
    let key: SecKey? = SecKey.create(withData: keyData)

#### generateKeyPair()
Generates a private-public key pair.

    let (privateKey, publicKey) = try SecKey.generateKeyPair(3072)

#### blockSize
Returns the block size of the key.

    let key: SecKey = ...
    let blockSize: Int = key.blockSize

#### sign()
Computes the digital signature of the given data using the current key. This assumes the key to be a private key.

    let data: [UInt8] = [1, 2, 3]
    let signature: [UInt8]? = privateKey.sign(data)

#### keychainTag
Returns the tag that was used to store the key in the keychain.

    let key: SecKey = ...
    let tag: String = key.keychainTag

#### loadFromKeychain(tag:)
Loads a key from the keychain based on the tag. The tag is the string returned by `keychainTag`.

    let tag: String = ...
    let key: SecKey? = SecKey.loadFromKeychain(tag: tag)

### SequenceType
This framework also provides an extension to SequenceType that allows creating a hexadecimal string representation of a byte array.

#### hexString()
Creates a string representation of a byte array (`[UInt8]`) by concatenating the hexadecimal representation of all bytes. The string _does not_ include the prefix '0x' that is commonly used to indicate hexadecimal representations. This is the inverse function of `String.hexByteArray()`.

    let bytes: [UInt8] = [0, 1, 2, 255]
    let hexString = bytes.hexString() // "0x000102ff"

### String
The inverse function of `hexString` is implemented in an extension of `String`.

#### hexByteArray()
Converts a string containing the hexadecimal representation of a byte to a byte array. The string must not contain anything else. It may optionally start with the prefix '0x'. Conversion is case insensitive. This is the inverse function of `[UInt8].hexString()`.

    let hexString = "0xdeadbeef"
    let bytes: [UInt8]? = hexString.hexByteArray() // [0xde, 0xad, 0xbe, 0xff]

Usage
-----
The easiest way to use this library is using [CocoaPods](https://cocoapods.org). Just put something like this in your `Podfile`:

    pod 'SecurityExtensions', '~> 1.0'

License
-------
The MIT License (MIT)
Copyright (c) 2016 Stefan van den Oord

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
