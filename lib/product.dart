import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'product.dart';
export 'product.dart';

class CartWidget extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white, // Example color for background
        appBar: AppBar(
          backgroundColor: Color(0xFFE0E4E8),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black, // Example color for icon
              size: 24,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Text(
              'Shopping Bag/Cart',
              style: GoogleFonts.roboto(
                fontSize: 25,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Text(
                          'Below are the items in your cart.',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: Container(
                          width: double.infinity,
                          height: 104,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Alternative to FlutterFlowTheme's secondaryBackground
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0.0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: Colors
                                      .grey, // Alternative to FlutterFlowTheme's secondaryText
                                  size: 24,
                                ),
                                Hero(
                                  tag: 'ControllerImage',
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/7c5678f4-c28d-4862-a8d9-56750f839f12/zion-1-basketball-shoes-bJ0hLJ.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 8),
                                          child: Text(
                                            'Zion 1',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .black, // Alternative to primaryText
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$120.00',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors
                                                .black54, // Alternative to labelMedium
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'Quantity: 1',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .grey, // Alternative to labelSmall
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30, 0, 0),
                                      child: Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[
                                              200], // Static color, alternative to secondaryBackground
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.minus,
                                              size: 10,
                                              color: Colors
                                                  .grey, // Static icon and color
                                            ),
                                            Text(
                                              '1', // Static quantity
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.plus,
                                              size: 10,
                                              color: Colors
                                                  .black, // Static icon and color
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: Container(
                          width: double.infinity,
                          height: 104,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Alternative to FlutterFlowTheme's secondaryBackground
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0.0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: Colors
                                      .grey, // Alternative to FlutterFlowTheme's secondaryText
                                  size: 24,
                                ),
                                Hero(
                                  tag: 'ControllerImage',
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/7c5678f4-c28d-4862-a8d9-56750f839f12/zion-1-basketball-shoes-bJ0hLJ.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 8),
                                          child: Text(
                                            'Zion 1',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .black, // Alternative to primaryText
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$120.00',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors
                                                .black54, // Alternative to labelMedium
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'Quantity: 1',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .grey, // Alternative to labelSmall
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30, 0, 0),
                                      child: Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[
                                              200], // Static color, alternative to secondaryBackground
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.minus,
                                              size: 10,
                                              color: Colors
                                                  .grey, // Static icon and color
                                            ),
                                            Text(
                                              '1', // Static quantity
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.plus,
                                              size: 10,
                                              color: Colors
                                                  .black, // Static icon and color
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: Container(
                          width: double.infinity,
                          height: 104,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Alternative to FlutterFlowTheme's secondaryBackground
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0.0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: Colors
                                      .grey, // Alternative to FlutterFlowTheme's secondaryText
                                  size: 24,
                                ),
                                Hero(
                                  tag: 'ControllerImage',
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/7c5678f4-c28d-4862-a8d9-56750f839f12/zion-1-basketball-shoes-bJ0hLJ.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 8),
                                          child: Text(
                                            'Zion 1',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .black, // Alternative to primaryText
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$120.00',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors
                                                .black54, // Alternative to labelMedium
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'Quantity: 1',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .grey, // Alternative to labelSmall
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30, 0, 0),
                                      child: Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[
                                              200], // Static color, alternative to secondaryBackground
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.minus,
                                              size: 10,
                                              color: Colors
                                                  .grey, // Static icon and color
                                            ),
                                            Text(
                                              '1', // Static quantity
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.plus,
                                              size: 10,
                                              color: Colors
                                                  .black, // Static icon and color
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: Container(
                          width: double.infinity,
                          height: 104,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Alternative to FlutterFlowTheme's secondaryBackground
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0.0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: Colors
                                      .grey, // Alternative to FlutterFlowTheme's secondaryText
                                  size: 24,
                                ),
                                Hero(
                                  tag: 'ControllerImage',
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/7c5678f4-c28d-4862-a8d9-56750f839f12/zion-1-basketball-shoes-bJ0hLJ.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 8),
                                          child: Text(
                                            'Zion 1',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .black, // Alternative to primaryText
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$120.00',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors
                                                .black54, // Alternative to labelMedium
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'Quantity: 1',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .grey, // Alternative to labelSmall
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey, // Static color
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30, 0, 0),
                                      child: Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[
                                              200], // Static color, alternative to secondaryBackground
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.minus,
                                              size: 10,
                                              color: Colors
                                                  .grey, // Static icon and color
                                            ),
                                            Text(
                                              '1', // Static quantity
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.plus,
                                              size: 10,
                                              color: Colors
                                                  .black, // Static icon and color
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 69, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 94,
                              decoration: BoxDecoration(
                                color: Colors.grey[
                                    300], // Alternative to FlutterFlowTheme accent4
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 0, 0),
                                    child: Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors
                                          .grey, // Static color alternative to secondaryText
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .black, // Alternative for bodyMedium style
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          250, 0, 0, 0),
                                      child: Container(
                                        width: 90,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[
                                              200], // Alternative to secondaryBackground
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'add to cart',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .black, // Alternative bodyMedium style
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[
                                  200], // Alternative to secondaryBackground
                              border: Border.all(
                                color: Colors
                                    .black, // Alternative for primaryText border color
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: TextButton(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    style: TextButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
                                      backgroundColor: const Color.fromARGB(
                                          255,
                                          212,
                                          215,
                                          218), // Alternative button color
                                      foregroundColor:
                                          Colors.white, // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            60), // Button border radius
                                      ),
                                    ),
                                    child: Text(
                                      'Product',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Colors.black, // Button text color
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    backgroundColor: const Color.fromARGB(
                                        255, 212, 215, 218), // Button color
                                    foregroundColor: Colors.white, // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                  child: Text(
                                    'Color Analysis',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: TextButton(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    style: TextButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
                                      backgroundColor: const Color.fromARGB(
                                          255, 212, 215, 218), // Button color
                                      foregroundColor:
                                          Colors.white, // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                    ),
                                    child: Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
