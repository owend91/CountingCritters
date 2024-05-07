//
//  Bundle-Decodable.swift
//  CountingCritters
//
//  Created by David Owen on 5/2/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(
        _ file: String,
        as type: T.Type = T.self,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {

            guard let url = self.url(forResource: file, withExtension: nil) else {
                fatalError("Failed to locate \(file) in bundle.")
            }

            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load \(file) from bundle.")
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStategy

            do {
                return try decoder.decode(T.self, from: data)
            } catch DecodingError.keyNotFound(let key, let context) {
                // swiftlint:disable:next line_length
                fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
            } catch DecodingError.typeMismatch(_, let context) {
                fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                // swiftlint:disable:next line_length
                fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(_) {
                fatalError("Failed to decode \(file) from bundle due to invalid JSON")
            } catch {
                fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
            }
    }
}
