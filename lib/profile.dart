import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(248, 252, 249, 249),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 202, 203, 204),
          iconTheme: IconThemeData(color: theme.primaryColor),
          automaticallyImplyLeading: true,
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
          title: Padding(
            padding: EdgeInsetsDirectional.only(end: 170),
            child: Text(
              'Profile',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.0,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              _buildBackgroundShapes(),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildProfileImage(),
                      _buildProfileName('Elza Hamilton', theme),
                      _buildEditProfileButton(context),
                      _buildProfileStats(theme),
                      _buildSupportSection(context),
                      _buildActionButtons(context),
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

  // Helper method to build background shapes
  Widget _buildBackgroundShapes() {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(1.97, 0.13),
          child: Container(
            width: 273,
            height: 500,
            decoration: BoxDecoration(
              color: const Color.fromARGB(192, 197, 197, 197),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(1000),
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1.97, 0.13),
          child: Container(
            width: 273,
            height: 500,
            decoration: BoxDecoration(
              color: const Color.fromARGB(192, 197, 197, 197),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(1000),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build profile image
  Widget _buildProfileImage() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 40),
      child: Container(
        width: 245,
        height: 245,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network(
          'https://picsum.photos/seed/50/600',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Helper method to build profile name text
  Widget _buildProfileName(String name, ThemeData theme) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 15),
      child: Text(
        name,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: 0.0,
        ),
      ),
    );
  }

  // Helper method to build 'Edit Profile' button
  Widget _buildEditProfileButton(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 10),
      child: Container(
        width: 131,
        height: 34,
        decoration: BoxDecoration(
          color: const Color.fromARGB(192, 151, 147, 147),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(
          'Edit Profile',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }

  // Helper method to build profile stats (Liked, History, Recently Viewed)
  Widget _buildProfileStats(ThemeData theme) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(theme, 'Liked'),
          _buildStatItem(theme, 'History'),
          _buildStatItem(theme, 'Recently Viewed', fontSize: 12),
        ],
      ),
    );
  }

  // Helper method to build each stat item
  Widget _buildStatItem(ThemeData theme, String label, {double fontSize = 16}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(192, 151, 147, 147),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build support section (Help, Chat)
  Widget _buildSupportSection(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsetsDirectional.only(top: 30),
      child: Container(
        width: double.infinity,
        height: 128,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 174, 180, 180),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 10),
              child: Text(
                'Support',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.0,
                ),
              ),
            ),
            _buildSupportRow(context, Icons.help, 'Help'),
            _buildSupportRow(context, Icons.chat, 'Chat'),
          ],
        ),
      ),
    );
  }

  // Helper method to build support row
  Widget _buildSupportRow(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20),
          child: Icon(
            icon,
            color: Colors.black,
            size: 24,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 40),
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.0,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCustomButton(context, 'Product', () {
            print('Product button pressed');
          }),
          _buildCustomButton(context, 'Color Analysis', () {
            print('Color Analysis button pressed');
          }, fontSize: 14),
          _buildCustomButton(context, 'Profile', () {
            print('Profile button pressed');
          }),
        ],
      ),
    );
  }

  // Helper method to build custom button
  Widget _buildCustomButton(
      BuildContext context, String text, VoidCallback onPressed,
      {double fontSize = 16}) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(192, 197, 197, 197), // Correct parameter here
        padding: EdgeInsets.symmetric(horizontal: 24),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          letterSpacing: 0.0,
        ),
      ),
    );
  }
}
