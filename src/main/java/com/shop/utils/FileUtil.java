package com.shop.utils;


import java.io.File;
import java.io.FileInputStream;
import java.io.Serializable;
import java.text.DecimalFormat;

public class FileUtil implements Serializable {
    //假如文件不存在，则新建
    public void newFile(String path, String fileName) {
        File file = new File(path, fileName);
        if (!file.exists()) {
            file.mkdir();//创建一个目录
        }
    }

    //得到文件的大小
    public long getFileSizes(File f) throws Exception {//取得文件大小
        long s = 0;
        if (f.exists()) {
            FileInputStream fis = null;
            fis = new FileInputStream(f);
            s = fis.available();
        } else {
            f.createNewFile();
            System.out.println("文件不存在");
        }
        return s;
    }

    // 递归
    public long getFileSize(File f) throws Exception//取得文件夹大小   单位是 k 要转为 M 必须除以 1024*1024
    {
        long size = 0;
        File flist[] = f.listFiles();
        System.out.println("PPPPP===" + flist.length);
        for (int i = 0; i < flist.length; i++) {
            if (flist[i].isDirectory()) {
                size = size + getFileSize(flist[i]);
            } else {
                size = size + flist[i].length();
            }
        }
        return size;
    }

    public String FormetFileSize(long fileS) {//转换文件大小
        DecimalFormat df = new DecimalFormat("#.00");
        String fileSizeString = "";
        if (fileS < 1024) {
            fileSizeString = df.format((double) fileS) + "B";
        } else if (fileS < 1048576) {
            fileSizeString = df.format((double) fileS / 1024) + "K";
        } else if (fileS < 1073741824) {
            fileSizeString = df.format((double) fileS / 1048576) + "M";
        } else {
            fileSizeString = df.format((double) fileS / 1073741824) + "G";
        }
        return fileSizeString;
    }

    public long getlist(File f) {//递归求取目录文件个数
        long size = 0;
        File flist[] = f.listFiles();
        size = flist.length;
        for (int i = 0; i < flist.length; i++) {
            if (flist[i].isDirectory()) {
                size = size + getlist(flist[i]);
                size--;
            }
        }
        return size;

    }

    public boolean deleteFile(String filePath) {
        boolean isDele = false;
        File file = new File(filePath);

        if (!file.exists()) {
            return false;
        } else {
            if (!file.isDirectory()) {
                file.delete();
                return true;
            }
            return false;
        }
    }
//     //一下是个测试类
//		public static void main(String args[])
//		{
//		GetFileSize g = new GetFileSize();
//		long startTime = System.currentTimeMillis();
//		try
//		{
//		long l = 0;
//		String path = "D:\\lsbgzml\\cjmqy项目\\cjmqyshop\\WebRoot\\images\\Shoper";
//		File ff = new File(path);
//		if (ff.isDirectory()) { //如果路径是文件夹的时候
//		System.out.println("文件个数 " + g.getlist(ff));
//		System.out.println("目录");
//		l = g.getFileSize(ff);
//		System.out.println("为"+l+"k");
//		System.out.println(path + "目录的大小为：" + g.FormetFileSize(l));
//		} else {
//		System.out.println(" 文件个数 1");
//		System.out.println("文件");
//		l = g.getFileSizes(ff);
//		System.out.println("为"+l+"k");
//		System.out.println(path + "文件的大小为：" + g.FormetFileSize(l));
//		}
//
//		} catch (Exception e)
//		{
//		e.printStackTrace();
//		}
//		long endTime = System.currentTimeMillis();
//		System.out.println("总共花费时间为：" + (endTime - startTime) + "毫秒...");
//		}
//		public boolean deleteFile(String filePath){
//			boolean isDele=false;
//			File file=new File(filePath);
//
//			if(!file.exists()){
//				return false;
//			}
//			else{
//				if(!file.isDirectory()){
//					file.delete();
//					return true;
//				}
//				return false;
//			}
//		}
}
