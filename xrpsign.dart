import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef sign = Pointer<Utf8> Function(Pointer<Utf8> tx, Pointer<Utf8> s);
typedef Sign = Pointer<Utf8> Function(Pointer<Utf8> tx, Pointer<Utf8> s);
main() {
  var tx = '''{
  "TransactionType" : "Payment",
  "Account" : "rGPASC5XqhTJZUDq1o4sSSWsevKxfXJWYz",
  "Destination" : "ra5nK24KXen9AHvsdFTKHSANinZseWnPcX",
  "Amount" : "25000000",
  "Fee": "12",
  "Flags": 2147483648,
  "Sequence": 1
}''';

  final dylib = DynamicLibrary.open('xrpsign.dll');
  var txp = Utf8.toUtf8(tx);
  var s = Utf8.toUtf8('ssrb5FxNGHrKcKQPeBh7dCA41BpAv');
  final Sign xrpsign = dylib.lookup<NativeFunction<sign>>('Sign').asFunction();
  print(Utf8.fromUtf8(xrpsign(txp, s)));
}
