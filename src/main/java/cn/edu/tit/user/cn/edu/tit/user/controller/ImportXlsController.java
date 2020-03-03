package cn.edu.tit.user.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.tit.user.Iservice.IUserService;
import cn.edu.tit.user.utils.ReadExcel;

@Controller
@RequestMapping("/input")
@Scope("prototype")
public class ImportXlsController {

	@Autowired
	private IUserService userService;

	@RequestMapping(value = "/ImportXls")
	public ModelAndView ImporXls(@RequestParam(value = "filename") MultipartFile file, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws FileNotFoundException, IOException, ServletException {

		// 判断文件是否为空
		/*
		 * if (file == null) {System.out.println("文件为空");}
		 */
		// 获取文件名
		String fileName = file.getOriginalFilename();// 教师文件名
		// 进一步判断文件是否为空（即判断其大小是否为0或其名称是否为null）
		long size = file.getSize();// 教师文件名长度
		// 1.通过对文件名进行文件存在的判断
		// 2.可以同时导入两个文件，也可以只导入一个
		// 3.没有选着文件时，系统报错，文件名为空
		/*
		 * User user1 = (User)session.getAttribute("user"); String
		 * user_id=user1.getUser_id();
		 */
		String user_id = "123";
		if (fileName == null || ("").equals(fileName) && size == 0) {
			System.out.println("文件名为空");
		} else {
			infouser(fileName, file, user_id);
		}
		// 转换到新页面
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsp/user/initialise");
		return mav;
	}

	/**
	 * 信息导入调用的方法 调用工具类
	 * 
	 * @param fileName
	 * @param file
	 */
	public void infouser(String fileName, MultipartFile file, String user_id) {
		String errorInfo = null;
		// 批量导入。参数：文件,文件名。
		List<Integer> list = null;
		try {
			// 创建处理EXCEL
			ReadExcel readExcel = new ReadExcel();
			// 解析excel，获取信息集合。
			Workbook wb = readExcel.getWorkbook(fileName, (MultipartFile) file);
			errorInfo = readExcel.getErrorInfo();
			try {
				list = userService.importInfo(wb, fileName, user_id);
				for (Integer integer : list) {
					System.out.println(integer);
				}
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("导入失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(errorInfo);
	}

	/**
	 * 导出
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/export")
	public ResponseEntity<byte[]> exportTeacher(HttpServletRequest request) throws IOException {
		File file = userService.exportUser();
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFilelName = new String(file.getName().getBytes("UTF-8"), "iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFilelName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}
}
