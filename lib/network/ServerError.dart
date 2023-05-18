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
        _errorMessage = "expiration du délai de connexion";
        ToastMessage.toastMessage('expiration du délai de connexion');
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        ToastMessage.toastMessage( 'Délai de réception expiré lors de l envoi de la demande.');
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Délai de réception expiré lors de la connexion.";
        ToastMessage.toastMessage('Délai de réception expiré lors de la connexion.');
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
        _errorMessage = "La demande a été annulée.";
        ToastMessage.toastMessage('La demande a été annulée.');
        break;
      case DioErrorType.other:
        _errorMessage = "La connexion a échoué en raison de connexion Internet.";
        ToastMessage.toastMessage(
            'La connexion a échoué en raison de connexion Internet.');
        break;
    }
    return _errorMessage;
  }
}
