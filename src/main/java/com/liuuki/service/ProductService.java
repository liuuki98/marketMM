package com.liuuki.service;

import com.github.pagehelper.PageInfo;
import com.liuuki.dao.ProductDao;
import com.liuuki.domain.Product;
import com.liuuki.domain.ProductType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


public interface ProductService {
    PageInfo splitPage(Integer page, int pageSize);


    int saveProduct(Product product);

    Product goUpdate(String pId);

    boolean updateProduct(Product product);

    boolean deleteProductById(Integer pId);
}
