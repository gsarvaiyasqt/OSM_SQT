import 'package:osm_flutter/app/task_tab/domain/respones/base_res_model.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';

import '../../app/document/domain/request/delete_document_req_model.dart';

abstract class IDocumentUseCase{

  Future<BaseResModel> deleteDocument({required DeleteDocumentRequestModel? deleteDocumentRequestModel});

}
class DocumentUseCase extends IDocumentUseCase{
  @override
  Future<BaseResModel> deleteDocument({required DeleteDocumentRequestModel? deleteDocumentRequestModel}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.deleteDocument,data: deleteDocumentRequestModel?.toJson()));
    return BaseResModel.fromJson(response);
  }
}