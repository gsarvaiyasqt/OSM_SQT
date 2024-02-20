import 'package:osm_flutter/usecases/document/document_usecases.dart';

import '../../task_tab/domain/respones/base_res_model.dart';
import '../domain/request/delete_document_req_model.dart';

abstract class IDocumentRepository{

  Future<BaseResModel> deleteDocument({required DeleteDocumentRequestModel? deleteDocumentRequestModel});

}
class DocumentRepository extends IDocumentRepository{


  final IDocumentUseCase documentUseCase;


  DocumentRepository({required this.documentUseCase});

  @override
  Future<BaseResModel> deleteDocument({required DeleteDocumentRequestModel? deleteDocumentRequestModel}) async{
    return await documentUseCase.deleteDocument(deleteDocumentRequestModel: deleteDocumentRequestModel);
  }




}
