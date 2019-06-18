//
//  Bitmap.swift
//  Bitmap-
//
//  Created by Jonah Witcig on 6/16/19.
//

import Foundation

public class Bitmap {
    
    enum CodingKeys: String, CodingKey {
        case data
        case size
    }
    
    private var contents: [UInt8]
    public let size: Int
    
    public var data: Data {
        let mutable = NSMutableData(bytes: &contents, length: contents.count)
        return Data(referencing: mutable)
    }
    
    public init(elementCount: Int, data: [UInt8]? = nil) {
        let preciseBytesNeeded = Float(elementCount) / 8
        let actualBytesNeeded = Int(ceil(preciseBytesNeeded))
        
        self.contents = data ?? [UInt8](repeating: 0, count: actualBytesNeeded)
        self.size = elementCount
    }
    
    required init?(coder aDecoder: Decoder) throws {
        let values = try aDecoder.container(keyedBy: CodingKeys.self)
        self.contents = try values.decode([UInt8].self, forKey: .data)
        self.size = try values.decode(Int.self, forKey: .size)
    }
    
    public func set(bit: Int, to value: Bool) {
        guard bit >= 0, bit < size else { fatalError("Out of bounds") }
        
        let (byteOffset, bitOffset, byte) = info(forBit: bit)
        
        contents[byteOffset] = byte | ((value ? 1 : 0) << bitOffset)
    }
    
    public func check(bit: Int) -> Bool {
        guard bit >= 0, bit < size else { fatalError("Out of bounds") }
        
        let (_, bitOffset, byte) = info(forBit: bit)
        
        return (byte & (1 << bitOffset)) > 0
    }
    
    private func info(forBit bit: Int) -> (byteOffset: Int, bitOffset: Int, byte: UInt8) {
        let byteOffset = bit / 8
        return (
            byteOffset: byteOffset,
            bitOffset: bit % 8,
            byte: contents[byteOffset]
        )
    }
}

extension Bitmap: Collection {
    public var startIndex: Int {
        return contents.startIndex
    }
    
    public var endIndex: Int {
        return size
    }
    
    public func index(after i: Int) -> Int {
        return contents.index(after: i)
    }
    
    public subscript(index: Int) -> Bool {
        get {
            return check(bit: index)
        }
    }
}
