import Foundation

/// A data-to-file (and back) manager that uses `Codable` objects.
public class DataManager {
    // MARK: - Private Properties

    private let manager: DataFileManager
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Initialization

    /// Creates a new `DataManager` using a `DataFileManager`.
    /// - Parameter manager: A `DataFileManager` to handle the file operations; can use `.default` to represent `FileManager.default`.
    public init(_ manager: DataFileManager = .default) {
        self.manager = manager
    }

    // MARK: - Public Methods

    /// File a `Encodable` object to disk at the given filename.
    /// - Parameters:
    ///   - encodable: The object to write.
    ///   - filename: The filename (used in conjunction with the `DataFileManager`'s `urlForFilename`) used to construct the URL location on disk.
    ///   - shouldOverwrite: `true` if the operation should overwrite an existing file if it exists; `false` if the file should not be overwritten and instead a `DataManagerError.fileExists` should be thrown instead if a file exists.
    public func write<T: Encodable>(_ encodable: T, filename: String, shouldOverwrite: Bool = true) throws {
        let data = try encoder.encode(encodable)
        let url = try url(for: filename)

        if !shouldOverwrite && manager.fileExists(url) {
            throw DataManagerError.fileExists(at: url)
        }

        _ = manager.createFile(url, data)
    }

    /// Read a `Decodable` object from the specified filename location.
    /// - Parameters:
    ///   - type: The `Decodable` type expected.
    ///   - filename: The filename (used in conjunction with the `DataFileManager`'s `urlForFilename`) used to construct the URL location on disk.
    /// - Returns: The decoded object from the file location if it exists; otherwise `nil` if the file is not found.
    public func read<T: Decodable>(_ type: T.Type, filename: String) throws -> T? {
        let url = try url(for: filename)
        guard let data = manager.readFile(url) else {
            return nil
        }
        return try decoder.decode(type, from: data)
    }

    // MARK: - Private Properties

    /// Create a URL for the given filename.
    /// - Parameter filename: The filename to append to the base URL constructed by the `DataFileManager`.
    /// - Returns: The constructed URL.
    private func url(for filename: String) throws -> URL {
        manager.urlForFilename(filename)
    }
}
