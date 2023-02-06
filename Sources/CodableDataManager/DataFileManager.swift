import Foundation

/// A lightweight struct that holds simple values for `FileManager`-like operations.
/// Construct a `DataFileManager` or use the `.default` implementation.
/// This "protocol witness" setup can be useful for testing or easily swapping out to different implementations.
public struct DataFileManager {
    /// Reports `true` if a file already exists at the specified `URL`; `false` otherwise.
    public var fileExists: (URL) -> Bool

    /// Creates a file at the specified `URL` and returns `true` if the file was created successfully; `false` otherwise.
    public var createFile: (URL, Data) -> Bool

    /// Reads the file (if it exists) at the specified `URL` and returns the `Data` if there is any.
    public var readFile: (URL) -> Data?

    /// Creates a new `URL` for the given filename.
    public var urlForFilename: (String) -> URL

    public init(
        fileExists: @escaping (URL) -> Bool,
        createFile: @escaping (URL, Data) -> Bool,
        readFile: @escaping (URL) -> Data?,
        urlForFilename: @escaping (String) -> URL
    ) {
        self.fileExists = fileExists
        self.createFile = createFile
        self.readFile = readFile
        self.urlForFilename = urlForFilename
    }
}
