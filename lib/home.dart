import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class SkinToneDetector extends StatefulWidget {
  @override
  _SkinToneDetectorState createState() => _SkinToneDetectorState();
}

class _SkinToneDetectorState extends State<SkinToneDetector> {
  File? _image;
  final picker = ImagePicker();
  String? _skinTone;
  List<dynamic>? _dominantColors;
  double? _accuracy;
  String? _seasonCategory;
  Map<String, String>? _colorPalette;
  String? _error;
  bool _isLoading = false;
  var bgColor = Color(0xFFE9FAFE);

  List<dynamic>? _products;
  bool _isFetchingProducts = false;

  double _imageX = 0;
  double _imageY = 0;
  GlobalKey _imageKey = GlobalKey();

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageX = 0;
        _imageY = 0;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageX = 0;
        _imageY = 0;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No image to upload.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    File? croppedImage = await _captureCroppedImage();

    if (croppedImage == null) {
      setState(() {
        _error = 'Failed to crop image.';
        _isLoading = false;
      });
      return;
    }

    final request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.1.228:3009/process_image'));
    request.files
        .add(await http.MultipartFile.fromPath('image', croppedImage.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = json.decode(responseBody);
        setState(() {
          _dominantColors = responseData['dominant_colors'];
          _skinTone = responseData['skin_tone'];
          _accuracy = responseData['accuracy'];
          _seasonCategory = responseData['season_category'];
          _colorPalette =
              Map<String, String>.from(responseData['color_palette']);
          _error = null;

          _fetchProducts(_seasonCategory);
        });
      } else {
        setState(() {
          _error =
              'Failed to upload image: ${response.reasonPhrase}\n$responseBody';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchProducts(String? seasonCategory) async {
    if (seasonCategory == null) return;

    setState(() {
      _isFetchingProducts = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'http://localhost:3009/get_products')); // Replace with your actual API endpoint
      if (response.statusCode == 200) {
        setState(() {
          _products = json.decode(response.body);
          _error = null;
        });
      } else {
        setState(() {
          _error = 'Failed to fetch products: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred while fetching products: $e';
      });
    } finally {
      setState(() {
        _isFetchingProducts = false;
      });
    }
  }

  Future<File?> _captureCroppedImage() async {
    try {
      RenderRepaintBoundary boundary =
          _imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get directory to save cropped image
      final directory = await getApplicationDocumentsDirectory();
      File imgFile = File('${directory.path}/cropped_image.png');
      await imgFile.writeAsBytes(pngBytes);
      return imgFile;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _reset() {
    setState(() {
      _image = null;
      _skinTone = null;
      _dominantColors = null;
      _accuracy = null;
      _seasonCategory = null;
      _colorPalette = null;
      _error = null;
      _products = null;
      _imageX = 0;
      _imageY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Tone Detector',
            style: TextStyle(
              fontFamily: 'FFMark',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
        backgroundColor: bgColor,
        toolbarHeight: 70,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _imageX += details.delta.dx;
                    _imageY += details.delta.dy;
                  });
                },
                child: ClipOval(
                  child: RepaintBoundary(
                    key: _imageKey,
                    child: Container(
                      color: Colors.grey[300],
                      width: 250,
                      height: 250,
                      child: _image != null
                          ? Transform.translate(
                              offset: Offset(_imageX, _imageY),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Image Selected',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_image == null || _skinTone == null) ...[
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Capture Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: Icon(Icons.photo_library),
                  label: Text('Upload Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 20),
              if (_image != null && !_isLoading)
                ElevatedButton.icon(
                  onPressed: _uploadImage,
                  icon: Icon(Icons.cloud_upload),
                  label: Text('Process Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              if (_isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE9FCF4)),
                ),
              if (_error != null) ...[
                Text(_error!,
                    style: TextStyle(
                        fontSize: 18, color: Colors.red, fontFamily: 'FFMark')),
                SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
