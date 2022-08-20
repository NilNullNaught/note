##### 解决方法

1. 在 Tomcat 安装目录下，找到 conf/logging.properties 文件，打开后，找到 java.util.logging.ConsoleHandler.encoding 的配置项，将其值修改为 GBK 即可。 java.util.logging.ConsoleHandler.encoding = GBK
2. 再次运行程序应该中午就没有乱码了。
   ————————————————
   版权声明：本文为CSDN博主「云森雨」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
   原文链接：https://blog.csdn.net/mongchu/article/details/118198222