package com.shop.controller;


import com.shop.entity.Goods;
import com.shop.entity.User;
import com.shop.entity.searchShop;
import com.shop.service.GoodsService;
import com.shop.service.ShopService;
import com.shop.service.UserService;
import com.shop.utils.DateJsonProcessor;
import com.shop.utils.FileUtil;
import com.shop.utils.Page;
import com.shop.utils.PageEvaluation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.SuffixFileFilter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.Timestamp;
import java.util.List;

@Controller

public class Shop {
	@Resource
	ShopService shopService;
	@Resource
	UserService userService;
	@Resource
	GoodsService goodsService;


	// 设置 最热、最新、二手是否显示


	@RequestMapping("/shop/modifyIsShow.do")
	public void setIsShow(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		PrintWriter out = response.getWriter();
		String setType = request.getParameter("setType");
		System.out.println("pppppppppppppp+++++++" + setType);
		int shopId = Integer.parseInt(request.getParameter("shopId"));
		int isShow = Integer.parseInt(request.getParameter("isShow"));
		if ("hot".equals(setType)) {
			if (shopService.isShowHot(isShow, shopId) == 1) {
				out.print("ok");

				return;
			}
		}
		if ("new".equals(setType)) {
			if (shopService.isShowNew(isShow, shopId) == 1) {
				out.print("ok");
				return;
			}
		}
		if ("second".equals(setType)) {
			if (shopService.isShowSecond(isShow, shopId) == 1) {
				out.print("ok");
				return;
			}
		}
		out.print("no");
	}
	// 根据商店名称和开店的时间分页搜索

	@RequestMapping("/search_shops_shops/searchAllShopsByName.do")
	public String searchShopsByNameAndTime(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();


		String shopBuyType = request.getParameter("shopBuyType");
		System.out.println("__________" + shopBuyType);
		int isSore = Integer.parseInt(request.getParameter("isSore"));
		String name = request.getParameter("name");
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");


		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}


		JsonConfig config = new JsonConfig();
		config.registerJsonValueProcessor(Timestamp.class, new DateJsonProcessor());
//		config.registerJsonValueProcessor(Date.class, new DateJsonProcessor());
		config.setJsonPropertyFilter(new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if (name.equals("user") || name.equals("shopAnnouces")
						|| name.equals("lastNewses") || name.equals("goodses")) {
					return true;
				} else {
					return false;
				}
			}

		});

		int totalRecords = 0;
		List<searchShop> shops = null;
		int everyPageRecords = 5;// 设置每页显示5条记录

		PageEvaluation page = null;
		if (shopBuyType != null && !("".equals(shopBuyType))) {

			totalRecords = shopService.getAllShopsCountByShopBuyType(shopBuyType);
			page = new PageEvaluation(totalRecords,
					everyPageRecords, currentPage);// 调用有三个参数的构造方法

			shops = shopService.getAllShopObjectbyShopBuyType((currentPage - 1) * everyPageRecords, page.getEveryPageRecord(), shopBuyType);


		} else {


			totalRecords = shopService.getAllShopsCount(name, isSore,
					beginDate, endDate);
			page = new PageEvaluation(totalRecords,
					everyPageRecords, currentPage);// 调用有三个参数的构造方法

			shops = shopService.getAllShopObject((currentPage - 1) * everyPageRecords, page.getEveryPageRecord(), name, isSore, beginDate, endDate);

		}
		for (int i = 0; i < shops.size(); i++) {
			Object o = shops.get(i);
			System.out.println("+++" + o.toString());
		}
		JSONObject pageJson = JSONObject.fromObject(page);
		//	JSONArray usersTelephotoJson = JSONArray.fromObject(usersTelephoto,config);
		// JsonConfig config = new JsonConfig();
		JSONArray ShopsJson = JSONArray.fromObject(shops, config);
		JSONObject o = new JSONObject();
		o.accumulate("p", pageJson);
		System.out.println(pageJson);
		o.accumulate("shopsJson", ShopsJson);
		System.out.println();
		System.out.println(ShopsJson);
		//o.accumulate("usersTelephotoJson", usersTelephotoJson);


		System.out.println(o);

		out.println(o);
		out.flush();
		out.close();
		return null;

	}
