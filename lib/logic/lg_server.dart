import "package:flutter/foundation.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:gid_manager/classes/cl_homepage_data.dart";
import "package:gid_manager/main.dart";
import "dart:convert";
import 'package:http/http.dart';
import './lg_storage.dart';

class SResponse<T> {
  const SResponse({
    required this.success,
    required this.showAlert,
    required this.description,
    required this.data,
  });
  final bool success;
  final bool showAlert;
  final String description;
  final T data;
}

class SupabaseC {
  const SupabaseC({
    required this.address,
    required this.anonKey,
  });

  final String address;
  final String anonKey;

  Future<T?> select<T>(String table, Map<String, dynamic> args) async {
    args["apikey"] = anonKey;

    var uri =
        Uri.https(address.replaceAll("https://", ""), "/rest/v1/$table", args);
    var r = await get(uri);

    if (r.statusCode != 200 || r.body.isEmpty) {
      print("Error $r.statusCode");
      return null;
    }

    return json.decode(r.body) as T;
  }
}

class Server {
  final Storage storage = Storage();

  Future<SResponse> login(String email, String password) async {
    var client = supabase.client;

    AuthResponse result =
        await client.auth.signInWithPassword(email: email, password: password);

    return SResponse(
      success: result.session != null && result.user != null,
      showAlert: false,
      description: result.session != null && result.user != null
          ? ""
          : "Что-то пошло не так. Повторите попытку",
      data: null,
    );
  }

  Future<bool> register(String email, String password) async {
    var client = supabase.client;

    AuthResponse result =
        await client.auth.signUp(email: email, password: password);

    return result.user != null && result.session != null;
  }

  Future<SResponse<List<Town>>> getTowns([int count = 3]) async {
    if (kDebugMode) {
      print("Running");
    }

    var townsR = await supabaseC.select<List<dynamic>>("towns", {
      "select": "*",
      "limit": "$count",
    });
    townsR = List<Map<String, dynamic>>.from(townsR!);

    if (kDebugMode) {
      print("Get towns: ${townsR.length}");
    }

    var towns = <Town>[];
    townsR.forEach((town) async {
      String uuid = town["id"];
      String name = town["name"];
      List<String> descriptions = List<String>.from(town["descriptions"]);
      List<String> links = List<String>.from(town["links"]);
      String image = town["image"];
      List<Place> places = [];

      var placesR = await supabase.client
          .from("places")
          .select("*")
          .match({"town": "$uuid"}).limit(3);
      placesR = List<Map<String, dynamic>>.from(placesR!);

      placesR.forEach((place) {
        places.add(
          Place(
            id: place["id"],
            description: Description(
              links: List<String>.from(place["link"]),
              title: place["name"],
              paragraphs: List<String>.from(place["paragraph"]),
            ),
            stars: place["stars"],
            imagePath: place["image"],
          ),
        );
      });

      towns.add(
        Town(
          id: uuid,
          imagePath: image,
          previewPlaces: places,
          description: Description(
            links: links,
            paragraphs: descriptions,
            title: name,
          ),
          favorite: false,
        ),
      );
    });

    return SResponse(
      data: towns,
      success: true,
      showAlert: false,
      description: "",
    );
  }

  Future<SResponse<List<Place>>> getFavoritePlaces() async {
    var f = await storage.getFavoritePlaces();
    var res = <Place>[];
    for (var el in f) {
      var r = await supabase.client.from("places").select('*').match(
        {'id': el},
      );

      if (r.isNotEmpty) {
        res.add(
          Place(
            id: r[0]["id"],
            imagePath: r[0]["image"],
            description: Description(
                title: r[0]["name"],
                paragraphs: r[0]["paragraph"],
                links: r[0]["link"]),
            stars: r[0]["stars"],
          ),
        );
      }
    }

    return SResponse<List<Place>>(
      success: true,
      showAlert: false,
      description: "",
      data: res,
    );
  }

  Future<SResponse<List<Town>>> getFavoriteTowns() async {
    var f = await storage.getFavoriteTowns();
    var res = <Town>[];
    for (var el in f) {
      var r = await supabase.client.from("places").select("*").match(
        {
          "id": el,
        },
      );

      if (r.isNotEmpty) {
        res.add(
          Town(
            id: el,
            imagePath: r[0]["image"],
            description: Description(
              links: r["links"],
              paragraphs: r["descriptions"],
              title: r["name"],
            ),
            favorite: true,
            previewPlaces: [],
          ),
        );
      }
    }

    return SResponse<List<Town>>(
      success: true,
      showAlert: false,
      description: "",
      data: res,
    );
  }
}
