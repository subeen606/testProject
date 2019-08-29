package util;

import java.io.File;
import java.text.DecimalFormat;

import org.apache.commons.fileupload.FileItem;

public class UtilityClass {
	
	public static String two(String str) {
		return str.length()<2?"0"+str.trim():str.trim();
	}
	
	public static String PriceConvert(int price) {
		DecimalFormat df = new DecimalFormat("###,###,###,###");
		String convert = df.format(price);
		return convert;
	}
	
	public static String processUploadFile(FileItem fileItem, String dir) {
	
		String filename = fileItem.getName();	// 경로 + 파일 명	d:\\tmp\\abc.txt	d:/tmp/abc.txt
		long sizeInBytes = fileItem.getSize();	// 
		
		
		if(sizeInBytes > 0){	// 정상파일인 경우
			int idx = filename.lastIndexOf("\\");	// 뒤에서부터 조사해서 \\가 있는 위치 조사
			if(idx == -1){	// 찾지 못했을 경우 -1이 나옴
				idx = filename.lastIndexOf("/");
			}
			
			filename = filename.substring(idx+1);	// 숫자 하나만 넣으면 그 숫자에 해당하는 번지부터 끝까지 가져옴
			
			File uploadFile = new File(dir, filename);
			
			try{
				fileItem.write(uploadFile);		// 실제 업로드 부분
			}catch(Exception e){}
		}
		
		return filename;	// 확인용. void형으로 해도 괜찮음
	}
	
	
	
}
