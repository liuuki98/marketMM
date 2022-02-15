package com.liuuki.controller;

import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageInfo;
import com.liuuki.domain.Product;
import com.liuuki.service.ProductService;
import com.liuuki.util.FileNameUtil;
import com.liuuki.vo.Condition;
import com.sun.org.apache.bcel.internal.generic.MONITORENTER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;


@Controller
@RequestMapping("/prod")
public class ProductController {
    @Autowired
    private ProductService productService;
    //设置初始的页数为5
    private static final  int PAGE_SIZE=5;

    public String saveFileName = "";

    /**
     * 对product页面的产品显示进行分页设置（不含条件查询）
     * @param page
     * @param model
     * @return
     */
    @RequestMapping("/getProList.do")
    public String split(
            @RequestParam(value = "page", defaultValue = "1")
                    Integer page, Model model) {
        System.out.println("进入分页");
        PageInfo info = productService.splitPage(page, PAGE_SIZE);
        model.addAttribute("info", info);

        return "product";
    }

    @RequestMapping("/ajaxPageList.do")
    @ResponseBody
    public void ajaxsplit(Condition condition, HttpSession session){
        System.out.println("ajaxPageList"+"+++++"+condition.getPage());
        PageInfo info = productService.listByCondition(condition, PAGE_SIZE);
        session.setAttribute("info",info);
    }

    @RequestMapping("ListByConditon.do")
    public ModelAndView ListByConditon(Condition condition){
        System.out.println("进入到条件分页:"+"\n"+condition.toString());

        ModelAndView mv = new ModelAndView();
        PageInfo info = productService.listByCondition(condition, PAGE_SIZE);
        System.out.println("pageInfo.size:" + "\n" + info.getList().size());
        mv.addObject("info",info);
        mv.addObject("typeId",condition.getTypeId());
        mv.setViewName("product");
        return mv;
    }

    /**
     * 上传文件到服务器
     * @param pImage 上传文件的名称，和前端的<input type="file" name=pImage>中的name需要保持一致！！！
     * @param request
     * @return
     */
    @RequestMapping("/ajaxImg.do")//要进行文件上传操作
    @ResponseBody
    public String ajaxImg(MultipartFile pImage, HttpServletRequest request){

        //取文件名,FileNameUtil.getUUIDFileName()随机生成文件名， FileNameUtil.getFileType获取文件后缀
        saveFileName = FileNameUtil.getUUIDFileName() + FileNameUtil.getFileType(pImage.getOriginalFilename());
        //取路径 /image_big文件存储的目录，从SNAPSHO为根
        try {
            String path = request.getServletContext().getRealPath("/image_big");
            //转存 ，File.separator：符号点
            pImage.transferTo(new File(path + File.separator + saveFileName));
        } catch (Exception e) {
            e.printStackTrace();
        }

        //为了在客户端显示图片，要将存储的文件名回传下去，由于是自定义的上传插件，所以此处要手工处理JSON
//        JSONObject object = new JSONObject();
//        object.put("imgurl",saveFileName);
        //切记切记：JSON对象一定要toString()回到客户端
//        return object.toString();
//        Map<String,String> map = new HashMap<>();
//        map.put("imgurl",saveFileName);
////        return JSONArray.toJSONString(map);
        return JSONArray.toJSONString(saveFileName);

    }

    /**
     * 添加商品信息到数据库中
     * @param product
     * @param request
     * @return
     */
    @RequestMapping("/saveProduct.do")
    public String saveProduct(Product product,HttpServletRequest request){
        //设置图片的名称和创建时间

        product.setpImage(saveFileName);
        product.setpDate(new Date());

        int num=productService.saveProduct(product);
        if(num!=1){
            request.setAttribute("msg","添加失败");
        }
        saveFileName="";
        //返回到商品首页并进行分页
        return "redirect:/prod/getProList.do";

    }

    @RequestMapping("/goUpdate.do")
    public ModelAndView goUpdate(String pId,Condition condition){

        Product product = productService.goUpdate(pId);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("prod",product);
        modelAndView.addObject("con",condition);
        modelAndView.addObject("page",condition.getPage());
        modelAndView.setViewName("update");
        return modelAndView;
    }

    /**
     * 根据id更新商品信息
     * @param product
     * @param page
     * @return
     */
    @RequestMapping("/updateProduct")
    @ResponseBody
    public boolean updateProduct(Product product, Integer page)
    {

        boolean flag=productService.updateProduct(product);
        return flag;

    }

    @RequestMapping("/deleteProductById.do")
    public String deleteProductById(Integer pId,HttpServletRequest request,String pImage,Condition condition) {
        String path = request.getServletContext().getRealPath("/image_big") + "/" + pImage;
//        System.out.println(path);
        System.out.println(condition.toString());
        boolean flag=productService.deleteProductById(pId);
        if (!flag) {
//            System.out.println("失败");
            request.getSession().setAttribute("msg", "删除失败！");
        } else {
            File file = new File(path);
            // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
//            System.out.println(file.exists());
            if (file.exists() && file.isFile()) {
                file.delete();
//                if (file.delete()) {
//                    System.out.println("删除单个文件" + path + "成功！");
//                } else {
//                    System.out.println("删除单个文件" + path + "失败！");
//                }
            }
            
        }
        //拼接请求路径，防止为空值造成的报错
        String requestPath="";
        if(condition.getpName()!=null){
            requestPath += "&pName="+condition.getpName();
        }
        if(condition.getTypeId()!=null){
            requestPath+="&typeId="+condition.getTypeId();
        }
        if(condition.getlPrice()!=null){
            requestPath+="&lPrice="+condition.getlPrice();
        }
        if(condition.gethPrice()!=null){
            requestPath+="&hPrice="+condition.gethPrice();
        }

        return "redirect:/prod/ListByConditon.do?page="+condition.getPage()+requestPath;
    }

    @RequestMapping("/deleteProductByIds")
    @ResponseBody
    public boolean deleteProductByIds(String pId,HttpServletRequest request){
        String []pIds= pId.split(",");
        String path = request.getServletContext().getRealPath("/image_big") + "/";
        boolean flag=productService.deleteProductByIds(pIds,path);


        return flag;
    }

}
