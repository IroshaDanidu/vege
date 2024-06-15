import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MaterialApp(
    home: PricesPage(),
  ));
}

class PricesPage extends StatefulWidget {
  @override
  _PricesPageState createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  List<dynamic> fruits = [];
  bool isLoading = true;
  GlobalKey globalKey = GlobalKey();
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    fetchFruitPrices();
    _checkConnectivity(); // Check connectivity on init
  }

  Future<void> fetchFruitPrices() async {
    final url = 'https://www.fruityvice.com/api/fruit/all';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          fruits = json.decode(response.body);
          isLoading = false;
        });
      } else {
        // Handle error
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle network error
      print('Error fetching fruit prices: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOffline = true;
      });
    } else {
      setState(() {
        isOffline = false;
      });
    }

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isOffline = result == ConnectivityResult.none;
      });
      if (isOffline) {
        // Handle offline state here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Fruits Info'),
        centerTitle: true,
        backgroundColor: Colors.green[700], // Adjust as needed
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: () {
              if (!isOffline) {
                _saveAsImage();
              } else {
                _showOfflineSnackbar();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.picture_as_pdf_rounded),
            onPressed: () {
              if (!isOffline) {
                _saveAsPdf();
              } else {
                _showOfflineSnackbar();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: !isOffline,
            child: Center(
              child: Visibility(
                visible: isLoading,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Visibility(
            visible: !isLoading && !isOffline,
            child: RepaintBoundary(
              key: globalKey,
              child: ListView.builder(
                itemCount: fruits.length,
                itemBuilder: (context, index) {
                  var fruit = fruits[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.green[100]!, Colors.green[300]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          title: Text(
                            fruit['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                'ID: ${fruit['id']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Family: ${fruit['family']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Order: ${fruit['order']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Genus: ${fruit['genus']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Nutritional Information:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildNutrientText('Calories', fruit['nutritions']['calories']),
                                  _buildNutrientText('Fat', fruit['nutritions']['fat']),
                                  _buildNutrientText('Sugar', fruit['nutritions']['sugar']),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildNutrientText('Carbohydrates', fruit['nutritions']['carbohydrates']),
                                  _buildNutrientText('Protein', fruit['nutritions']['protein']),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: isOffline,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You are offline',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red, // Red color for offline message
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _checkConnectivity(); // Check connectivity again
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientText(String label, dynamic value) {
    return Text(
      '$label: $value',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  Future<void> _saveAsImage() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      final directory = await getTemporaryDirectory(); // Use temporary directory
      String filePath = '${directory.path}/fruits_image.png';
      File file = File(filePath);
      await file.writeAsBytes(byteData!.buffer.asUint8List()); // Write image to file

      // Save image to gallery
      final result = await ImageGallerySaver.saveFile(file.path);

      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image saved to gallery')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save image')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save image')));
      print(e);
    }
  }

  Future<void> _saveAsPdf() async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: fruits.map((fruit) => _buildPdfFruitItem(fruit)).toList(),
              ),
            );
          },
        ),
      );

      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/fruits.pdf');
      await file.writeAsBytes(await pdf.save());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF saved to ${file.path}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save PDF')));
      print(e);
    }
  }

  pw.Widget _buildPdfFruitItem(Map<String, dynamic> fruit) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            fruit['name'],
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 18,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            'ID: ${fruit['id']}',
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
          pw.Text(
            'Family: ${fruit['family']}',
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
          pw.Text(
            'Order: ${fruit['order']}',
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
          pw.Text(
            'Genus: ${fruit['genus']}',
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            'Nutritional Information:',
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildPdfNutrientText('Calories', fruit['nutritions']['calories']),
              _buildPdfNutrientText('Fat', fruit['nutritions']['fat']),
              _buildPdfNutrientText('Sugar', fruit['nutritions']['sugar']),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildPdfNutrientText('Carbohydrates', fruit['nutritions']['carbohydrates']),
              _buildPdfNutrientText('Protein', fruit['nutritions']['protein']),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfNutrientText(String label, dynamic value) {
    return pw.Container(
      margin: pw.EdgeInsets.only(top: 2, bottom: 2),
      child: pw.Text(
        '$label: $value',
        style: pw.TextStyle(
          fontSize: 14,
          color: PdfColors.black,
        ),
      ),
    );
  }

  void _showOfflineSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'You are offline. Please connect to the internet to perform this action.',
          style: TextStyle(color: Colors.red), // Red color for offline message
        ),
      ),
    );
  }
}
