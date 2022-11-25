class ImageUtils {
  static double getHeightView(double widthDevice, int widthImg, int heightImg) {
    if (widthImg == 0) {
      widthImg = 1;
    }
    if (heightImg == 0) {
      heightImg = 1;
    }
    return (widthDevice * heightImg) / widthImg;
  }

  static String genImgIx(String? url, int w, int h, {bool focusFace = false, bool fillBlur = false, double dpr = 1.7}) {
    if (url == null) {
      return '';
    }

    if (h == 0) {
      return '$url?w=$w&dpr=$dpr';
    }

    if (url.startsWith('https://graph.facebook.com')) {
      return url.replaceAll('&width=600&height=600', '&width=${(w * dpr).toInt()}&height=${(h * dpr).toInt()}');
    }

    if (url.startsWith('https://lh3.googleusercontent.com')) {
      if (url.endsWith('=s96-c')) {
        return url.replaceAll('=s96-c', '=s${(w * dpr).toInt()}');
      }
      return '$url=s${(w * dpr).toInt()}';
    }

    if (fillBlur) {
      return '$url?w=$w&h=$h&fit=fill&fill=blur&dpr=$dpr';
    }

    if (focusFace) {
      return '$url?w=$w&h=$h&fit=crop&crop=faces&dpr=$dpr';
    }
    return '$url?w=$w&h=$h&fit=crop&dpr=$dpr';
  }

  // static String genFbImg(String url, int w, int h) {
  //   return url.replaceAll('&width=600&height=600', '&width=${h * 2}&height=${h * 2}');
  // }
}
