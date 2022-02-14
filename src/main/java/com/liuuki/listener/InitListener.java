package com.liuuki.listener;

import com.liuuki.domain.ProductType;

import com.liuuki.service.ProductTypeService;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;
@WebListener
public class InitListener implements ServletContextListener {
    /**
     *   //取出所有的商品类型，便于在增加和更新的页面上使用，或者前端的类型查询中使用
     * @param servletContextEvent
     */
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        //手工从spring的Bean工厂中按名称取出类型的service
        ApplicationContext application= new ClassPathXmlApplicationContext("applicationContext_*.xml");
        ProductTypeService productTypeServiceImp =(ProductTypeService) application.getBean("ProductTypeServiceImp");
        List<ProductType> typeList = productTypeServiceImp.getAll();
        servletContextEvent.getServletContext().setAttribute("ptlist",typeList);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
