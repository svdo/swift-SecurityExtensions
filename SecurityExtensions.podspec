Pod::Spec.new do |s|
  s.name          = "SecurityExtensions"
  s.version       = "4.0.0"
  s.summary       = "This framework intends to make it easier to use some of Apple's Security framework APIs from Swift."
  s.description   = <<-DESC
                   This framework provides extensions for SecIdentity, SecCertificate and SecKey. It allows you to easily use their functionality in a Swift manner. Things you can do include: generate key pairs, encrypt and decrypt, sign data, get public keys and private keys from identities and certificates.
                   DESC

  s.homepage      = "https://github.com/svdo/swift-SecurityExtensions"
  s.license       = { :type => "MIT", :file => "LICENSE.txt" }
  s.author        = { "Stefan van den Oord" => "soord@mac.com" }
  s.platform      = :ios, "13.0"
  s.source        = { :git => "https://github.com/svdo/swift-SecurityExtensions.git", :tag => "#{s.version}" }
  s.source_files  = "SecurityExtensions/*.swift"
  s.framework     = "Security"
  s.requires_arc  = true
  s.swift_version = '5'
end
