import Foundation

/// An `Error` type that represents possible errors thrown by `DataManager`.
public enum DataManagerError: LocalizedError {
    /// An error that represents that a file already exists at the associated `URL`.
    case fileExists(at: URL)

    /// A localized message describing what error occurred.
    public var errorDescription: String {
        switch self {
        case .fileExists(let url):
            return "A file already exists at URL \(url)."
        }
    }
}
