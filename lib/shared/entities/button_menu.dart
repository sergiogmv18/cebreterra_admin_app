import 'package:cebreterra/shared/entities/model_base.dart';
import 'package:flutter/material.dart';

class   ButtonMenuCebreterra extends ModelBase{
  final String? route;
  final String? title;
  final IconData? icon;
  ButtonMenuCebreterra ({int? serverId,this.icon, this.route, this.title}): super(serverId: serverId);

}