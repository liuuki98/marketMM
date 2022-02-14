package com.liuuki.dao;

import com.liuuki.domain.Product;

import java.util.List;

public interface ProductDao {
    List<Product> splitPage();

    int saveProduct(Product product);

    Product goUpdate(String pId);

    int updateProduct(Product product);

    int deleteProductById(Integer pId);
}
