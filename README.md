# docker-pan 搭建个人的可离线云盘
Docker:`Filerun`+`AriaNg`+`Aria2`,Personal cloud disk. 

- Filerun：一款简洁的在线文件管理器，可在线对文件进行：图片预览、播放音乐、播放视频、文本编辑还支持语法高亮。

- AriaNg：aria2 web界面，可离线下载磁力链接、BT种子等，使用响应式布局,支持各种计算机或移动设备。

> filerun/docker : [https://github.com/filerun/docker](https://github.com/filerun/docker)

## Run

1.run mysql

```
docker run --name=db -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=filerun -e MYSQL_USER=filerun -e MYSQL_PASSWORD=filerun -dP mysql
```

2.run filerun

```
docker run --name=pan --link=db  -ti -p 8081:80 -p 6800:6800 jaegerdocker/pan
```

## 访问地址

- Filerun:`http://yourdomain.com:8081`

- AriaNg:`http://yourdomain.com:8081/dweb`


## Filerun 文件管理器
![][1]
![][2]
![][3]


  
## AriaNg 离线下载界面

![][4]
![][5]


  [1]: http://www.filerun.com/images/screenshot.jpg
  [2]: http://www.filerun.com/images/screenshot_photos.jpg
  [3]: http://www.filerun.com/images/screenshot_music.jpg
  [4]: https://raw.githubusercontent.com/mayswind/AriaNg-WebSite/master/screenshots/desktop.png
  [5]: https://raw.githubusercontent.com/mayswind/AriaNg-WebSite/master/screenshots/mobile.png
