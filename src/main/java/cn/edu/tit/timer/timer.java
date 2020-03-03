package cn.edu.tit.timer;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import cn.edu.tit.course.Iservice.ICourseService;
import cn.edu.tit.course.bean.Course;
import cn.edu.tit.course.bean.Task;

@Component
public class timer {
	@Autowired
	private ICourseService courseService;

	@Scheduled(cron = "10 * * ? * 6L")
	public void ChangeCourseStatus() {
		List<Course> all = new ArrayList<>();
		all = courseService.findallCourse();
		for (Course course : all) {
			List<Task> tasks = new ArrayList<>();
			tasks = courseService.getTaskBycid(course.getCourse_id());
			for (Task task : tasks) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String bt = task.getDelete_time();
				String et = sdf.format(new java.util.Date());
				if (bt.compareTo(et) < 0) {
					task.setDelete_flg(true);
					courseService.ChangeStatus(task.getTask_id(), "2", "task");
				}
			}
			tasks = courseService.getOtherBycid(course.getCourse_id());
			for (Task task : tasks) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String bt = task.getDelete_time();
				String et = sdf.format(new java.util.Date());
				if (bt.compareTo(et) < 0) {
					task.setDelete_flg(true);
					courseService.ChangeStatus(task.getTask_id(), "2", "other");
				}
			}
			tasks = courseService.getTestBycid(course.getCourse_id());
			for (Task task : tasks) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String bt = task.getDelete_time();
				String et = sdf.format(new java.util.Date());
				if (bt.compareTo(et) < 0) {
					task.setDelete_flg(true);
					courseService.ChangeStatus(task.getTask_id(), "2", "test");
				}
			}
		}
	}
}
