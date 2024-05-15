import 'package:no_code_rag_frontend/theme/colors.dart';
import 'package:no_code_rag_frontend/theme/decoration.dart';
import 'package:no_code_rag_frontend/theme/icons.dart';
import 'package:no_code_rag_frontend/theme/measures.dart';
import 'package:no_code_rag_frontend/theme/styles.dart';
import 'package:sidebarx/sidebarx.dart';

SidebarXTheme baseSideBarXTheme = SidebarXTheme(
    margin: edgeSymmetricV160H10,
    padding: edgeOnlyT8L6R6,
    decoration: boxDecorBorderRadiusCircular8ColorP,
    textStyle: textSize16Weight4ColorW,
    selectedTextStyle: textSize16Weight6ColorP,
    hoverTextStyle: textSize16Weight4ColorP,
    itemTextPadding: edgeOnlyL20,
    selectedItemTextPadding: edgeOnlyL20,
    itemDecoration: boxDecorBorderRadiusCircular14,
    hoverColor: colorWhite12,
    selectedItemDecoration: boxDecorBorderRadiusCircular14ColorW,
    iconTheme: iconThemeSize26ColorW,
    hoverIconTheme: iconThemeSize26ColorW,
    selectedIconTheme: iconThemeSize26ColorP);

SidebarXTheme extendedSideBarXTheme = SidebarXTheme(
    width: 170,
    margin: edgeSymmetricV160H10,
    padding: edgeOnlyT8L6R6,
    decoration: boxDecorBorderRadiusCircular8ColorP);
