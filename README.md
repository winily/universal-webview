# universal-webview

<a href="./README-CN.md">[中文]</a>|[English]

universal-webview (hereinafter referred to as UW)
It is a source of inspiration for a graphical interface development framework based on system webview
<a href='https://tauri.app/'>Tauri</a>
Similar to it, but Tauri is developed based on rust, UW is developed based on C++,
Because there is no dependence on chromium, UW is much lighter than Electron.
However, the corresponding problem is that the WebView provided by the operating system of each platform
All are different standards and may have subtle differences on Web APIs.

`tip: Because I am a personal developer, the support level may not be very high. At present, I mainly only realize the functions I need. If you need to adapt more functions, please PR or raise issues`

## Support

#### MacOS

- WebView
- Clipboard
- Resource localization
  > Customized the protocol header, so that the URL of the formulation can be intercepted by the internal code, and the local resources can be accessed
  >
  > The following example is to access the local root directory is the resource in the code directory
  > uwfile is the protocol name, native is the host name uwfile://native is followed by the real URI
  >
  > ```html
  > <script src="uwfile://native/static/js/main.be3b70e5.js" />
  > ```
  >
  > The default protocol is specified by window.open, such as
  >
  > ```C++
  > window.open('uwfile://native/index.html')
  > ```
  >
  > Then the default path is uwfile://native, if you write a relative path
  > will go to uwfile://native
  > unless write absolute path like https://www.baidu.com

## TODO

#### MacOS

- fs
- menu

#### Windows

- WebView2
- Clipboard
- fs
- Resource localization
- menu
