class Language {
  Language(this.id, this.name, this.flag, this.languageCode);

  //Variable reference
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  //Mechanics: Returns language list
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇪🇸", "Español", "es"),
      Language(3, "🇫🇷", "Français", "fr"),
    ];
  }
}
