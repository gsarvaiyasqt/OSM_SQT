import 'package:flutter/cupertino.dart';
import 'package:osm_flutter/app/document/repository/document_repository.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/base_res_model.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/get_list_task_data_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:provider/provider.dart';

import '../domain/request/delete_document_req_model.dart';

abstract class IDocumentProvider{

  Future documentDelete({required DeleteDocumentRequestModel? deleteDocumentRequestModel});

}
class DocumentProvider extends BaseNotifier implements IDocumentProvider{


  final IDocumentRepository documentRepository;


  late AppResponse<BaseResModel> _deleteDocumentResponse;
  AppResponse<BaseResModel> get deleteDocumentResponse => _deleteDocumentResponse;

  DocumentProvider({required this.documentRepository}){
    _deleteDocumentResponse = AppResponse();
  }



  @override
  Future documentDelete({required DeleteDocumentRequestModel? deleteDocumentRequestModel}) async{

    resIsLoading(_deleteDocumentResponse);


    try {


      final response = await documentRepository.deleteDocument(deleteDocumentRequestModel: deleteDocumentRequestModel);


      if(response.statusCode != 1){

        throw response.message ?? "";

      }else{

        resIsSuccess(_deleteDocumentResponse,response);

      }

    } catch (e) {

      resIsFailed(_deleteDocumentResponse, e);
      rethrow;
    }



  }

  Future deleteDocumentInList({BuildContext? context,int? documentId})async{

    if(context != null){

      final taskUpdateDocList = context.read<TaskProvider>();



    }


  }


}