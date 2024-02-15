part of base;

class AppResponse<T> {
  Status? state;
  T? data;
  String? msg;

  AppResponse();

  AppResponse.loading(this.msg) : state = Status.LOADING;

  AppResponse.completed(this.data) : state = Status.COMPLETED;

  AppResponse.error(this.msg) : state = Status.ERROR;

  AppResponse.unAuthorized(this.msg): state = Status.UNAUTHORISED;
  @override
  String toString() {
    return "Status : $state \n Message : $msg \n Data : $data";
  }
}
