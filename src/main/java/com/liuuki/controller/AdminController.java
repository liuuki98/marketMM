package com.liuuki.controller;

import com.liuuki.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    /**
     * 进行登录验证
     * @param name 用户名
     * @param pwd 密码
     * @param model
     * @return
     */
    @RequestMapping("/login.do")
    public String login(String name, String pwd,  Model model){
        String i = adminService.login(name,pwd);
        if("0".equals(i)){
            model.addAttribute("errmsg","账号不存在，请重新输入！");
            return "login";
        }else if("2".equals(i)){
            model.addAttribute("errmsg","密码错误，请重新输入！");
            return "login";
        }else {
            model.addAttribute("name",name);
            return "main";
        }
    }
}
