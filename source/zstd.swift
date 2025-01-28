import Foundation
import libzstd

extension String: @retroactive Error {}

public extension Data {
    // level between 0...ZSTD_MAX_CLEVEL
    func compressZstd(_ level: Int32 = ZSTD_CLEVEL_DEFAULT) throws -> Data {
        try Zstd.compressedData(bytes: withUnsafeBytes { $0.baseAddress },
                                     length: count,
                                     compressionLevel: level)
    }
    
    func decompressZstd() throws -> Data {
        try Zstd.decompressedData(bytes: withUnsafeBytes { $0.baseAddress },
                                       length: count)
    }
}

struct Zstd {
    static func compressed(path: String, toPath: String, level: Int32 = ZSTD_CLEVEL_DEFAULT) throws {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) else {
            throw "file not exist"
        }
        
        if isDirectory.boolValue {
            
        }
    }
    
    static func decompressed(path: String, toPath: String, level: Int32 = ZSTD_CLEVEL_DEFAULT) throws {
        
    }
}

private extension Zstd {
    static func compressedDirectory(path: String, toPath: String, level: Int32 = ZSTD_CLEVEL_DEFAULT) throws {
        
    }
    
    static func compressedFile(path: String, toPath: String, level: Int32 = ZSTD_CLEVEL_DEFAULT) throws {
    }
    
    static func compressedData(bytes: UnsafeRawPointer?, length: Int, compressionLevel: Int32) throws -> Data {
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
    
    static func decompressedData(bytes: UnsafeRawPointer?, length: Int) throws -> Data {
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
}
