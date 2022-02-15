package com.liuuki.service.imp;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liuuki.dao.ProductDao;
import com.liuuki.domain.Product;
import com.liuuki.service.ProductService;
import com.liuuki.vo.Condition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.File;
import java.util.List;

@Service
public class ProductServiceImp implements ProductService {
    @Autowired
    private ProductDao productDao;

    @Override
    public PageInfo listByCondition(Condition condition, int pageSize) {
        PageHelper.startPage(condition.getPage(),pageSize);
        List<Product> productList = productDao.listByCondition(condition);

        PageInfo<Product> pageInfo=new PageInfo<>(productList);
        return pageInfo;
    }

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

    /**
     * 根据id批量删除产品信息，包括图片
     * @param pIds
     * @param path 图片存在的路径，加上图片名称即为该图片的全路径
     * @return
     */
    @Override
    public boolean deleteProductByIds(String[] pIds,String path) {
        boolean flag=false;
        int num=productDao.selectProductByIds(pIds);
        int num1=productDao.deleteProductByIds(pIds);
        System.out.println("查询到" + num + "条数据，删除了" + num1 + "条数据");
        if(num==num1){
            System.out.println("删除成功！");
            flag=true;
        }
        //图片删除操作
        List<String> strings = productDao.getPImages(pIds);
//        System.out.println("path:" + path);
        for(String id:strings){
//            System.out.println(id);
            String imagPath=path+id;
//            System.out.println(path);
            File file = new File(imagPath);
            //判断是够存在以及是否是文件，如果都满足，删除改文件
            if(file.exists() && file.isFile()){
                file.delete();
            }

        }

        return flag;
    }
}
