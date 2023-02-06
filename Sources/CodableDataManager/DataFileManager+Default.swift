import Foundation

public extension DataFileManager {
    /// A default `DataFileManager` that uses `FileManager.default` and the `documentDirectory`.
    static let `default` = Self.init(
        fileExists: {
            FileManager.default.fileExists(atPath: $0.path)
        },
        createFile: {
            FileManager.default.createFile(atPath: $0.path, contents: $1)
        },
        readFile: {
            FileManager.default.contents(atPath: $0.path)
        },
        urlForFilename: {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent($0)
        }
    )
}
