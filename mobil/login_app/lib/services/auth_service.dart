import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_app/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A service class responsible for handling all authentication-related API requests.
///
/// This class provides methods for user login and registration by communicating
/// with the backend server.
class AuthService {
  // Read the base URL from environment variables.
  // The '/api/Auth' part is appended manually.
  final String _baseUrl = '${dotenv.env['API_BASE_URL']}/api/Auth';

  /// Authenticates a user by sending their credentials to the backend API.
  ///
  /// Takes the user's [email] and [password] as input. On successful authentication,
  /// it returns a [Future] containing a [User] object, which includes user
  /// details and a JWT token.
  ///
  /// Throws an [Exception] if the login fails due to incorrect credentials,
  /// network issues, or other server-side errors.
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      // and convert it to a User object.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception with the response body to indicate failure.
      throw Exception('Login failed. Error: ${response.body}');
    }
  }

  /// Registers a new user by sending their details to the backend API.
  ///
  /// Requires all user details such as [username], [password], [email], etc.
  /// Returns a [Future<void>] which completes successfully if the registration
  /// is accepted by the server.
  ///
  /// Throws an [Exception] if the registration fails due to validation errors
  /// (e.g., username already exists, passwords do not match) or other server-side issues.
  Future<void> register({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'confirmPassword': confirmPassword,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
      }),
    );

    // A successful registration is expected to return a 201 Created or 200 OK status.
    if (response.statusCode != 201 && response.statusCode != 200) {
      // If an error occurs, attempt to parse the response body to extract a
      // more user-friendly error message.
      try {
        final errorBody = jsonDecode(response.body);
        if (errorBody != null && errorBody['errors'] != null) {
          final errors = errorBody['errors'];
          final String errorMessage = errors.entries.first.value[0];
          throw Exception(errorMessage);
        } else {
          throw Exception(errorBody['message'] ?? response.body);
        }
      } catch (e) {
        // If parsing fails or the error is not in the expected format,
        // throw the raw response body or the parsing error.
        throw Exception(e.toString().contains('Exception:') ? e.toString().split('Exception: ')[1] : response.body);
      }
    }
  }
}