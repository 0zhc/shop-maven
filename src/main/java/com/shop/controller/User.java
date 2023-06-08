package com.shop.controller;

import com.shop.entity.Friendlink;
import com.shop.entity.Goods;
import com.shop.entity.Shop;
import com.shop.entity.ShopAnnouce;
import com.shop.service.*;
import com.shop.utils.Page;
import com.shop.utils.PasswordEncryption;
import com.shop.utils.Regex;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class User {
    //
    @Resource
    UserService userService;
    @Resource
    GoodsService goodsService;
    @Resource
    ShopService shopService;
    @Resource
    ShopAnnouceService shopAnnouceService;
    @Resource
    CodeActiveService codeActiveService;
    @Resource
    FriendlinkService friendlinkService;


    //修改用户类型 1 为学生   2 为商家
    //根据用户Id 查找用户
    @RequestMapping("/system/shop/prompt.do")
    public String findUserById(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("Jsptype");
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        System.out.println("+++10086----" + user.getId());

//		com.shop.entity.User userNew = userService.getUserById(user.getId());
//		System.out.println("_____++++++++++++"+userNew);
        Shop shop = shopService.getShopByUserId(user.getId());
        if (shop != null) {
//			com.shop.entity.User userNew= userService.getUserById(shop.getUserId());
            Integer id = shop.getId();
            List<Friendlink> friendlinkByShopId = friendlinkService.findFriendlinkByShopId(id);
            List<ShopAnnouce> newByShopId = shopAnnouceService.findNewByShopId(id);
            Set<Friendlink> friendlink = new HashSet<>(0);
            Set<ShopAnnouce> shopAnnouceSet = new HashSet(0);
            if (newByShopId != null) {
                for (int i = 0; i < newByShopId.size(); i++) {
                    ShopAnnouce shopAnnouce = newByShopId.get(i);
                    shopAnnouceSet.add(shopAnnouce);
                }
                shop.setShopAnnouces(shopAnnouceSet);
            }
            if (friendlinkByShopId != null) {
                for (int i = 0; i < friendlinkByShopId.size(); i++) {
                    Friendlink friendlink1 = friendlinkByShopId.get(i);
                    friendlink.add(friendlink1);
                }
                user.setFriendlinks(friendlink);
            }
            user.setShop(shop);
            request.getSession().setAttribute("user", user);
        }
        request.setAttribute("userNew", user);


//			System.out.println("++++++++++"+shop.getUserId()+"----------");
//			System.out.println("++++++++++"+shop.getTemplate()+"----------");

//		System.out.println("++++++++++==="+shop);
//		if (shop!=null){
//			userNew.setShop(shop);
//			user.setShop(shop);
////			System.out.println(user.getShop().getId());
//			request.getSession().setAttribute("user",user);
//		}
////		request.setAttribute("userNew", userService.getUserById(user.getId()));
//		request.setAttribute("userNew", userNew);

        if ("prompt".equals(type)) {//点击我的店铺
            return "system/shop/prompt";
        }

        if ("modifyShop".equals(type)) {//点击查看我的店铺
            request.setAttribute("isModify", 1);//1 为装修 其他为不装修

            return "system/shop/myshop/modify_myshop";
        }
        if ("selectStudent".equals(type)) {//选择我是学生或者商家激活激活码进入开店
            return "system/shop/myshop/myshop";
        }
        if ("userShop".equals(type)) {//进入店铺装修
            request.getSession().setAttribute("isModify", 1);//1 为装修
            return "shop/shop_index";
        }
        if ("seeUserShop".equals(type)) {//进入店铺查看装修后结果
            request.getSession().setAttribute("isModify", 2);//2为不装修
            return "shop/shop_index";
        }


        if ("decalareShop".equals(type)) {//选择我是学生或者商家激活激活码进入开店
            return "shop/shopModify/logo_banner/logo_banner";
        }
        if ("proList".equals(type)) {//搜索所有的店铺商品
            return "proList";
        }
        if ("isShow".equals(type)) {//搜索所有的店铺商品
            return "system/shop/isShow";
        }
        if ("isDataShow".equals(type)) {//搜索所有的店铺商品
            return "system/shop/isDataShow";
        }
        return "system/error";
    }

    //给用户添加商店
    @RequestMapping("/system/userAddShop.do")
    public String addUserShop(HttpServletRequest request, HttpServletResponse response) {
        String shopInfo = request.getParameter("shopInfo");
        String name = request.getParameter("name");
        String shopBigAddress = request.getParameter("shopBigAddress");
        String shopBuyType = request.getParameter("shopBuyType");
        String shopDetailAddress = request.getParameter("shopDetailAddress");
//		addShop addShop = new addShop();
        //服务器验证liuming
//		String name = addShop.getName();
//		String shopBigAddress = addShop.getShopBigAddress();
//		String shopBuyType = addShop.getShopBuyType();
//		String shopDetailAddress = addShop.getShopDetailAddress();
        if (name == null || shopBigAddress == null || shopBuyType == null || shopDetailAddress == null || shopInfo == null) {
            request.setAttribute("errorInfo", "非法操作！");
//			System.out.println(name);
//			System.out.println(shopBigAddress);
//			System.out.println(shopBuyType);
//			System.out.println(shopDetailAddress);
//			System.out.println(shopInfo);
//			System.out.println("11111111111111111");
            return "system/error";
        } else {
            boolean flag = (Regex.validateText(shopInfo, 2000) && Regex.validateShopName(name) && Regex.validateShopAddress(shopDetailAddress));
            if (!flag) {
                request.setAttribute("errorInfo", "非法操作！");
//				 System.out.println("22222222222222222222");

                return "system/error";
            }
        }

        Shop shop = new Shop();
        shop.setShopBuyType(shopBuyType);
        shop.setName(name);
        shop.setShopBigAddress(shopBigAddress);
        shop.setShopDetailAddress(shopDetailAddress);
        shop.setShopInfo(shopInfo);
        shop.setIsShowHot(1);
        shop.setIsShowNew(1);
        shop.setIsShowSecond(1);
        shop.setTemplate(1);//1为蓝色  2 为红色
        shop.setCreateDate(new Date());
        shop.setContactUs("");
        shop.setDeliverScope("");
        shop.setOtherText("商品展示");
//		shop.setShopInfo("");
        shop.setSecureShop("");
//		shop.setIsShowHot(1);
//		shop.setIsShowNew(1);
//		shop.setIsShowSecond(1);
        shop.setTag(1);
        shop.setUrl("");
        //request.getScheme()+"://"+request.getServerName()+"/";//得到路径名


        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (userService.addShop(user.getId(), shop) == 1) {
            request.getSession().setAttribute("user", userService.getUserById(user.getId()));//更新在线用户
            com.shop.entity.User userNew = (com.shop.entity.User) request.getSession().getAttribute("user");
            userNew.setShop(shop);
//			int shopId=userNew.getShop().getId();
            int shopId = shop.getId();
            String shopUrl = request.getScheme() + "://" + request.getServerName() + "/" + "shop.do?id=" + shopId;
            if (userService.updateShopUrl(shopUrl, user.getId()) == 1) {
                request.setAttribute("shopId", shopId);
                return "/system/shop/myshop/ispromotOpenShop/selectShop";

            }


        }
        return "system/error";//添加失败
    }

    //修改用户的商店模板
    @RequestMapping("/system/updateShopTemplate.do")
    public String updateShopTemplate(HttpServletRequest request, HttpServletResponse response) {
        int shopId = Integer.parseInt(request.getParameter("shopId"));
        int template = Integer.parseInt(request.getParameter("template"));
        if (userService.updateShopTemplate(shopId, template) == 1) {
            return "/system/shop/myshop/welcom";
        }

        return "system/error";
    }


    //店铺所有商品展示 根据商品的 id和用户的Id
    //同过商品Id查找用户商品/用户                               游客
    @RequestMapping("/shop/prolist.do")
    public String findshopUserGoodsById(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        System.out.println(userId);
        String aa = request.getParameter("template");
        System.out.println("______" + aa);
        String shpIdStr = request.getParameter("shopId");
        System.out.println("++++" + shpIdStr);
        int shopId = Integer.parseInt(request.getParameter("shopId"));
        System.out.println(shopId);


        com.shop.entity.User user = userService.getUserById(userId);
        Shop shopByUserId = shopService.getShopByUserId(userId);
        user.setShop(shopByUserId);
//		List<Goods> goods=goodsService.getUserGoods(shopId);
        List<Goods> goods = goodsService.getUserGoods(shopId);
        request.setAttribute("userNew", user);
        request.setAttribute("goodses", goods);
        return "shop/prolist";
    }


    //修改用户店铺
    @RequestMapping("/system/modifyUserShop.do")
    public String updateUserShop(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String shopInfo = request.getParameter("shopInfo");
        String name = request.getParameter("name");
        String shopBigAddress = request.getParameter("shopBigAddress");
        String shopBuyType = request.getParameter("shopBuyType");
        String shopDetailAddress = request.getParameter("shopDetailAddress");
        String template = request.getParameter("template");
        //服务器验证liuming
        if (name == null || shopBigAddress == null || shopBuyType == null || shopDetailAddress == null || shopInfo == null) {
            request.setAttribute("errorInfo", "非法操作！");
            return "system/error";
        } else {
            boolean flag = (Regex.validateText(shopInfo, 2000) && Regex.validateShopName(name) && Regex.validateShopAddress(shopDetailAddress));
            if (!flag) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }
        }

        Shop shop = new Shop();
        shop.setShopBuyType(shopBuyType);
        shop.setName(name);
        shop.setShopBigAddress(shopBigAddress);
        shop.setShopDetailAddress(shopDetailAddress);
        shop.setShopInfo(shopInfo);
        shop.setTemplate(Integer.parseInt(template));//1为蓝色  2 为红色
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        int shopId = user.getShop().getId();
        if (userService.updateShop(shopId, shop) == 1) {
            return "system/shop/myshop/welcom";
        }
        return "system/error";
    }

    //后台点击个人信息管理，查看个人信息
    @RequestMapping("/findUserByUserId.do")
    public String findUserByUserId(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        //得到一个request范围的user对象
        com.shop.entity.User userRe = userService.findUserByUserId(userId);

        request.setAttribute("userRe", userRe);

        return "system/person/personInformation";
    }


    //根据带店铺Id 查找用户
    @RequestMapping("shop.do")
    public String findUserByShopId(HttpServletRequest request, HttpServletResponse response) {
        int shopId = Integer.parseInt(request.getParameter("id"));
        Shop shop = shopService.shop(shopId);
        if (shop != null) {
            com.shop.entity.User userNew = userService.getUserById(shop.getUserId());
            Integer id = shop.getId();
            List<Friendlink> friendlinkByShopId = friendlinkService.findFriendlinkByShopId(id);
            List<ShopAnnouce> newByShopId = shopAnnouceService.findNewByShopId(id);
            Set<Friendlink> friendlink = new HashSet<>(0);
            Set<ShopAnnouce> shopAnnouceSet = new HashSet(0);
            if (newByShopId != null) {
                for (int i = 0; i < newByShopId.size(); i++) {
                    ShopAnnouce shopAnnouce = newByShopId.get(i);
                    shopAnnouceSet.add(shopAnnouce);
                }
                shop.setShopAnnouces(shopAnnouceSet);
            }
            if (friendlinkByShopId != null) {
                for (int i = 0; i < friendlinkByShopId.size(); i++) {
                    Friendlink friendlink1 = friendlinkByShopId.get(i);
                    friendlink.add(friendlink1);
                }
                userNew.setFriendlinks(friendlink);
            }


//			System.out.println("++++++++++"+shop.getUserId()+"----------");
//			System.out.println("++++++++++"+shop.getTemplate()+"----------");
            userNew.setShop(shop);
            request.setAttribute("userNew", userNew);
//			request.setAttribute("template",shop.getTemplate());
            return "shop/shop_index";
        }
        return "system/error";
    }

    //后台点击个人信息管理，查看个人信息,点击修改个人信息进入到修改页面
    @RequestMapping("/updateByUserId.do")
    public String updateByUserId(HttpServletRequest request, HttpServletResponse response) {
//		com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
//		if(user == null || user.equals("")){
//			request.getSession().invalidate();
//			return "cjmqylogin/login";
//		}
        if (request.getParameter("userId") == null) {
            request.getSession().invalidate();
            return "cjmqylogin/login";
        }

        int userId = Integer.parseInt(request.getParameter("userId"));

        //得到一个request范围的user对象
        com.shop.entity.User userRe = userService.findUserByUserId(userId);

        request.setAttribute("userRe", userRe);

        return "system/person/modiInfo/modifypersonInformation";
    }

    //后台点击个人信息管理，修改密码时进行原密码的Ajax验证是否正确
    @RequestMapping("/oldPasswordExit.do")
    public String oldPasswordExit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");

        int userId = Integer.parseInt(request.getParameter("userId"));
        String oldPassword = request.getParameter("oldPassword");

        //密码加密
        oldPassword = PasswordEncryption.MD5(oldPassword);

        com.shop.entity.User user = new com.shop.entity.User();
        user.setId(userId);
        user.setUserPassword(oldPassword);
        com.shop.entity.User user1 = userService.oldPasswordExit(user);

        PrintWriter out = response.getWriter();


        if (user1 == null) {
            out.print("passwordError");
        }

        out.flush();
        out.close();

        return null;
    }

    //后台点击个人信息管理,后台修改个人信息
    @RequestMapping("/modifyUser.do")
    public String modifyUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String callName = request.getParameter("callName");
        String email = request.getParameter("email");
