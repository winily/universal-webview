# universal-webview

[中文]|<a href="./README.ME">[English]</a>

universal-webview（接下来简称 UW）
是一款基于系统 webview 的图形化界面开发框架灵感来源
<a href='https://tauri.app/'>Tauri</a>
与它类似，但 Tauri 是基于 rust 开发，UW 是基于 C++ 开发，
因为没有依赖 chromium 所以 UW 要比 Electron 要轻量很多。
不过对应的会产生一点问题就是每个平台的操作系统提供的 WebView
都是不同的标准，在 Web API 上可能会有细微的区别。

`tip: 因为我是个人开发者可能支撑度不会很高， 目前仅为实现自己需求的功能为主，如果需要去适配更多功能欢迎 PR 或者提出 issues`

## Support

#### MacOS

- WebView
- Clipboard
- 资源本地化
  > 自定义了协议头，让制定写法的 URL 被内部代码拦截，访问到本地资源
  >
  > 以下例子为访问到本地的根目录是代码目录下的 resource
  > uwfile 是协议名，native 是 host 名 uwfile://native 后面才是真正的 URI
  >
  > ```html
  > <script src="uwfile://native/static/js/main.be3b70e5.js" />
  > ```
  >
  > 默认协议是由 window.open 传入的指定，比如
  >
  > ```C++
  > window.open('uwfile://native/index.html')
  > ```
  >
  > 那么默认路径就是 uwfile://native，如果写相对路径
  > 就都会走 uwfile://native
  > 除非写绝对路径例如 https://www.baidu.com

## TODO

#### MacOS

- fs

#### Windows

- WebView2
- Clipboard
- fs
- 资源本地化
