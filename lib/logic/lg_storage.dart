import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'dart:convert';

class Storage {
  static const storage = FlutterSecureStorage();

  static Future<String> read(String key) async {
    return await storage.read(key: key) ?? "";
  }

  static void write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static void delete(String key) async {
    await storage.delete(key: key);
  }

  static void deleteAll() async {
    await storage.deleteAll();
  }

  void addFavoritePlace(String uuid) async {
    var f = await read("favorite.places");
    if (f != "") {
      var f2 = List<String>.from(jsonDecode(f));
      f2.add(uuid);
      f = jsonEncode(f2);
      write("favorite.places", f);
    } else {
      write("favorite.places", jsonEncode([uuid]));
    }
  }

  void removeFavoritePlace(String uuid) async {
    var f = await read("favorite.places");
    if (f != "") {
      var f2 = List<String>.from(jsonDecode(f));
      f2.remove(uuid);
      f = jsonEncode(f2);
      write("favorite.places", f);
    }
  }

  Future<List<String>> getFavoritePlaces() async {
    var f = await read("favorite.places");
    if (f != "") {
      return List<String>.from(jsonDecode(f));
    } else {
      return [];
    }
  }

  void addFavoriteTowns(String uuid) async {
    var f = await read("favorite.places");
    if (f != "") {
      var f2 = List<String>.from(jsonDecode(f));
      f2.add(uuid);
      f = jsonEncode(f2);
      write("favorite.places", f);
    } else {
      write("favorite.places", jsonEncode([uuid]));
    }
  }

  void removeFavoriteTowns(String uuid) async {
    var f = await read("favorite.places");
    if (f != "") {
      var f2 = List<String>.from(jsonDecode(f));
      f2.remove(uuid);
      f = jsonEncode(f2);
      write("favorite.places", f);
    }
  }

  Future<List<String>> getFavoriteTowns() async {
    var f = await read("favorite.places");
    if (f != "") {
      return List<String>.from(jsonDecode(f));
    } else {
      return [];
    }
  }
}
