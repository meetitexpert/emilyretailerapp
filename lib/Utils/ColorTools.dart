import 'package:flutter/material.dart';

class ColorTools {
    
    static const int primaryColor = 0xFF00B4EC;

    static const int navigationBarColor = 0xFFEEEEEE;

    static const int textGrey = 0xFF858585;

    static const MaterialColor applicationColor = MaterialColor(primaryColor, <int, Color> {
            50: Color(0xFFE3F2FD),
            100: Color(0xFFBBDEFB),
            200: Color(0xFF90CAF9),
            300: Color(0xFF64B5F6),
            400: Color(0xFF42A5F5),
            500: Color(primaryColor),
            600: Color(0xFF1E88E5),
            700: Color(0xFF1976D2),
            800: Color(0xFF1565C0),
            900: Color(0xFF0D47A1),
        },
    );

}