class NetworkSettings {
  NetworkSettings._();

  static String baseUrl = 'https://economia.awesomeapi.com.br/';

  static String getCoinConverter(String conversion) {
    return '${baseUrl}json/last/$conversion';
  }
}