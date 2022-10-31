# universal-webview

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

## TODO

#### MacOS

- fs
- 资源本地化 <a href="https://blog.csdn.net/LOLITA0164/article/details/78889986">refer</a>

#### Windows

- WebView2
- Clipboard
- fs
- 资源本地化
