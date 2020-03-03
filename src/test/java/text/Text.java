package text;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.tit.course.Idao.ICourseDao;
import cn.edu.tit.course.Iservice.ICourseService;
import cn.edu.tit.course.Iservice.serviceImp.CourseSerivceImp;
import cn.edu.tit.course.bean.Accessory;
import cn.edu.tit.course.bean.Course;
import cn.edu.tit.course.bean.Depart;
import cn.edu.tit.course.bean.Task;
import cn.edu.tit.pager.PagerBean;
import cn.edu.tit.user.Iservice.IUserService;
import cn.edu.tit.user.bean.User;


@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) 
public class Text {
	private static Logger logger = Logger.getLogger(Text.class);  
//  private ApplicationContext ac = null;  


   
	@Resource
	private IUserService userS;
    @Resource
    private ICourseService courseSerivce;
    @Resource
    private ICourseDao courseDao;
  
//  @Before  
//  public void before() {  
//      ac = new ClassPathXmlApplicationContext("applicationContext.xml");  
//      userService = (IUserService) ac.getBean("userService");  
//  }  
  
  
    public void textaddCourse(){
//    	byte[] cimg = new byte[2];
//    	cimg[0] = 21;
//    	cimg[1]=20;
//    	Course c = new Course("152056138_372388382828", "java", "编程", cimg, "编程", "tit", "software", 1, "147369", false, "152056138", new Date(), "152056138", new Date());
//    	courseSerivce.createCourse(c);
    	Task t = new Task("1","1520561", "xx", "1520561");
    	
    	Accessory ac =new Accessory("wenjian", "1", "c://", 2, "xx", "xx");
    	List<Accessory> al = new ArrayList<>();
    	al.add(ac);
    	t.setPubAccs(al);
    	courseSerivce.uploadTask(t);
    	
    }
    
    public void findCourse(){
//    	List<Course> cl = new ArrayList<>();
//    	cl = courseDao.findCouByAppro("software");
//    	for(Course c : cl){
//    		System.out.println(c.getCourse_id());
//    	}

    	List<Course> c = courseDao.findallCourse();
    	for(Course a: c){
    		System.out.println(a.getCourse_name());
    	}
		System.out.println();
    }
    
    
    public void findCourseByDe() {
    	List<Course> courses = courseDao.findCoursebyDe(5);
    	for (Course course : courses) {
			System.out.println(course.getCourse_name());
		}
    }
    
    public void getimg() {
    	System.out.println(courseDao.getImgById("011002_1524801900220"));
    }
    
    @Test
    public void upTask() {
    	Task task = new Task("011002_15248001888901524822878107", "1520561", "sssss", "011002");
    	courseDao.updateUpTask(task);
    	
    }
}
