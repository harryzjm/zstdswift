import Foundation
import libzstd

extension String: @retroactive Error {}

public extension Data {
    // level between 0...ZSTD_MAX_CLEVEL
    func compressZstd(_ level: Int32 = ZSTD_CLEVEL_DEFAULT) throws -> Data {
        try createZstdCompressedData(bytes: withUnsafeBytes { $0.baseAddress },
                                     length: count,
                                     compressionLevel: level)
    }
    
    func decompressZstd() throws -> Data {
        try createZstdDecompressedData(bytes: withUnsafeBytes { $0.baseAddress },
                                       length: count)
    }
}


private func createZstdCompressedData(bytes: UnsafeRawPointer?, length: Int, compressionLevel: Int32) throws -> Data {
    guard let bytes = bytes, length > 0 else { throw "data is empty" }
    
    let maxOutputSize = ZSTD_compressBound(length)
    
    let outputBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxOutputSize)
    defer { outputBuffer.deallocate() }
    
    let outputSize = ZSTD_compress(outputBuffer, maxOutputSize, bytes, length, compressionLevel)

    guard ZSTD_isError(outputSize) == 0 else {
        throw "output data is empty"
    }

    return Data(bytes: outputBuffer, count: outputSize)
}

private func createZstdDecompressedData(bytes: UnsafeRawPointer?, length: Int) throws -> Data {
    guard let bytes = bytes, length > 0 else { throw "data is empty" }

    let estimateOutputSize = ZSTD_getFrameContentSize(bytes, length)
    if estimateOutputSize == ZSTD_CONTENTSIZE_ERROR {
        throw  "not compressed by zstd"
    }
    if estimateOutputSize == ZSTD_CONTENTSIZE_UNKNOWN {
        throw "original size unknown"
    }

    guard estimateOutputSize > 0 else {
        throw "output data is empty"
    }
    
    let outputBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(estimateOutputSize))
    defer { outputBuffer.deallocate() }
    
    let outputSize = ZSTD_decompress(outputBuffer, Int(estimateOutputSize), bytes, length)

    guard outputSize == estimateOutputSize else {
        throw "Impossible because zstd will check this condition"
    }

    return Data(bytes: outputBuffer, count: Int(outputSize))
}
