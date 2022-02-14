package com.liuuki.service.imp;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liuuki.dao.ProductDao;
import com.liuuki.domain.Product;
import com.liuuki.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImp implements ProductService {
    @Autowired
    private ProductDao productDao;

    @Override
    public boolean deleteProductById(Integer pId) {
        boolean flag =false;
        int num=productDao.deleteProductById(pId);
        if(num!=0){
            flag=true;
        }
        return flag;
    }

    @Override
    public boolean updateProduct(Product product) {
        boolean flag=false;
        int num = productDao.updateProduct(product);
        System.out.println("Num:" + num);
        if(num!=0){
            flag=true;
        }
        return flag;
    }

    @Override
    public Product goUpdate(String pId) {
        Product product = productDao.goUpdate(pId);
        return product;
    }

    @Override
    public PageInfo splitPage(Integer pageNum, int pageSize) {
        //设置分页工具的起始页和显示数
        PageHelper.startPage(pageNum,pageSize);

        List<Product> productList = productDao.splitPage();

        PageInfo<Product> pageInfo=new PageInfo<>(productList);
        return pageInfo;


    }

    @Override
    public int saveProduct(Product product) {
        int num=productDao.saveProduct(product);
        return num;
    }
}
