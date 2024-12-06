import 'package:clients/core/theme/app_colors.dart';
import 'package:equatable/equatable.dart';

class AppTheme extends Equatable {
  final bool isDarkTheme;
  AppColors get appColors => isDarkTheme ? DarkAppColors() : LightAppColors();

  const AppTheme({required this.isDarkTheme});

  AppTheme copyWith({bool? isDarkTheme}) {
    return AppTheme(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
  }

  @override
  List<Object?> get props => [isDarkTheme];
}
