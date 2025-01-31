//
//  LogService.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

protocol LogProvider {
    func load<ModelType: Codable>(_ operation: LogOperation) async -> Result<ModelType, Error>
}

struct LogService: LogProvider {
    func load<ModelType>(_ operation: LogOperation) async -> Result<ModelType, any Error> where ModelType : Decodable, ModelType : Encodable {
        var response: Result<ModelType, Error>
        switch operation {
        case .read:
            response = read(operation)
        case .write:
            response = write(operation)
        }

        switch response {
        case .success(let responseObject):
            return .success(responseObject)
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Reads the contents of URL
    /// - Parameter url: URL pointing to the location of the file or resource
    /// - Returns: A result with a generic model type on success, or an error
    private func read<ModelType: Codable>(_ endpoint: LogOperation) -> Result<ModelType, Error> {
        let decoder = JSONDecoder()

        do {
            let data = try Data(contentsOf: endpoint.url)

            let objects = try decoder.decode(ModelType.self, from: data)
            print("Successfully read from file at: \(endpoint.url)")
            return .success(objects)
        } catch {
            return .failure(error)
        }
    }

    /// Accepts a Data and converts it to a Result using ModelType and customError
    /// - Parameters:
    ///   - data: Data to be convert
    ///   - customError: custom error to use on failure
    /// - Returns: A result type with a generic model type on success, or an error
    private func encodeDataToResult<ModelType: Codable>(_ data: Data, customError: Error? = nil) -> Result<ModelType, Error> {
        let decoder = JSONDecoder()

        do {
            let responseObject = try decoder.decode(ModelType.self, from: data)
            return .success(responseObject)
        } catch {
            print("Failed to decode JSON data: \(error.localizedDescription)")
            return .failure(customError ?? LogError.decodingError)
        }
    }

    /// Writes an entry into the file using a LogOperation
    /// - Parameter endpoint: Should contain an Event body
    /// - Returns: A result type with an encoded  Event on success, or an error
    private func write<ModelType: Codable>(_ operation: LogOperation) -> Result<ModelType, Error> {
        /// Check if we have an object to write
        guard let eventToWrite = operation.body as? Event else {
            return .failure(LogError.missingEventObject)
        }

        /// Fetch all events
        let eventsResult: Result<[Event], Error> = read(operation)
        var events: [Event] = []
        if case .success(let objects) = eventsResult {
            events = objects
        }

        /// Append new event to array of current events
        events.append(eventToWrite)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            /// Write array of events to file
            let data = try encoder.encode(events)
            try data.write(to: operation.url)

            /// Encode new event as Data, and decode Data to generic ModelType
            let eventData = try encoder.encode(eventToWrite)
            return encodeDataToResult(eventData)
        } catch {
            return .failure(LogError.encodingError)
        }
    }
}
