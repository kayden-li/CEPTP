package cn.edu.tit.user.utils;

public class WDWUtil {

	// @描述：是否是2003的excel，返回true是2003 
    public static boolean isExcel2003(String fileName)  {  
         return fileName.matches("^.+\\.(?i)(xls)$");  
     }  
   
    //@描述：是否是2007的excel，返回true是2007 
    public static boolean isExcel2007(String fileName)  {  
         return fileName.matches("^.+\\.(?i)(xlsx)$");  
     }  
}
