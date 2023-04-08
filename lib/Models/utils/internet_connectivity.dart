import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity
{

  static Future<bool> isNotConnected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return false;

    }
    return true;
  }
}