import "package:flutter/foundation.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:gid_manager/classes/cl_homepage_data.dart";
import "package:gid_manager/main.dart";

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

class Server {
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
    var client = supabase.client;

    if (kDebugMode) {
      print("Running");
    }

    var r = await client.from("towns").select("*").limit(count);

    if (kDebugMode) {
      print("Get towns: ${r.length}");
    }

    var towns = <Town>[];
    r.forEach((town) async {
      String uuid = town["id"];
      String name = town["name"];
      List<String> descriptions = List<String>.from(town["descriptions"]);
      List<String> links = List<String>.from(town["links"]);
      String image = town["image"];
      List<Place> places = [];

      var r2 = await client
          .from("places")
          .select("*")
          .match({"town": uuid}).limit(3);

      r2.forEach((place) {
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
}
