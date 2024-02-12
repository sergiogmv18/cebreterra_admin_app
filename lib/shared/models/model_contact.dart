
import 'package:cebreterra/shared/entities/contact.dart';
import 'package:cebreterra/utils/services/request.dart';

class Contact extends ContactCebreterra{

 /*
  * Convert json of server to Obj Services
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <List>
  */
  Future<List> convertStringInObjContact({required List data})async{
    List allContact = [];
    if(data.isNotEmpty){
      for(int c = 0; c < data.length; c++){
        ContactCebreterra contactWk = ContactCebreterra(serverId:int.parse(data[c][0].toString()), fullName:data[c][1].toString(), phoneNumber:data[c][3].toString(), email:data[c][2].toString(), comments:data[c][4].toString(), status:data[c][5].toString());
        allContact.add(contactWk);
      }
    }
    return allContact;
  }  


  /*
  * get all Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List> getAll() async{
    List allContacts = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllContact',
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters, server: RequestHttp.serverCebreterra);
    if(response['success']){
      allContacts = await convertStringInObjContact(data: response['payload']);
    }
    return allContacts;
  }

  /*
  * get all Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List> getAllContactForStatus(String status) async{
    List allContacts = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllContactForStatus',
      'status': status
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters, server: RequestHttp.serverCebreterra);
    if(response['success']){
      allContacts = await convertStringInObjContact(data: response['payload']);
    }
    return allContacts;
  }


 /*
  * Delete Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<bool>deleteSpecificContact(Contact contact)async{
     Map<String, dynamic> parameters = {
      'action': 'deleteContact',
      'id': contact.getServerId().toString(),
       };
        print(parameters);
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    print(response);
    return response['success'];
  } 
  
/*
  * Register Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<Map<String, dynamic>> registerOrEditContact(Contact contact)async{
    Map<String, dynamic> response = {};
    Map<String, dynamic> parameters = {
      'action':'registerOrEditContact',
      'status': contact.getStatus(),
      'fullName':contact.getFullName(),
      'email': contact.getEmail(),
      'comments': contact.getComments(),
      'phoneNumber': contact.getPhoneNumber()
    };

    if(contact.getServerId() != null){
      parameters['id'] = contact.getServerId().toString();
    }
    response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    return response;
  }
  
  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'comments': comments,
      'email': email,
      'phoneNumber': phoneNumber,
      'fullName': fullName
    };
  }

   static allStatus(){
    return [
      'Todos', ContactCebreterra.statusAprovatedANDShow, ContactCebreterra.statusPending, ContactCebreterra.statusCheck
    ];
  }
}