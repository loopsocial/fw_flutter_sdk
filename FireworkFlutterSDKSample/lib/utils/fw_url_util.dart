class FWUrlInfo {
  String? url;
  String? iOSUrl;
  String? androidUrl;
  FWUrlInfo({
    this.url,
    this.iOSUrl,
    this.androidUrl,
  });
}

class FWUrlUtil {
  static FWUrlInfo? parseUrl({
    required String url,
    required String iOSQueryName,
    required String androidQueryName,
  }) {
    if (url.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    final queryParameters = uri.queryParameters;

    final urlInfo = FWUrlInfo();

    // Get iOS url and Android Url from query
    queryParameters.forEach((key, value) {
      if (key == iOSQueryName) {
        urlInfo.iOSUrl = value;
      }

      if (key == androidQueryName) {
        urlInfo.androidUrl = value;
      }
    });

    // Remove iOS url and Android url from query
    final resultUri = uri.replace(
      queryParameters: Map.fromEntries(
        queryParameters.entries.where(
          (entry) => entry.key != iOSQueryName && entry.key != androidQueryName,
        ),
      ),
    );

    urlInfo.url = resultUri.toString();

    return urlInfo;
  }
}
