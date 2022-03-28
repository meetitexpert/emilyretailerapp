import 'dart:ui';

class PixelTools {

    static late double rate;//和设计尺寸比率
    static late double designWidth;//屏幕显示宽度
    static late double designHeight;//屏幕显示宽度

    static late double dpi;//当前设备dpi

    static late double screenWidth;//屏幕显示宽度
    static late double screenHeight;//屏幕显示宽度

    static late double statusBarHeight;//屏幕状态栏宽=高度
    static late double navigatorBarHeight;//屏幕导航栏高度
    
    static void init(double width, double height)
    {
        designWidth = width;
        designHeight = height;

        dpi = window.devicePixelRatio;

        screenWidth = window.physicalSize.width / dpi;
        screenHeight = (window.physicalSize.height - window.padding.top - window.padding.bottom) / dpi;
       
        statusBarHeight = window.padding.top / dpi;
        navigatorBarHeight = window.padding.bottom / dpi;

        rate = screenWidth / designWidth;
    }

    static double fitValue(double width)
    {
        return width * rate;
    }
}