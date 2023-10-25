# 🎨 PowerShell Profile (Pretty PowerShell)

A stylish and functional PowerShell profile that looks and feels almost as good as a Linux terminal.

## ⚡ One Line Install (Elevated PowerShell Recommended)

Execute the following command in an elevated PowerShell window to install the PowerShell profile:

```
irm "https://github.com/ChrisTitusTech/powershell-profile/raw/main/setup.ps1" | iex
irm "https://github.com/lgf4591/powershell-profile/raw/main/setup.ps1" | iex
```

## 🛠️ Fix the Missing Font

After running the script, you'll find a downloaded `cove.zip` file in the folder you executed the script from. Follow these steps to install the required nerd fonts:

1. Extract the `cove.zip` file.
2. Locate and install the nerd fonts.

Now, enjoy your enhanced and stylish PowerShell experience! 🚀


## windows中cmd和powershell设置代理
https://blog.csdn.net/qq_40989066/article/details/122548540


### windows

##### cmd

设置**临时**代理（关闭cmd即设置的代理消失）  
`set all_proxy=socks5://127.0.0.1:10808` (**端口号为你代理软件socks5协议的端口**)  
删除临时代理  
`set all_proxy=`  
查看当前环境变量  
`set`  
查看当前公网ip判断代理是否成功  
`curl cip.cc`

##### [powershell](https://so.csdn.net/so/search?q=powershell&spm=1001.2101.3001.7020)

设置**临时**代理（关闭powershell即设置的代理消失）  
`$env:all_proxy="socks5://127.0.0.1:10808"` (**端口号为你代理软件socks5协议的端口**)  
删除当前临时代理  
`$env:all_proxy=""`  
查看当前环境变量  
`ls env:*`  
暂不知晓curl 和 ping层面上检测代理是否成功,设置完临时代理，通过命令行界面已成功获得下载相关速度

##### cmd和powershell设置永久代理

单击我的电脑属性=》选择高级系统设置=》选择环境变量=》选择系统变量=》选择新建  
新建all\_proxy，值设置为socks5://127.0.0.1:10808  
![在这里插入图片描述](https://img-blog.csdnimg.cn/aedd8276003346039076529a11e58ab5.png)  
保存即可保存为永久代理

##### 快捷代码设置临时命令行代理

###### cmd

可以 设置**临时**代理保存为cmd\_setproxy.bat如下：  
![在这里插入图片描述](https://img-blog.csdnimg.cn/5d8ce807a9ab4e498286472e32965c61.png)  
删除**临时**代理如下  
![在这里插入图片描述](https://img-blog.csdnimg.cn/886aed55390848a18e9dde97d67bb9e8.png)  
_**将两个bat保存为同一路径下，将路径粘贴入系统变量的PATH中，即可设置成功**_  
输入cmd\_setproxy即可设置成功  
![在这里插入图片描述](https://img-blog.csdnimg.cn/d150b6a21a47452fb44589f61c08fb70.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5rWu6ICM5LiN5a6e,size_20,color_FFFFFF,t_70,g_se,x_16)

###### powershell

用管理员模式打开powershell  
`code $profile`（code表示用vscode打开$profile文件,$profile表示powershell的配置文件）

```
function setproxy{
    $env:all_proxy="socks5://127.0.0.1:10808"
}

function unsetproxy{
    $env:unsetproxy=""
}
```

保存完后 另外再开powershell如果出现  
系统无法使用脚本的报错  
用管理员打开的powershell运行  
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`  
选择同意更改策略，如果需要具体更改相关策略选项可以到官网文档进行查看

> [https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about\_execution\_policies?view=powershell-7.2](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2)

保存完成 即可使用power shell使用setproxy快捷设置临时代理  
![在这里插入图片描述](https://img-blog.csdnimg.cn/2fc6a8e611cf4dd48e8fd91c4dc833f3.png)