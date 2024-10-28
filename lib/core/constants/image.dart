class Images {
  static const logo = "assets/images/logo.png";
  static const en = "assets/images/en.png";
  static const vi = "assets/images/vi.png";

  static String getImage(String key) {
    switch (key) {
      case 'en':
        return en;
      case 'vi':
        return vi;
      default:
        return logo;
    }
  }
}
