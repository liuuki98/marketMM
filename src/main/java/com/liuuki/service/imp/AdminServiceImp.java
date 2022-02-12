package com.liuuki.service.imp;

import com.liuuki.dao.AdminDao;
import com.liuuki.domain.Admin;
import com.liuuki.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImp implements AdminService {
    @Autowired
    private AdminDao adminDao;

    @Override
    public String login(String name, String pwd) {
        Admin Admin1 = adminDao.getNameByName(name);
        if(Admin1==null){
            return "0";
        }
        Admin admin =adminDao.getPwdByPwd(name,pwd);
        if(admin==null){
            return "2";
        }else {
            return name;
        }


    }
}
