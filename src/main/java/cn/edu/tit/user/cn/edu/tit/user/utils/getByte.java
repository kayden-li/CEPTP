package cn.edu.tit.user.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

public class getByte {

	/**  
     * 把一个文件转化为字节  
     * @param file  
     * @return   byte[]  
     * @throws Exception  
     */  
    public static byte[] getByte(File file) throws Exception  
    {  
        byte[] bytes = null;  
        if(file!=null)  
        {  
            InputStream is = new FileInputStream(file);  
            int length = (int) file.length();  
            if(length>Integer.MAX_VALUE)   //当文件的长度超过了int的最大值  
            {  
                System.out.println("this file is max ");  
                return null;  
            }  
            bytes = new byte[length];  
            int offset = 0;  
            int numRead = 0;  
            while(offset<bytes.length&&(numRead=is.read(bytes,offset,bytes.length-offset))>=0)  
            {  
                offset+=numRead;  
            }  
            //如果得到的字节长度和file实际的长度不一致就可能出错了  
            if(offset<bytes.length)  
            {  
                System.out.println("file length is error");  
                return null;  
            }  
            is.close();  
        }  
        return bytes;  
    }  
}
