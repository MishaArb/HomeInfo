abstract interface class StorageRepository{
  Future<void> saveStorageData(String key, dynamic data);
  Future<dynamic> loadStorageData(String key, {dynamic defaultValue});
}