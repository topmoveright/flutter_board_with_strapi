import 'dart:typed_data';

abstract class InterfaceUpload {
  upload(Uint8List data, String extension);

  delete();

  get();

  list();
}
