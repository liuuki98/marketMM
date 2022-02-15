package com.liuuki.dao;

import com.liuuki.domain.Product;
import com.liuuki.vo.Condition;

import java.util.List;

public interface ProductDao {
    List<Product> splitPage();

    int saveProduct(Product product);

    Product goUpdate(String pId);

    int updateProduct(Product product);

    int deleteProductById(Integer pId);

    int selectProductByIds(String[] pIds);

    int deleteProductByIds(String[] pIds);

    List<String> getPImages(String[] pIds);

    List<Product> listByCondition(Condition condition);
}