//		String oldPassword1 = request.getParameter("oldPassword");


        // 防止用户通过地址栏修改用户id值去修改其他用户的信息，将session范围的用户Id和reqeust范围的用户Id进行比较

        com.shop.entity.User userSession = (com.shop.entity.User) request.getSession().getAttribute("user");


        if (userSession.getId().equals(id)) {

            //进行服务器验证

            //服务器端验证，验证旧密码是否正确
            boolean flag = false;
            String oldPassword = request.getParameter("oldPassword");

            oldPassword = PasswordEncryption.MD5(oldPassword);

            com.shop.entity.User oleUser = new com.shop.entity.User();
            oleUser.setId(id);
            oleUser.setUserPassword(oldPassword);
            com.shop.entity.User userReturn = userService.oldPasswordExit(oleUser);

            if (userReturn != null) {
                flag = true;
            }

            boolean temp = Regex.validatCallName(callName)//验证昵称
                    && Regex.validateEmail(email)//验证邮件
                    && flag//验证旧密码是否正确
                    && Regex.validateNewPassword(request.getParameter("newPassword"))//验证新密码
                    && Regex.validateConPassword(request.getParameter("newPassword"), request.getParameter("userPassword"));//验证确认密码


            if (!temp) {
                return "system/error";
            }
            try {
                com.shop.entity.User user = new com.shop.entity.User();
                user.setId(id);
                user.setCallName(callName);
                user.setEmail(email);

                String newPassword = PasswordEncryption.MD5(request.getParameter("userPassword"));

                user.setUserPassword(newPassword);

                int updateNum = userService.modifyUser(user);
                if (updateNum == 1) {
                    com.shop.entity.User userRe = userService.getUserById(id);
                    request.setAttribute("userRe", userRe);
                    return "system/person/personInformation";
                } else {
                    request.setAttribute("errorInfo", "信息修改失败，稍后重试！");
                    return "system/error";
                }


            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return "system/error";
    }

    //根据商品的 id查找所对应的用户
    @RequestMapping("goodsFindShop.do")
    public String findUserByGoodsId(HttpServletRequest request, HttpServletResponse response) {
        int goodsId = Integer.parseInt(request.getParameter("goodsId"));
        Goods goodsById = goodsService.findGoodsById(goodsId);
        if (goodsById == null) {
            request.setAttribute("errorInfo", "商品已下架");
            return "system/error";
        }
        Integer shopId = goodsById.getShopId();
        List<ShopAnnouce> newByShopId = shopAnnouceService.findNewByShopId(shopId);
        Shop shopById = shopService.getShopById(shopId);
        Set<ShopAnnouce> shopAnnouceSet = new HashSet(0);
        if (newByShopId != null) {
            for (int i = 0; i < newByShopId.size(); i++) {
                ShopAnnouce shopAnnouce = newByShopId.get(i);
                shopAnnouceSet.add(shopAnnouce);
            }
            shopById.setShopAnnouces(shopAnnouceSet);
        }
        Integer userId = shopById.getUserId();
        com.shop.entity.User user = userService.getUserById(userId);
        user.setShop(shopById);
        request.setAttribute("goodsId", goodsId);
        request.setAttribute("userNew", user);
        return "shop/shop_index";
    }
//	@RequestMapping("/shop/goodsFindShop.do")
//	public String findUserByGoodsIds(HttpServletRequest request, HttpServletResponse response) {
//		int goodsId=Integer.parseInt(request.getParameter("goodsId"));
//		Goods goodsById = goodsService.findGoodsById(goodsId);
//		Integer shopId = goodsById.getShopId();
//		List<ShopAnnouce> newByShopId = shopAnnouceService.findNewByShopId(shopId);
//		Shop shopById = shopService.getShopById(shopId);
//		Set<ShopAnnouce> shopAnnouceSet = new HashSet(0);
//		if (newByShopId!=null){
//			for (int i =0;i<newByShopId.size();i++){
//				ShopAnnouce shopAnnouce = newByShopId.get(i);
//				shopAnnouceSet.add(shopAnnouce);
//			}
//			shopById.setShopAnnouces(shopAnnouceSet);
//		}
//		Integer userId = shopById.getUserId();
//		com.shop.entity.User user=userService.getUserById(userId);
//		user.setShop(shopById);
//		request.setAttribute("goodsId", goodsId);
//		request.setAttribute("userNew", user);
//		return "shop/shop_index";
//	}

//


//
//	public ActionForward userModifyType(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response)
//			throws Exception {
//		int userType=Integer.parseInt(request.getParameter("userType"));
//		User user=(User) request.getSession().getAttribute("user");
//		if(user.getUserType()==1){
//
//			if(userService.updateUserType(user.getId(), userType)){
//				  return mapping.findForward("myshop");//修改成功
//
//			}
//			return mapping.findForward("error");
//		}else
//			if(user.getUserType()==2){
//				{
//
//						return mapping.findForward("loginImformBussinesst");
//				}
//
//		}
//
//
//		return mapping.findForward("error");//修改失败
//	}
//

    //商家激活激活码
    @RequestMapping("/system/businessActiveCode.do")
    public String businessActiveCode(HttpServletRequest request, HttpServletResponse response) {
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        String activeCode = request.getParameter("activeCode");
        if (userService.activeCode(user.getId(), activeCode) == 1) {
//			com.shop.entity.User userById = userService.getUserById(user.getId());
            userService.modifyUserType(user.getId());
            codeActiveService.isActiveModifyByBusinessId(user.getId());
            request.setAttribute("userNew", userService.getUserById(user.getId()));
            return "system/shop/myshop/myshop";//激活成功
        }
        request.setAttribute("error", "error");//激活失败
        return "system/shop/myshop/ispromotOpenShop/loginImformBussinesst";
    }


    //
//
//
//
    //查询所有会员并分页
    @RequestMapping("/system/findAllUsersByPage.do")
    public String findAllUsersByPage(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String beginDate = request.getParameter("beginDate");
        String endDate = request.getParameter("endDate");
        int currentPage = 1;
        if (request.getParameter("currentpage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentpage"));
        }
        int totalRecords = userService.counts(userName, beginDate, endDate);
        int everyPageRecords = 5;//设置每页显示5条记录
        Page page = new Page(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
        List<com.shop.entity.User> users = userService.users(page.getBeginIndexRecord(), page.getEveryPageRecords(), userName, beginDate, endDate);
        for (int i = 0; i < users.size(); i++) {
            com.shop.entity.User user = users.get(i);
            Date createDate = user.getCreateDate();
//			System.out.println(user.getCreateDate());
            System.out.println(createDate);
            SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            //第一种
//			Date date = new Date(createDate);
            String format = sim.format(createDate);
            System.out.println(format);
            user.setCreateDateStr(format);
        }
        request.setAttribute("users", users);
        request.setAttribute("page", page);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("userName", userName);
        request.setAttribute("beginDate", beginDate);
        request.setAttribute("endDate", endDate);
        return "system/member/MembersInfo";

    }

    //查找所有用户  * 根据用户Id 查找用户


    @RequestMapping("/system/detail/MemberManageDetail.do")
    public String findAllUsersFindUserById(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("id"));
        com.shop.entity.User user = userService.getUserById(userId);
        Date createDate = user.getCreateDate();
//			System.out.println(user.getCreateDate());
        System.out.println(createDate);
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //第一种
//			Date date = new Date(createDate);
        String format = sim.format(createDate);
        System.out.println(format);
        user.setCreateDateStr(format);
        request.setAttribute("userNew", user);

        return "system/member/detail/MemberManage";
    }

//
    //查找所有用户  * 根据用户Id 删除用户


    @RequestMapping("/system/detail/MemberManageDelete.do")
    public String findAllUsersDeleteUserById(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("id"));
        if (userService.deleteUserById(userId) == 1) {
            String userName = request.getParameter("userName");
            String beginDate = request.getParameter("beginDate");
            String endDate = request.getParameter("endDate");
            int currentPage = 1;
            if (request.getParameter("currentpage") != null) {
                currentPage = Integer.parseInt(request.getParameter("currentpage"));
            }
            int totalRecords = userService.counts(userName, beginDate, endDate);
            int everyPageRecords = 5;//设置每页显示5条记录
            Page page = new Page(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
            List<com.shop.entity.User> users = userService.users(page.getBeginIndexRecord(), page.getEveryPageRecords(), userName, beginDate, endDate);
            request.setAttribute("users", users);
            request.setAttribute("page", page);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("userName", userName);
            request.setAttribute("beginDate", beginDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("isDelete", "yes");
            return "system/member/MembersInfo";//删除成功
        }

        request.setAttribute("isDelete", "no");
        return "system/error";//删除失败
    }


}
