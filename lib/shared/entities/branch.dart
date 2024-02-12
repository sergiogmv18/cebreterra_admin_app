import 'package:cebreterra/shared/entities/model_base.dart';

class BranchCebreterra extends ModelBase{
  String? iso;
  String? country;
  BranchCebreterra ({int? serverId,this.country, this.iso}): super(serverId: serverId);
  //Gets
  String? getCountry(){
    return country;
  }

  String? getIso(){
    return iso;
  }

  //SETs
  void setCountry(String? country){
    this.country = country;
  }

  void setIso(String? iso){
    this.iso = iso;
  }
}