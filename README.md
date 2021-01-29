# 使用T4模板生成 MSSQL 实体类 
实体类使用的特性头适配 Tiyor.Shearwall 框架

## 使用说明
1、复制 demo.tt 到需要的项目中

2、修改 demo.tt 第6行 DbContext.Generator.Controller.ttinclude 文件路径、第66行 DbContext.Generator.ttinclude 文件路径，如：
```
  %USERPROFILE%\.nuget\packages\tiyor-db-t4\1.0.x\DbContext.Generator.Controller.ttinclude
  %USERPROFILE%\.nuget\packages\tiyor-db-t4\1.0.x\DbContext.Generator.ttinclude
```

3、修改 demo.tt 中连接字符串、模板的默认命名空间、存储路径等设置

4、保存 demo.tt，如果Visual Studio编辑，保存后将立即编译执行

5、也可以使用命令行编译执行，如：
```
  C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\TextTransform demo.tt
```
6、如果使用 Visual Studio Code 编辑，可以安装 zbecknell.t4-support、formulahendry.code-runner 插件， settings.json 增加如下配置：
```
    "code-runner.executorMapByGlob": {
        "*.tt":"& \"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Enterprise\\Common7\\IDE\\TextTransform\"",
    },
```

## 感谢
[PetaPoco](https://github.com/CollaboratingPlatypus/PetaPoco)