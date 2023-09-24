import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/customCourse/model/custom_course_model.dart';

class CustomCourseViewModel
    extends BaseViewModel<CustomCourseModel, EmptyService> {
  CustomCourseViewModel({required super.model});

  /// 初始化数据
  void initData(String courseName, String teacher, String place) {
    model.courseNameController.text = courseName;
    model.teacherController.text = teacher;
    model.placeController.text = place;
    // notifyListeners();
  }

  /// 销毁控制器
  void disposeController() {
    model.courseNameController.dispose();
    model.teacherController.dispose();
    model.placeController.dispose();
  }
}
