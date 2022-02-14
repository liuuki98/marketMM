package com.liuuki.service.imp;

import com.liuuki.dao.ProductDao;
import com.liuuki.dao.ProductTypeDao;
import com.liuuki.domain.ProductType;
import com.liuuki.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ProductTypeServiceImp")
public class ProductTypeServiceImp implements ProductTypeService {
    @Autowired
    private ProductTypeDao productTypeDao;

    @Override
    public List<ProductType> getAll() {
        System.out.println("获取typeList");
        List<ProductType> typeList = productTypeDao.getAll();
        return typeList;
    }
}
