
class SetAddStateModel{
  int? userId;
  int? associationId;
  String? email;
  String? token;

  SetAddStateModel({this.userId,this.email,this.associationId,this.token});

  // factory SetAddStateModel.fromAuthModel({required Data? data}) {
  //
  //   return SetAddStateModel(
  //     token: data?.authToken ?? "",
  //     userId: data?.associationId,
  //     email: data?.email,
  //     associationId:data?.userId,
  //   );
  //
  // }
}