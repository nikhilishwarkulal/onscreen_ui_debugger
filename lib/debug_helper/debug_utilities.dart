import 'dart:convert';

import 'debug_helper_bloc.dart';
import 'debug_log_bloc.dart';

//This code will be the part of debugger // No performance test needed or
//Extensive review needed
class DebugUtils {
  static const bool _buildForDebug = true;
  static final TestBloc testBloc = TestBloc();
  static DebugLogBloc debugLogBloc = DebugLogBloc();
  static bool isBuildForDebug() {
    if (_buildForDebug) {
      return true;
    } else {
      return false;
    }
  }

  static String getMapToString(Map<String, dynamic>? data) {
    if (data == null) return "null";
    try {
      return jsonEncode(data);
    } catch (_) {
      return data.toString();
    }
  }
}
