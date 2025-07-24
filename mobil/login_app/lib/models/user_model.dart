/// Represents the authenticated user data received from the API.
///
/// This class encapsulates the essential information of a user after a
/// successful login, including their unique ID, authentication token,
// and display names.
class User {
  /// The unique identifier for the user.
  final int id;

  /// The JSON Web Token (JWT) issued by the server upon successful authentication.
  /// This token must be sent with subsequent requests to access protected resources.
  final String token;

  /// The unique username of the user.
  final String username;

  /// The display name or alias of the user (e.g., first name).
  final String knownAs;

  /// Creates an instance of a [User].
  ///
  /// All parameters are required to ensure data integrity.
  User({
    required this.id,
    required this.token,
    required this.username,
    required this.knownAs,
  });

  /// A factory constructor that creates a [User] instance from a JSON map.
  ///
  /// This method safely parses a `Map<String, dynamic>` (typically decoded from a
  /// JSON response) and converts it into a [User] object. It handles cases
  /// where expected keys might be missing from the JSON to prevent null errors
  /// by providing default fallback values.
  ///
  /// - [json]: The JSON map to parse.
  factory User.fromJson(Map<String, dynamic> json) {
    // Safely access the nested 'user' object from the JSON.
    // If 'user' is null or not a map, default to an empty map.
    final userJson = json['user'] as Map<String, dynamic>? ?? {};

    return User(
      // Use the null-coalescing operator '??' to provide a default value
      // if a key is not found in the JSON map.
      id: userJson['id'] ?? 0,
      username: userJson['username'] ?? '',
      knownAs: userJson['knownAs'] ?? '',
      token: json['token'] ?? '',
    );
  }
}