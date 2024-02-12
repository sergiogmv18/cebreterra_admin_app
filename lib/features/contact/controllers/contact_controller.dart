

import 'package:flutter/material.dart';
import '../../../shared/models/model_contact.dart';

class ContactController extends ChangeNotifier {

  String _searchStatus = Contact.allStatus()[0];
  String get searchStatus => _searchStatus;
  
  void updateSelectedOption(String option) {
    _searchStatus = option;
    notifyListeners();
  }



}