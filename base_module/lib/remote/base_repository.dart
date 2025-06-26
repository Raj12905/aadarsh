import 'dart:convert';

import 'package:get/get.dart';

import '../helper/logs_print.dart';

const int BAD_REQUEST = 400;
const int UNAUTHORIZED = 401;
const int FORBIDDEN = 403;
const int NOT_FOUND = 404;
const int INTERNAL_SERVER_ERROR = 500;
const int SERVICE_UNAVAILABLE = 503;
const int PARSE_FAILURE = 325;

class BaseRepository {
  T handleResponse<T>(Response response, T Function(dynamic) fromJson) {
    try {
      if (_isValidResponseBody(response.bodyString)) {
        var jsonResponse =
            _parseResponse(response.bodyString!, response.statusCode);
        logMessage(jsonResponse, location: 'msnbv6dnrtbg');
        return fromJson(jsonResponse);
      } else {
        return fromJson(_buildErrorResponse(
            'Invalid response body or not a JSON string.',
            response.statusCode));
      }
    } catch (e) {
      print('Error while handling response: $e');
      return fromJson(_buildErrorResponse(e.toString(), response.statusCode));
    }
  }

  bool _isValidResponseBody(String? bodyString) {
    if (bodyString == null || bodyString.isEmpty) {
      return false;
    }

    try {
      jsonDecode(bodyString);
      return true;
    } catch (e) {
      return false;
    }
  }

  dynamic _parseResponse(String bodyString, int? responseCode) {
    try {
      return jsonDecode(bodyString);
    } catch (e) {
      return _buildErrorResponse('Failed to parse response: $e', 325);
    }
  }

  Map<String, dynamic> _buildErrorResponse(
      String errorMessage2, int? responseCode) {
    String errorMessage;
    switch (responseCode) {
      case BAD_REQUEST:
        errorMessage =
            'Bad Request: The server could not understand the request.';
        break;
      case UNAUTHORIZED:
        errorMessage =
            'Unauthorized: Authentication is required and has failed.';
        break;
      case FORBIDDEN:
        errorMessage =
            'Forbidden: You do not have permission to access this resource.';
        break;
      case NOT_FOUND:
        errorMessage = 'Not Found: The requested resource could not be found.';
        break;
      case INTERNAL_SERVER_ERROR:
        errorMessage =
            'Internal Server Error: The server encountered an unexpected condition.';
        break;
      case SERVICE_UNAVAILABLE:
        errorMessage =
            'Service Unavailable: The server is currently unable to handle the request.';
        break;
      case PARSE_FAILURE:
        errorMessage = 'Failed to parse response';
        break;
      default:
        errorMessage = 'An unexpected error occurred. Please try again later.';
        break;
    }
    return {
      'status': false,
      'message': errorMessage,
      'data': null,
    };
  }
}
