

import 'package:cebreterra/shared/entities/branch.dart';
import 'package:cebreterra/utils/services/request.dart';

class Branch extends BranchCebreterra{


 /*
  * Convert json of server to Obj branch
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <List>
  */
  Future<List> convertStringInObjBranch({required List data})async{
    List allBranch = [];
    if(data.isNotEmpty){
      for(int c = 0; c < data.length; c++){
         BranchCebreterra branchWk = BranchCebreterra(serverId:int.parse(data[c][0].toString()), iso:data[c][1].toString(), country:data[c][3].toString());
        allBranch.add(branchWk);
      }
    }
    return allBranch;
  }  


  /*
  * get all Branch
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List> getAll() async{
    List allBranch = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllBranch',
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters, server: RequestHttp.serverCebreterra);
    if(response['success']){
      allBranch = await convertStringInObjBranch(data: response['payload']);
    }
    return allBranch;
  }

}





