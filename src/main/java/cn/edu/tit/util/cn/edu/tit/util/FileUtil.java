package cn.edu.tit.util;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Repository;

import cn.edu.tit.course.bean.Accessory;
@Repository
public class FileUtil {

	/**
	 * 上传附件
	 * @param request
	 * @param username
	 * 用户名，用于创建附件名
	 */
	public List<Accessory> uploadAccessory(HttpServletRequest request,String username){
		List<Accessory> accList = new ArrayList<>();
		try {  
			//获取存储路径
//			InputStream in = ClassLoader.getSystemResourceAsStream("page.properties");
//			Properties properties = new Properties();
//			properties.load(in);
//			String path = properties.getProperty("path");
			String path = "D:\\accessory\\";
            // Create a factory for disk-based file items  
            DiskFileItemFactory factory = new DiskFileItemFactory();  
            // Create a new file upload handler  
            ServletFileUpload upload = new ServletFileUpload(factory);  
            // Set overall request size constraint  
            upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB  
  
            List<FileItem> items = upload.parseRequest(request);// 得到所有的文件  
            Map<String, Object> formdata = new HashMap<String, Object>();
            for (FileItem fi:items) {
            	Accessory acc = new Accessory();
            	if(!fi.isFormField()){
            		 String fileName = fi.getName();  
                     if (fileName != null) {  
                         File fullFile = new File(new String(fi.getName().getBytes(), "utf-8")); // 解决文件名乱码问题  
                         File savedFile = new File(path, username+"_"+fullFile.getName());  
                         fi.write(savedFile);  
                         acc.setAccessory_name(username+"_"+fullFile.getName());
                         acc.setAccessory_kind(1);
                         acc.setAccessory_path(path);
                         accList.add(acc);
                     }  
            	}
            	else{
            		formdata.put(fi.getFieldName(), fi.getString("UTF-8"));
            	}
            }  
//            System.out.print("upload succeed");  
        } catch (Exception e) {  
        	e.getMessage();
        }  
		return accList;
    }  
}
