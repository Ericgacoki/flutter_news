import 'package:flutter/cupertino.dart';

ImageProvider<Object> renderImage(String? url) {
  var img = (url != null)
      ? NetworkImage(url)
      : const AssetImage('assets/images/image_not_found.png');
  return img as ImageProvider;
}
