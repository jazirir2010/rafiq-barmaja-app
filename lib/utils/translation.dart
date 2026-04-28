// utils/translation.dart

class Translation {
  static const Map<String, String> _fushaToTunsi = {
    'إذا': 'كان',
    'طالما': 'مادام',
    'اطبع': 'أخرج',
    'دالة': 'فونكسيون',
    'أرجع': 'رجع',
    'وإلا': 'ولا',
    'عدد': 'نمبر',
    'قائمة': 'ليست',
    'قاموس': 'ديكسيونير',
    'أضف': 'زيد',
    'صح': 'ترو',
    'خطأ': 'فالس',
    'لا شيء': 'فارغ',
  };

  static String toTunisian(String text) {
    String result = text;
    _fushaToTunsi.forEach((fusha, tunsi) {
      result = result.replaceAll(fusha, tunsi);
    });
    return result;
  }

  static String toFusha(String text) {
    String result = text;
    _fushaToTunsi.forEach((fusha, tunsi) {
      result = result.replaceAll(tunsi, fusha);
    });
    return result;
  }
}