//
	// 设置其他商品的文本

	@RequestMapping("/shop/setOtherText.do")
	public String setOtherText(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String otherText = request.getParameter("otherText");
		int shopId = Integer.parseInt(request.getParameter("shopId"));

		if (shopService.setOtherText(shopId, otherText)) {
			out.print("ok");
			return null;
		}
		out.print("no");
		return null;

	}

	//
	// 增加logo
	@RequestMapping("/fileupload/addLogo.do")
	public String addLogo(@RequestParam("localfile") MultipartFile ff, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String userName = request.getParameter("userName");
		int shopId = Integer.parseInt(request.getParameter("shopId"));


//		Part ff = request.getPart("localfile");
		if (ff.isEmpty()) {
			out.print("empty");
			return null;
		}

		// File fileNew=new File(request.getRealPath("/")+"imgs\\");//创建存储用户文件夹
		String filePath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName + "\\";// 创建存储用户文件夹
		File fileNew = new File(request.getRealPath("/") + "images\\Shoper\\"
				+ userName);// 创建存储用户文件夹
		System.out.println("文件夹" + fileNew.exists());
		if (!fileNew.exists()) {
			fileNew.mkdirs();
		}
//		FileUtil fileUtil = new FileUtil();
//		FileUtil fileUtil = new FileUtil();


		if (FileUtils.sizeOfDirectory(fileNew) > 2621440) {// 假如图片大于 2.5M
			out.print("out");// 你存在空间已经超过2.5M,请删除一些商品
			return null;
		}

		String fileAbsoulutPath = null;// 文件整个路径
		try {
			InputStream is = ff.getInputStream();

			String fileName = ff.getOriginalFilename();// 取到文件名
			// 重命名文件名

			String rollingGoodsname = System.currentTimeMillis()
					+ fileName.substring(fileName.lastIndexOf("."), fileName
					.length());
			fileAbsoulutPath = filePath + rollingGoodsname;
			System.out.println("1021021" + fileAbsoulutPath);
			File file = new File(fileAbsoulutPath); // 指定文件存储的路径和文件名
			String[] filter = {".jpg", ".JPG", ".gif", ".GIF"};
			SuffixFileFilter sff = new SuffixFileFilter(filter);

			if (!sff.accept(file)) {
				// message = "不可以上传.exe和.bat文件";
				out.print("g");
				return null;

			}


			// 到时时候设置文件大小
			if (ff.getSize() > 1024 * 100) {//20M*1024
				// *20

				out.print("size");
				return null;
			}

			OutputStream os = new FileOutputStream(file);

			byte[] b = new byte[1024];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.close();
			is.close();
			// DwindlePic dwindlePic=new DwindlePic();
			// dwindlePic.s_pic(filePath, filePath, ff.getFileName(),
			// 1+ff.getFileName(), 300, 300, false);


			if (shopService.addLogo("images/Shoper/" + userName + "/" + rollingGoodsname, shopId) == 1) {

				out.print("getId" + "|" + rollingGoodsname);

				return null;
			} else {
				out.print("noUpdate");
				return null;

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		out.print("noUpdate");
		return null;
	}

	// 更加Id查找用户商店
	@RequestMapping("/shop/shopModify/logo_banner/shopDetail.do")
	public String byIdFindUserShop(HttpServletRequest request, HttpServletResponse response) {
		String jspType = request.getParameter("jspType");
		int shopId = Integer.parseInt(request.getParameter("shopId"));
		com.shop.entity.Shop shop = shopService.shop(shopId);
		Integer userId = shop.getUserId();
		User userById = userService.getUserById(userId);
		shop.setUser(userById);

		request.setAttribute("shop", shop);
		if ("logo".equals(jspType)) {
			return "shop/shopModify/logo_banner/modify_logo";
		}
		if ("banner".equals(jspType)) {
			return "shop/shopModify/logo_banner/modify_banner";
		}
		return "system/error";
	}

	// 修改logo

	@RequestMapping("/shop/uploadFileModifyLogo.do")
	public void uploadFileModifyLogo(@RequestParam("localfile") MultipartFile ff, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String userName = request.getParameter("userName");
		int shopId = Integer.parseInt(request.getParameter("shopId"));
//		System.out.println("ll");
//		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
//		MultipartFile ff = multipartRequest.getFile("localfile");

//		Part ff = request.getPart("localfile");
//		System.out.println("mingz"+ff);


//		UpFormForm upFormForm = (UpFormForm) form;
//		FormFile ff = upFormForm.getLocalfile();
//		System.out.println(ff.getOriginalFilename());
//		System.out.println(ff.isEmpty());

		if (ff.isEmpty()) {
			out.print("empty");
			return;
		}

		// File fileNew=new File(request.getRealPath("/")+"imgs\\");//创建存储用户文件夹
		String filePath = request.getRealPath("/") + "images\\Shoper\\" + userName + "\\";// 创建存储用户文件夹
		System.out.println(filePath);
		File fileNew = new File(request.getRealPath("/") + "images\\Shoper\\" + userName);// 创建存储用户文件夹
//		System.out.println("文件夹"+fileNew.exists());
		if (!fileNew.exists()) {
			fileNew.mkdirs();
		}
//		File fileNew = new File("D:\\ssm整合项目\\crm-project\\shop-maven\\web\\images\\Shoper\\"+ userName);// 创建存储用户文件夹
		System.out.println("PPPP" + fileNew);
		System.out.println(fileNew);
//		FileUtil fileUtil = new FileUtil();
		com.shop.utils.FileUtil fileUtil = new com.shop.utils.FileUtil();

		if (FileUtils.sizeOfDirectory(fileNew) > 2621440) {// 假如图片大于 2.5M
			out.print("out");// 你存在空间已经超过2.5M,请删除一些商品
			return;
		}
//		System.out.println("------");
		String fileAbsoulutPath = null;// 文件整个路径
		try {
			InputStream is = ff.getInputStream();
			String fileName = ff.getOriginalFilename();// 取到文件名
			System.out.println(fileName);
			// 重命名文件名
			String rollingGoodsname = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."), fileName.length());
			fileAbsoulutPath = filePath + rollingGoodsname;
			System.out.println("PPPPPPPPP" + fileAbsoulutPath);
			File file = new File(fileAbsoulutPath); // 指定文件存储的路径和文件名
			String[] filter = {".jpg", ".JPG", ".gif", ".GIF"};
			SuffixFileFilter sff = new SuffixFileFilter(filter);
			System.out.println("--1212");
			if (!sff.accept(file)) {
				// message = "不可以上传.exe和.bat文件";
				out.print("g");
				return;

			}
			// 到时时候设置文件大小

//			System.out.println("文件大小"+ff.getSize());
			if (ff.getSize() > 1024 * 100) {//20M*1024
				// *20
//				System.out.println("sssss");
				out.print("size");
				return;
			}
			OutputStream os = new FileOutputStream(file);
			byte[] b = new byte[1024];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.close();
			is.close();
			if (shopService.addLogo("images/Shoper/" + userName + "/" + rollingGoodsname, shopId) == 1) {
				fileUtil.deleteFile(request.getRealPath("/") + request.getParameter("logoUrl"));
				out.print("getId" + "|" + rollingGoodsname);
				return;
			} else {
				out.print("noUpdate");
				return;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		out.print("noUpdate");
	}

	// 增加banner
	@RequestMapping("/fileupload/addbanner.do")
	public String addbanner(@RequestParam("localfile") MultipartFile ff, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String userName = request.getParameter("userName");
		int shopId = Integer.parseInt(request.getParameter("shopId"));
//		Part ff = request.getPart("localfile");


//		UpFormForm upFormForm = (UpFormForm) form;
//
//		FormFile ff = upFormForm.getLocalfile();
		if (ff.isEmpty()) {
			out.print("empty");
			return null;
		}

		// File fileNew=new File(request.getRealPath("/")+"imgs\\");//创建存储用户文件夹
		String filePath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName + "\\";// 创建存储用户文件夹
		File fileNew = new File(request.getRealPath("/") + "images\\Shoper\\"
				+ userName);// 创建存储用户文件夹
		if (!fileNew.exists()) {
			fileNew.mkdirs();
		}
		com.shop.utils.FileUtil fileUtil = new com.shop.utils.FileUtil();

//		FileUtil fileUtil = new FileUtil();

		if (FileUtils.sizeOfDirectory(fileNew) > 2621440) {// 假如图片大于 2.5M
			out.print("out");// 你存在空间已经超过2.5M,请删除一些商品
			return null;
		}

		String fileAbsoulutPath = null;// 文件整个路径
		try {
			InputStream is = ff.getInputStream();
			String fileName = ff.getOriginalFilename();

//			String fileName = ff.getName();// 取到文件名
			// 重命名文件名

			String rollingGoodsname = System.currentTimeMillis()
					+ fileName.substring(fileName.lastIndexOf("."), fileName
					.length());
			fileAbsoulutPath = filePath + rollingGoodsname;
			File file = new File(fileAbsoulutPath); // 指定文件存储的路径和文件名
			String[] filter = {".jpg", ".JPG", ".gif", ".GIF"};
			SuffixFileFilter sff = new SuffixFileFilter(filter);

			if (!sff.accept(file)) {
				// message = "不可以上传.exe和.bat文件";
				out.print("g");
				return null;

			}


			// 到时时候设置文件大小
			if (ff.getSize() > 1024 * 200) {//20M*1024
				// *20

				out.print("size");
				return null;
			}

			OutputStream os = new FileOutputStream(file);

			byte[] b = new byte[1024];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.close();
			is.close();

			if (shopService.addBanner("images/Shoper/" + userName + "/" + rollingGoodsname, shopId) == 1) {

				//out.print("getId" + "|" + rollingGoodsname);
				out.print("yes");
				return null;
			} else {
				out.print("noUpdate");
				return null;

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		out.print("noUpdate");
		return null;
	}

	// 修改banner
	@RequestMapping("/shop/uploadFileModifyBnnaer.do")
	public String modifybanner(@RequestParam("localfile") MultipartFile ff, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String userName = request.getParameter("userName");
		int shopId = Integer.parseInt(request.getParameter("shopId"));
//		Part ff = request.getPart("localfile");

//		UpFormForm upFormForm = (UpFormForm) form;
//
//		FormFile ff = upFormForm.getLocalfile();
		if (ff.isEmpty()) {
			out.print("empty");
			return null;
		}

		// File fileNew=new File(request.getRealPath("/")+"imgs\\");//创建存储用户文件夹
		String filePath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName + "\\";// 创建存储用户文件夹
		File fileNew = new File(request.getRealPath("/") + "images\\Shoper\\"
				+ userName);// 创建存储用户文件夹
		if (!fileNew.exists()) {
			fileNew.mkdirs();
		}
		com.shop.utils.FileUtil fileUtil = new com.shop.utils.FileUtil();

		if (FileUtils.sizeOfDirectory(fileNew) > 2621440) {// 假如图片大于 2.5M
			out.print("out");// 你存在空间已经超过2.5M,请删除一些商品
			return null;
		}

		String fileAbsoulutPath = null;// 文件整个路径
		try {
			InputStream is = ff.getInputStream();

			String fileName = ff.getOriginalFilename();// 取到文件名
			// 重命名文件名

			String rollingGoodsname = System.currentTimeMillis()
					+ fileName.substring(fileName.lastIndexOf("."), fileName
					.length());
			fileAbsoulutPath = filePath + rollingGoodsname;
			File file = new File(fileAbsoulutPath); // 指定文件存储的路径和文件名
			String[] filter = {".jpg", ".JPG", ".gif", ".GIF"};
			SuffixFileFilter sff = new SuffixFileFilter(filter);

			if (!sff.accept(file)) {
				// message = "不可以上传.exe和.bat文件";
				out.print("g");
				return null;

			}


			// 到时时候设置文件大小
			if (ff.getSize() > 1024 * 200) {//20M*1024
				// *20

				out.print("size");
				return null;
			}

			OutputStream os = new FileOutputStream(file);

			byte[] b = new byte[1024];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.close();
			is.close();
			// DwindlePic dwindlePic=new DwindlePic();
			// dwindlePic.s_pic(filePath, filePath, ff.getFileName(),
			// 1+ff.getFileName(), 300, 300, false);

			if (shopService.addBanner("images/Shoper/" + userName + "/" + rollingGoodsname, shopId) == 1) {
				System.out.println(request.getRealPath("/") + request.getParameter("bannerUrl"));
				fileUtil.deleteFile(request.getRealPath("/") + request.getParameter("bannerUrl"));
				//out.print("getId" + "|" + rollingGoodsname);
				out.print("yes");
				return null;
			} else {
				out.print("noUpdate");
				return null;

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		out.print("noUpdate");
		return null;
	}

	// 查询所有的滚动广告
	@RequestMapping("/shop/selectRollingGoods.do")
	public String getRollingsGoods(HttpServletRequest request, HttpServletResponse response) {
		String type = request.getParameter("typeJsp");
		User user = (User) request.getSession().getAttribute("user");

		if ("selecRollingGoods".equals(type)) {
			System.out.println("ppppp" + user.getShop().getId());
			List<com.shop.entity.Goods> rollingsGoods = shopService.getRollings(user.getShop().getId(), 0);
			User userNew = userService.getUserById(user.getId());
			request.setAttribute("userNew", userNew);
			request.setAttribute("count", rollingsGoods.size());
			request.setAttribute("rollingsGoods", rollingsGoods);
			return "shop/shopModify/productModify/selectBannerList";
		}
		if ("selecHotGoods".equals(type)) {
			List<com.shop.entity.Goods> hotGoods = shopService.getRollings(user.getShop().getId(), 1);
			User userNew = userService.getUserById(user.getId());
			request.setAttribute("userNew", userNew);
			request.setAttribute("count", hotGoods.size());
			request.setAttribute("hotGoods", hotGoods);
			return "shop/shopModify/productModify/selectHot";
		}
		if ("selecNewGoods".equals(type)) {
			List<com.shop.entity.Goods> newGoods = shopService.getRollings(user.getShop()
					.getId(), 2);
			User userNew = userService.getUserById(user.getId());
			request.setAttribute("userNew", userNew);
			request.setAttribute("count", newGoods.size());
			request.setAttribute("newGoods", newGoods);

			return "shop/shopModify/productModify/selectNew";
		}
		if ("selecSecondGoods".equals(type)) {
			List<com.shop.entity.Goods> secondGoods = shopService.getRollings(user.getShop()
					.getId(), 3);
			User userNew = userService.getUserById(user.getId());
			request.setAttribute("userNew", userNew);
			request.setAttribute("count", secondGoods.size());
			request.setAttribute("secondGoods", secondGoods);

			return "shop/shopModify/productModify/selectSecond";
		}

		return "system/error";
	}

	//	// 0增加滚动图片 //1增加最热产品 //2添加最新//3添加二手//4添加其他
	@RequestMapping("/shop/user/addPicture.do")
	public String addRollingGoods(@RequestParam("localfile") MultipartFile ff, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		int goodsType = Integer.parseInt(request.getParameter("goodsType"));

		int goodsIsNew = 0;
		if (request.getParameter("goodsIsNew") == null) {

			goodsIsNew = 1;// 0为滚动条
		} else {
			goodsIsNew = 2;// 1 全新 2为二手
		}

		String userName = request.getParameter("userName");
		int shopId = Integer.parseInt(request.getParameter("shopId"));

//		UpFormForm upFormForm = (UpFormForm) form;
//
//		FormFile ff = upFormForm.getLocalfile();
		if (ff.isEmpty()) {
			out.print("empty");
			return null;
		}


		String filePath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName + "\\";// 创建存储用户文件夹
		File fileNew = new File(request.getRealPath("/") + "images\\Shoper\\"
				+ userName);// 创建存储用户文件夹
		if (!fileNew.exists()) {
			fileNew.mkdirs();
		}
		com.shop.utils.FileUtil fileUtil = new FileUtil();

		if (FileUtils.sizeOfDirectory(fileNew) > 2621440) {// 假如图片大于 2.5M
			out.print("out");// 你存在空间已经超过2.5M,请删除一些商品
			return null;
		}

		String fileAbsoulutPath = null;// 文件整个路径
		try {
			InputStream is = ff.getInputStream();

			String fileName = ff.getOriginalFilename();// 取到文件名
			// 重命名文件名

			String rollingGoodsname = System.currentTimeMillis()
					+ fileName.substring(fileName.lastIndexOf("."), fileName
					.length());
			fileAbsoulutPath = filePath + rollingGoodsname;
			File file = new File(fileAbsoulutPath); // 指定文件存储的路径和文件名
			String[] filter = {".jpg", ".JPG", ".gif", ".GIF"};
			SuffixFileFilter sff = new SuffixFileFilter(filter);

			if (!sff.accept(file)) {
				// message = "不可以上传.exe和.bat文件";
				out.print("g");
				return null;

			}


			// 到时时候设置文件大小
			String isRolling = request.getParameter("isRolling");
			if (isRolling != null) {
				if (ff.getSize() > 1024 * 200) {//20M
					// *
					// 1024
					// *20

					out.print("size");
					return null;
				}
			} else {
				if (ff.getSize() > 1024 * 200) {//20M
					// *
					// 1024
					// *20

					out.print("size");
					return null;
				}
			}


			OutputStream os = new FileOutputStream(file);

			byte[] b = new byte[1024];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.close();
			is.close();
			com.shop.entity.Goods goods = new Goods();
			goods.setUrl("images/Shoper/"
					+ userName + "/" + rollingGoodsname);
			goods.setGoodsIsNew(goodsIsNew);
			goods.setShopId(shopId);
			goods.setGoodsType(goodsType);

//			int getId = shopService.addRollingGoods("images/Shoper/"
//					+ userName + "/" + rollingGoodsname, shopId, goodsType,
//					goodsIsNew);
			shopService.addRollingGoods(goods);
			int getId = goods.getId();
			System.out.println("+++" + getId);
			if (isRolling != null) {
				out.print("yes");
				return null;
			}
			if (getId > 0) {

				out.print(getId + "|" + rollingGoodsname);

				return null;
			} else {
				out.print("noUpdate");
				return null;

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		out.print("noUpdate");
		return null;

	}

	// 修改滚动图片
	@RequestMapping("/shop/modifyHotGoods.do")
	public String modifyRollingGoods(@RequestParam("localfile") MultipartFile ff, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
		String userName = request.getParameter("userName");
		File fileNew = new File(request.getRealPath("/") + "images\\Shoper\\"
				+ userName);// 创建存储用户文件夹
		if (!fileNew.exists()) {
			fileNew.mkdirs();
		}
		String filePath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName + "\\";// 创建存储用户文件夹
//		FileUtil fileUtil = new FileUtil();
		PrintWriter out = response.getWriter();

//		UpFormForm upFormForm = (UpFormForm) form;

//		FormFile ff = upFormForm.getLocalfile();
		if (ff.isEmpty()) {
			out.print("no");
			return null;
		}
		com.shop.utils.FileUtil fileUtil = new com.shop.utils.FileUtil();
		if (FileUtils.sizeOfDirectory(fileNew) > 2621440) {// 假如图片大于 2.5M
			out.print("out");// 你存在空间已经超过2.5M,请删除一些商品
			return null;
		}

		String fileAbsoulutPath = null;// 文件整个路径
		try {
			InputStream is = ff.getInputStream();

			String fileName = ff.getOriginalFilename();// 取到文件名
			// 重命名文件名

			String rollingGoodsname = System.currentTimeMillis()
					+ fileName.substring(fileName.lastIndexOf("."), fileName
					.length());
			fileAbsoulutPath = filePath + rollingGoodsname;
			File file = new File(fileAbsoulutPath); // 指定文件存储的路径和文件名
			String[] filter = {".jpg", ".JPG", ".gif", ".GIF"};
			SuffixFileFilter sff = new SuffixFileFilter(filter);

			if (!sff.accept(file)) {
				// message = "不可以上传.exe和.bat文件";
				out.print("g");
				return null;

			}


			// 到时时候设置文件大小
			String isRolling = request.getParameter("isRolling");
			if (isRolling != null) {
				if (ff.getSize() > 1024 * 200) {//20M
					// *
					// 1024
					// *20

					out.print("size");
					return null;
				}
			} else {
				if (ff.getSize() > 1024 * 100) {//20M
					// *
					// 1024
					// *20

					out.print("size");
					return null;
				}
			}

			OutputStream os = new FileOutputStream(file);

			byte[] b = new byte[1024];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.close();
			is.close();

			com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);


			if (fileUtil.deleteFile(request.getRealPath("/") + goods.getUrl())) {
				int getId = shopService.modifRollingGoods("images/Shoper/"
								+ userName + "/" + rollingGoodsname,
						goodsId);
				if (isRolling != null) {
					out.print("yes");
					return null;
				}
				if (getId > 0) {
					out.print(getId + "|" + rollingGoodsname);
					return null;
				} else {
					out.print("noUpdate");
					return null;
				}

			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		out.print("noUpdate");

		return null;


	}

	// 删除滚动图片
	@RequestMapping("/shop/rollingGoods/delete.do")
	public String deleteRollingGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String deleteType = request.getParameter("deleteType");// 跳转可以用
		User user = (User) request.getSession().getAttribute("user");
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
		com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);
		Integer shopId1 = goods.getShopId();
		com.shop.entity.Shop shopById = shopService.getShopById(shopId1);
		Integer userId1 = shopById.getUserId();
		User userById = userService.getUserById(userId1);
		Integer id = userById.getId();
		if (!id.equals(user.getId())) {
			request.setAttribute("errorInfo", "非法操作！您无权删除商品！");
			return "/system/error";
		}


		String userName = request.getParameter("userName");
		int userId = Integer.parseInt(request.getParameter("userId"));
		int shopId = Integer.parseInt(request.getParameter("shopId"));

		FileUtil fileUtil = new FileUtil();
		String uploadPath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName;

//		Goods good = goodsService.getGoodsById(goodsId);

		if (fileUtil.deleteFile(request.getRealPath("/") + goods.getUrl())) {


			if ("deleteRolling".equals(deleteType)) {
				goodsService.deleteGoodsById(goodsId);
				List<com.shop.entity.Goods> rollingsGoods = shopService.getRollings(shopId, 0);
				User userNew = userService.getUserById(userId);
				request.setAttribute("userNew", userNew);
				request.setAttribute("count", rollingsGoods.size());
				request.setAttribute("rollingsGoods", rollingsGoods);
				return "/shop/shopModify/productModify/selectBannerList";
			}
			if ("deletehotgoods".equals(deleteType)) {
				goodsService.deleteGoodsById(goodsId);
				List<com.shop.entity.Goods> hotGoods = shopService.getRollings(shopId, 1);
				User userNew = userService.getUserById(userId);
				request.setAttribute("userNew", userNew);
				request.setAttribute("count", hotGoods.size());
				request.setAttribute("hotGoods", hotGoods);

				return "/shop/shopModify/productModify/selectHot";
			}
			if ("deleteNewgoods".equals(deleteType)) {
				goodsService.deleteGoodsById(goodsId);
				List<com.shop.entity.Goods> newGoods = shopService.getRollings(shopId, 2);
				User userNew = userService.getUserById(userId);
				request.setAttribute("userNew", userNew);
				request.setAttribute("count", newGoods.size());
				request.setAttribute("newGoods", newGoods);

				return "/shop/shopModify/productModify/selectNew";
			}
			if ("deleteSecondgoods".equals(deleteType)) {
				goodsService.deleteGoodsById(goodsId);
				List<com.shop.entity.Goods> secondGoods = shopService.getRollings(shopId, 3);
				User userNew = userService.getUserById(userId);
				request.setAttribute("userNew", userNew);
				request.setAttribute("count", secondGoods.size());
				request.setAttribute("secondGoods", secondGoods);

				return "/shop/shopModify/productModify/selectSecond";
			}

		}

		return "/system/error";
	}

	//
//	// 删除其他图片
	@RequestMapping("/shop/otherGoods/delete.do")
	public String deleteOtherGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {

		User user = (User) request.getSession().getAttribute("user");
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
		com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);
		Integer shopId1 = goods.getShopId();
		com.shop.entity.Shop shopById = shopService.getShopById(shopId1);
		Integer userId1 = shopById.getUserId();
		if (!userId1.equals(user.getId())) {
			request.setAttribute("errorInfo", "非法操作！您无权删除商品！");
			return "system/error";
		}


		//int goodsId = Integer.parseInt(request.getParameter("goodsId"));

		String userName = request.getParameter("userName");
		int userId = Integer.parseInt(request.getParameter("userId"));
		int shopId = Integer.parseInt(request.getParameter("shopId"));

		FileUtil fileUtil = new FileUtil();
		String uploadPath = request.getRealPath("/") + "images\\Shoper\\"
				+ userName;

		//Goods goods = goodsService.getGoodsById(goodsId);

		if (fileUtil.deleteFile(request.getRealPath("/") + goods.getUrl())) {


			goodsService.deleteGoodsById(goodsId);

			int goodsType = 0;
			if (request.getParameter("goodsType") == null) {
				goodsType = 4;
			} else {
				goodsType = Integer.parseInt(request.getParameter("goodsType"));

			}
			String name = request.getParameter("name");
			//User user = (User) request.getSession().getAttribute("user");
			int currentPage = 1;
			if (request.getParameter("currentpage") != null) {
				currentPage = Integer.parseInt(request
						.getParameter("currentpage"));
			}
			int totalRecords = goodsService.count(goodsType, name, userId);// 得到总的记录数
			int everyPageRecords = 5;// 设置每页显示5条记录
			Page page = new Page(totalRecords, everyPageRecords, currentPage);// 调用有三个参数的构造方法
			List<com.shop.entity.Goods> goodses = goodsService.goodses(page
							.getBeginIndexRecord(), page.getEveryPageRecords(),
					goodsType, name, userId);
			request.setAttribute("goodses", goodses);
			request.setAttribute("goodsType", goodsType);
			request.setAttribute("page", page);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("name", name);
			return "/shop/shopModify/otherProduct/selectOtherGoods";
		}

		return "system/error";
	}


}
