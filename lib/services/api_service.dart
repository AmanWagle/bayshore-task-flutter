import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<dynamic> get(String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );

    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );

    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      // Attempt to extract the error message from the response body, if available
      String errorMessage = 'Failed with status code: ${response.statusCode}';
      try {
        final responseBody = json.decode(response.body);
        if (responseBody is Map && responseBody.containsKey('message')) {
          errorMessage = responseBody['message'] ?? errorMessage;
        }
      } catch (e) {
        throw Exception(errorMessage);
        // If there's an issue decoding the body, we'll fall back to a generic error message
      }
      throw errorMessage;
    }
  }

  Future<dynamic> postWithImage(String endpoint, Map<String, dynamic> data,
      String imageName, File? image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      // Prepare the multipart request
      var uri = Uri.parse('$baseUrl$endpoint');
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          if (token != null) 'Authorization': 'Bearer $token',
        });

      data.forEach((key, value) {
        request.fields[key] =
            value.toString(); // Convert dynamic to String if needed
      });

      // Add the image as a multipart file if provided
      if (image != null) {
        var imageFile = await http.MultipartFile.fromPath(
          imageName, // Field name expected by the backend
          image.path,
          contentType:
              MediaType('image', 'jpeg'), // Adjust for PNG or other formats
        );
        request.files.add(imageFile);
      }

      // Send the request
      var response = await request.send();

      // Process the response
      final responseString = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(responseString);
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // New PUT request method to handle image upload
  Future<dynamic> putWithImage(String endpoint, Map<String, dynamic> data,
      String imageName, File? image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      // Prepare the multipart request
      var uri = Uri.parse('$baseUrl$endpoint');
      var request = http.MultipartRequest('PUT', uri)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          if (token != null) 'Authorization': 'Bearer $token',
        });

      // Add data to the request
      data.forEach((key, value) {
        request.fields[key] =
            value.toString(); // Convert dynamic to String if needed
      });

      // Add the image as a multipart file if provided
      if (image != null) {
        var imageFile = await http.MultipartFile.fromPath(
          imageName, // Field name expected by the backend
          image.path,
          contentType:
              MediaType('image', 'jpeg'), // Adjust for PNG or other formats
        );
        request.files.add(imageFile);
      }

      // Send the request
      var response = await request.send();

      // Process the response
      final responseString = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(responseString);
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }
}
