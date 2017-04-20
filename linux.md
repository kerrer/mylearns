Linux打开txt文件乱码的解决方法

  Linux显示在Windows编辑过的中文就会显示乱码是由于两个操作系统使用的编码不同所致。Linux下使用的编码是utf8，而Windows使用的是gb18030。因此，解决Linux打开txt文件中文乱码可有如下两种方法。
  方法一：
  在附件终端中，进入到txt文件所在目录，使用命令符“iconv -f gb18030  -t utf8 1.txt -o 2.txt”把gb18030编码的1.txt转换成utf8的2.txt。这样2.txt就成为Linux支持的编码。
  方法二：
  在附件终端中,使用命令符“gconf-editor”，进入环境配置，依次展开“/apps/gedit-2/preferences/encodings/”，编辑右侧的“auto_detected”将“gb18030”添加到最顶上。以后文本编辑器就可以正常显示中文了。
