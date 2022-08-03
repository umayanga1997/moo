import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) {
    return super.send(request..headers.addAll(_headers));
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    return super.head(url, headers: _headers);
  }
}
