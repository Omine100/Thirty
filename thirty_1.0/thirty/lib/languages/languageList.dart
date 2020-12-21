class LanguageList {
  LanguageList(this.id, this.name, this.flag, this.languageCode);

  //Variable reference
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  //Mechanics: Returns language list
  static List<LanguageList> getLanguageList() {
    return <LanguageList>[
      LanguageList(1, "🇺🇸", "English", "en"),
      LanguageList(2, "🇪🇸", "Español", "es"),
      LanguageList(3, "🇫🇷", "Français", "fr"),
    ];
  }
}
