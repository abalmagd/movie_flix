extension MapExtension on Map<String, dynamic> {
  void changeKeyName(String oldKey, String key) {
    this[key] = this[oldKey];
    remove(oldKey);
  }
}
