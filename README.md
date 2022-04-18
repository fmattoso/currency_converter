# currency_converter

Projeto em Flutter de um Conversor de Moedas
- Utiliza a API hgbrasil.com
- Biblioteca http

## Classe HgBrasilKey
Para compilar, primeiro crie uma cadastro e um chave no [HG Brasil](https://hgbrasil.com), depois crie
uma classe como descrito abaixo. Esta classe não está neste repositório pois contém a minha chave ;)

class HgBrasilKey {

  static const String _urlGetFinance = 'https://api.hgbrasil.com/finance/quotations?key=SUA_CHAVE';

  static String get urlGetFinance {return _urlGetFinance;}

}

## Erro [BUG] Unhandled exception: FormatException: Invalid number (at character 1) no flutter_launcher_icons-0.9.2

Solved with replacing this line (~/flutter/.pub-cache/hosted/pub.dartlang.org/flutter_launcher_icons-0.9.2/lib/android.dart#308):

      // final String minSdk = line.replaceAll(RegExp(r'[^\d]'), '');
      // To this:
      final String minSdk = "21"; // line.replaceAll(RegExp(r'[^\d]'), '');

- [github - fluttercommunity](https://github.com/fluttercommunity/flutter_launcher_icons/issues/324)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
