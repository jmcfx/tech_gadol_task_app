/// Indicates where the data was sourced from.
enum DataSource {
  /// Fresh data from the API.
  network,

  /// Cached data served from Hive local storage.
  cache,
}
