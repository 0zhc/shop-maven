package com.shop.controller;

import com.shop.entity.GoodsOrder;
import com.shop.entity.Shop;
import com.shop.entity.ShoppingCart;
import com.shop.service.GoodsService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.Vector;

@Controller
public class ShoppingCartController {
    @Resource
    private GoodsService goodsService;
    @Resource
    private ShopService shopService;


    @RequestMapping("/cart/findAllGoodsInCart.do")
    public String findAllGoodsInCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (user == null || user.equals("")) {
            request.getSession().invalidate();
            return "cjmqylogin/login";
        }
        Vector cart = (Vector) request.getSession().getAttribute("cart" + user.getId());
        List<GoodsOrder> goodsOrders = new ArrayList<GoodsOrder>();
        if (cart == null) {
        } else {
            if (cart.size() == 0) {
                request.getSession().removeAttribute("cart" + user.getId());
            } else {
                for (int i = 0; i < cart.size(); i++) {
                    ShoppingCart cartForm = (ShoppingCart) cart.elementAt(i);
                    com.shop.entity.Goods goods = goodsService.findGoodsById(cartForm.getGoodsId());
                    Integer shopId = goods.getShopId();
                    Shop shopById = shopService.getShopById(shopId);
                    goods.setShop(shopById);
                    GoodsOrder goodsOrder = new GoodsOrder();
                    float price = goods.getPrice();
                    Integer amount = goods.getAmount();
                    if (amount == 0) {
                        cart.remove(cartForm);
                        continue;
                    }
                    if ((cartForm.getAmount()) < amount) {
                        amount = cartForm.getAmount();
                    }
                    NumberFormat numberFormat = DecimalFormat.getInstance();
                    numberFormat.setMinimumFractionDigits(2);
                    String total = numberFormat.format(price * amount) + "元";
                    goodsOrder.setGood(goods);
                    goodsOrder.setAmount(amount);
                    goodsOrder.setTotal(total);
                    goodsOrders.add(goodsOrder);
                    UUID uuid = UUID.randomUUID();
                    String token = uuid.toString().replaceAll("-", "");
                    // 访问页面时随机生成一个token保存在服务端session中
                    request.getSession().setAttribute("TOKEN", token);
                }
            }
        }
        request.setAttribute("cartOrder", goodsOrders);
        return "shop/shopping_cart";
    }


    @RequestMapping("/cart/addCart.do")
    public String addCart(HttpServletRequest request, HttpServletResponse response) {
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (user == null || user.equals("")) {
            request.getSession().invalidate();
            return "cjmqylogin/login";
        }

        // 服务器验证
        String getGoodId = request.getParameter("goodsId");
        String getAmount = request.getParameter("amount");
        if (getGoodId == null || getAmount == null) {
            request.setAttribute("errorInfo", "非法操作！");
            return "system/error";
        }

        Integer goodsId = Integer.parseInt(getGoodId);
        Integer amount = Integer.parseInt(getAmount);
        com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);

        ShoppingCart shoppingCart = new ShoppingCart();
        shoppingCart.setGoodsId(goodsId);

        shoppingCart.setAmount(amount);
        boolean flag = true;
        Vector cart = (Vector) request.getSession().getAttribute(
                "cart" + user.getId());

        if (cart == null) {
            cart = new Vector();
        } else {
            for (int i = 0; i < cart.size(); i++) {
                ShoppingCart cartForm = (ShoppingCart) cart.elementAt(i);
                if (cartForm.getGoodsId() == shoppingCart.getGoodsId()) {
                    cartForm.setAmount(cartForm.getAmount() + amount);
                    flag = false;
                }
            }
        }
        if (flag) {
            cart.add(shoppingCart);
            request.getSession().setAttribute("cart" + user.getId(), cart);
        }

        return "shop/shoppingCart/addGoodInCart";
    }

    //
    @RequestMapping("/cart/deleteGoodInCart.do")
    public String deleteGoodInCart(HttpServletRequest request, HttpServletResponse response) {
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (user == null || user.equals("")) {
            request.getSession().invalidate();
            return "cjmqylogin/login";
        }
        Integer cartId = Integer.parseInt(request.getParameter("cartId"));
        Vector cart = (Vector) request.getSession().getAttribute("cart" + user.getId());
        if (cart != null) {
            if (cartId >= cart.size()) {


//				return "shop/shopping_cart";
            } else {
                ShoppingCart cartForm = (ShoppingCart) cart.elementAt(cartId);
                cart.remove(cartForm);
            }
            if (cart.size() == 0) {
                request.getSession().removeAttribute("cart" + user.getId());
            }
        }
        List<GoodsOrder> goodsOrders = new ArrayList<GoodsOrder>();
        for (int i = 0; i < cart.size(); i++) {
            ShoppingCart cartForm = (ShoppingCart) cart.elementAt(i);
            com.shop.entity.Goods goods = goodsService.findGoodsById(cartForm.getGoodsId());
            Integer shopId = goods.getShopId();
            Shop shopById = shopService.getShopById(shopId);
            goods.setShop(shopById);
            GoodsOrder goodsOrder = new GoodsOrder();
            float price = goods.getPrice();
            Integer amount = goods.getAmount();
            if (amount == 0) {
                cart.remove(cartForm);
                continue;
            }
            if ((cartForm.getAmount()) < amount) {
                amount = cartForm.getAmount();
            }
            NumberFormat numberFormat = DecimalFormat.getInstance();
            numberFormat.setMinimumFractionDigits(2);
            String total = numberFormat.format(price * amount) + "元";
            goodsOrder.setGood(goods);
            goodsOrder.setAmount(amount);
            goodsOrder.setTotal(total);
            goodsOrders.add(goodsOrder);
        }
        request.setAttribute("cartOrder", goodsOrders);
        return "shop/shopping_cart";
    }

}
