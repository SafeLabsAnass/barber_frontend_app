import 'package:barber_app/constant/toast_message.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:logger/logger.dart';

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withError({error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    Logger().e(error.response);
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        ToastMessage.toastMessage('Connection timeout');
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        ToastMessage.toastMessage('Receive timeout in send request');
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        ToastMessage.toastMessage('Receive timeout in connection');
        break;
      case DioErrorType.response:
        _errorMessage = "Received invalid status code: ${error.response!.data}";
        try {
          if (error.response!.data['errors']['phone_no'] != null) {
            ToastMessage.toastMessage(
                error.response!.data['errors']['phone_no'][0]);
            return;
          } else if (error.response!.data['errors']['email'] != null) {
            ToastMessage.toastMessage(
                error.response!.data['errors']['email'][0]);
            return;
          }else if (error.response!.data['errors']['phone'] != null) {
            ToastMessage.toastMessage(
                error.response!.data['errors']['phone'][0]);
            return;
          }
          else if (error.response!.data['errors']['password'] != null) {
            ToastMessage.toastMessage(
                error.response!.data['errors']['password'][0]);
            return;
          }
          else {
            ToastMessage.toastMessage(
                error.response!.data['message'].toString());
            return;
          }
        } catch (error1) {
          try {
            ToastMessage.toastMessage(
                error.response!.data['message'].toString());
            if (error.response!.data['message'].toString() ==
                'Unauthenticated.') {
            }
          } catch (error11) {
            ToastMessage.toastMessage(error.response!.data.toString());
          }
        }
        break;
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        ToastMessage.toastMessage('Request was cancelled');
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        ToastMessage.toastMessage(
            'Connection failed due to internet connection');
        break;
    }
    return _errorMessage;
  }
}
