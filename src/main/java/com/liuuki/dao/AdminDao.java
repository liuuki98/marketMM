package com.liuuki.dao;

import com.liuuki.domain.Admin;
import org.apache.ibatis.annotations.Param;

public interface AdminDao {
    Admin getNameByName(String name);

    Admin getPwdByPwd(@Param("name") String name, @Param("pwd") String pwd);
}
