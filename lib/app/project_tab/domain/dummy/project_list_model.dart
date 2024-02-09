class ProjectListModel {
  int? id;
  String? projectImg;
  String? projectName;
  String? projectDate;
  String? technologies;
  String? process;
  String? status;
  String? taskCount;
  List<String>? profilePic;
  int? allTaskCount;
  int? closeTaskCount;

  ProjectListModel(
      {this.projectImg,
        this.id,
      this.projectName,
      this.projectDate,
      this.technologies,
      this.process,
      this.status,
      this.taskCount,
      this.profilePic,
      this.allTaskCount,
      this.closeTaskCount,
      });

  static List projectList = [
    ProjectListModel(
      projectName: "OMS",
      projectDate: "31 Jan 2023",
      // technologies:[ "UI/UX",],
      process: "80",
      status: "On hold",
      taskCount: "10"
    )
  ];
}
