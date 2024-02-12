import 'package:cebreterra/shared/entities/branch.dart';
import 'package:flutter/material.dart';

class BranchController extends ChangeNotifier {

  BranchCebreterra? _selectedBranch;
  
  BranchCebreterra? get selectedBranch => _selectedBranch;
  
  void updateSelectedOption(BranchCebreterra branch) {
    _selectedBranch = branch;
    notifyListeners();
  }
}