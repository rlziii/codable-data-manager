# codable-data-manager

A lightweight file/data manager that handles reading and writing Swift `Codable` objects from/to disk.

## Installation

Add the following as a package in your `Package.swift` file or Xcode project:

```
git@github.com:rlziii/codable-data-manager.git
```

Then simply `import CodableDataManager` where needed.

## Usage

In the most simple case a new `DataManager()` object can be created that uses `FileManager.default` and an app's document directory.
For more specialized use cases (e.g. to use a different directory or for testing setups), a `DataManager` can be created with a custom `DataFileManager`.
To do so, create a new `DataFileManager` and override the necessary closures.
Alternatively, an extension on `DataFileManager` can be created with a new static property definition (e.g. `DataFileManager+Default.swift`) to improve the ergonomics (allowing for an initialization such as `DataManager(.test)`).

Once a `DataManager` has been created, there are two primary methods to use:

```swift
public func write<T: Encodable>(_ encodable: T, filename: String, shouldOverwrite: Bool = true) throws
```

Use this method to write new `Encodable` data to a specified filename location.
Filenames should be unique in some way as (by default) they will be overwritten.
If `shouldOverwrite` is set to `false` and a file already exists with the specified filename then a `DataManagerError.fileExists` error will be thrown.

```swift
public func read<T: Decodable>(_ type: T.Type, filename: String) throws -> T?
```

Use this method to read a previously-written file (via a known `filename`) back as a `Decodable` object (the `type`).
The method returns an `Optional` in the case that the data is not found at the `filename` location (i.e. it does not exist).
This method may also throw in the case where the data cannot be properly decoded (this is likely to be a `DecodingError` thrown from `JSONDecoder`).

A simple example use case may look like this:

```swift
struct GameInfo: Codable {
  let username: String
  let highScore: Int
}

...

class GameInfoManager {
  private let dataManager = DataManager()

  private var username = ""
  private var highScore = 0

  // ...

  func saveGameInfo() {
    let gameInfo = GameInfo(username: username, highScore: highScore)
    try? dataManager.write(gameInfo, filename: "game_info.json")
  }

  func loadGameInfo() -> GameInfo? {
    try? dataManager.read(GameInfo.self, filename: "game_info.json")
  }
}
```

## License

MIT License. See `LICENSE` file for more details.