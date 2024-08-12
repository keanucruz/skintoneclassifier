import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage(); // Automatically upload the image after picking it
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
        _uploadImage(); // Automatically upload the image after picking it
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

    final request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.18.211:3009/process_image'));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

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
          _colorPalette = Map<String, String>.from(responseData['color_palette']);
          _error = null;
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

  void _reset() {
    setState(() {
      _image = null;
      _skinTone = null;
      _dominantColors = null;
      _accuracy = null;
      _seasonCategory = null;
      _colorPalette = null;
      _error = null;
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
              if (_image == null)
                Column(
                  children: [
                    Text(
                      '📸 Capture or Upload Your Image',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'FFMark',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Tap the "Pick Image" button.\n2. Take a photo or choose from gallery.\n3. View your results.',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'FFMark'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              if (_image != null) Image.file(_image!),
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
              if (_skinTone != null && !_isLoading) ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Detected Skin Tone:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'FFMark')),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse(_skinTone!.substring(1), radix: 16) +
                                  0xFF000000),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: Text('Hex Code: $_skinTone',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'FFMark'))),
                      SizedBox(height: 10),
                      if (_dominantColors != null) ...[
                        Text('Dominant Colors:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'FFMark')),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _dominantColors!.map((colorData) {
                            return Expanded(
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      colorData['color'].substring(1),
                                      radix: 16) +
                                      0xFF000000),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                      ],
                      Center(
                          child: Text(
                              'Accuracy: ${_accuracy?.toStringAsFixed(2)}%',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'FFMark'))),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (_seasonCategory != null) ...[
                  Text('Season Category: $_seasonCategory',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'FFMark')),
                  SizedBox(height: 10),
                  if (_colorPalette != null) ...[
                    Text('Recommended Colors:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'FFMark')),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: _colorPalette!.length,
                      itemBuilder: (context, index) {
                        final entry = _colorPalette!.entries.elementAt(index);
                        final color = Color(int.parse(entry.value.substring(1), radix: 16) + 0xFF000000);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: color,
                                border: Border.all(color: Colors.grey.shade300, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      entry.key,
                                      style: TextStyle(
                                        fontSize: 14, // Increased font size
                                        color: Colors.white,
                                        fontFamily: 'FFMark',
                                        shadows: [
                                          Shadow(
                                            blurRadius: 2.0,
                                            color: Colors.black.withOpacity(0.8),
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ],
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: Icon(Icons.refresh),
                  label: Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
