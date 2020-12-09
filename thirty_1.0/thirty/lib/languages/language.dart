class Language {
  Language(this.id, this.flag, this.name, this.languageCode);

  //Variable reference
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  //Mechanics: Language list generation
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇲🇽", "Spanish", "es"),
      Language(3, "🇫🇷", "French", "fr"),
    ];
  }
}
