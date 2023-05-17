import 'package:flutter/cupertino.dart';
import 'package:movies/repository/api_get_data.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.repository,
});
  final HomeRepository repository;
}