

// // use custom class for language items
class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  // list of languages
  static List<Language> languageList(){
    return <Language>[
      Language(1, '🇺🇸', 'English', 'en'),
      Language(2, '🇨🇴', 'Español', 'es'),
    ];
  }
}