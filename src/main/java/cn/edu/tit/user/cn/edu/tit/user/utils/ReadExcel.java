package cn.edu.tit.user.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;


public class ReadExcel {
	// 总行数
	private int totalRows = 0;
	// 总条数
	private int totalCells = 0;
	// 错误信息接收器
	private String errorMsg;

	// 获取总行数
	public int getTotalRows() {
		return totalRows;
	}

	// 获取总列数
	public int getTotalCells() {
		return totalCells;
	}

	// 获取错误信息
	public String getErrorInfo() {
		return errorMsg;
	}

	/**
	 * 验证EXCEL文件
	 * 
	 * @param fileName
	 * @return
	 */
	public boolean validateExcel(String fileName) {
		if (fileName == null || !(WDWUtil.isExcel2003(fileName) || WDWUtil.isExcel2007(fileName))) {
			errorMsg = "文件名不是excel格式";
			return false;
		}
		return true;
	}

	public Workbook getWorkbook(String fileName, MultipartFile Mfile) 
	//public Workbook getWorkbook(String fileName, File Mfile)
	{
		Workbook wb = null;
		// 把spring文件上传的MultipartFile转换成CommonsMultipartFile类型
		CommonsMultipartFile cf = (CommonsMultipartFile) Mfile; // 获取本地存储路径
		File file = new File("D:\\fileupload");
		// 创建一个目录 （它的路径名由当前 File 对象指定，包括任一必须的父路径。）
		if (!file.exists())
			file.mkdirs();
		// 新建一个文件
		File file1 = new File("D:\\fileupload\\" + new Date().getTime() + ".xls");
		// 将上传的文件写入新建的文件中
		try {
			cf.getFileItem().write(file1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 初始化输入流
		InputStream is = null;
		try {
			// 验证文件名是否合格
			if (!validateExcel(fileName)) {
				return null;
			}
			// 根据文件名判断文件是2003版本还是2007版本
			boolean isExcel2003 = true;
			if (WDWUtil.isExcel2007(fileName)) {
				isExcel2003 = false;
			}
			// 根据新建的文件实例化输入流
			is = new FileInputStream(file1);
			// 根据excel里面的内容读取信息
			wb = getWorkbook(is, isExcel2003);
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					is = null;
					e.printStackTrace();
				}
			}
		}
		return wb;
	}

	/**
	 * 根据excel里面的内容读取信息
	 * 
	 * @param is
	 *            输入流
	 * @param isExcel2003
	 *            excel是2003还是2007版本
	 * @return
	 * @throws IOException
	 */
	public Workbook getWorkbook(InputStream is, boolean isExcel2003) {
		//List<T> userList = null;
		/** 根据版本选择创建Workbook的方式 */
		Workbook wb = null;
		try {
			// 当excel是2003时
			if (isExcel2003) {
				wb = new HSSFWorkbook(is);
			} else {// 当excel是2007时
				wb = new XSSFWorkbook(is);
			}
			
			// 读取Excel里面客户的信息
			//userList = readExcelValue(wb);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return wb;
	}

	

}