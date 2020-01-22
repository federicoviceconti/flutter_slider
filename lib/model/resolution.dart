class ResolutionScreen {
  final Resolution baseResolution;
  Resolution currentResolution;

  ResolutionScreen({this.baseResolution, this.currentResolution});

  double getDimen(double dimen, String s) {
    if(dimen != null) {
      if(s == "w") {
        return currentResolution.width * dimen / baseResolution.width;
      }

      return currentResolution.height * dimen / baseResolution.height;
    }

    return 0;
  }

  factory ResolutionScreen.fromSliderJson(Map<String, dynamic> json) {
    var resolution = json['resolution'];
    return ResolutionScreen(
      baseResolution: Resolution(
        width: resolution['width'],
        height: resolution['height']
      )
    );
  }
}

class Resolution {
  final int width;
  final int height;

  Resolution({this.width, this.height});

  get aspectRatio => width / height;
}