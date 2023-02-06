# codable-data-manager

A lightweight file/data manager that handles reading and writing Swift `Codable` objects from/to disk.

## Installation

Add the following as a package in your `Package.swift` file or Xcode project:

```
git@github.com:rlziii/codable-data-manager.git
```

Then simply `import CodableDataManager`.

## Usage

In the most simple case a new `DataManager()` object can be created that uses `FileManager.default` and an app's document directory.
For more specialized use cases (e.g. to use a different directory or for testing setups), a `DataManager` can be created with a custom `DataFileManager`.
To do so, create a new `DataFileManager` and override the necessary closures.
Alternatively, an extension on `DataFileManager` can be created with a new static property definition (e.g. `DataFileManager+Default.swift`) to improve the ergonomics (allowing for an initialization such as `DataManager(.test)`).

## License

MIT License. See `LICENSE` file for more details.