# universal-clipboard-js

准备成为一个全平台通用的剪贴板库

中文｜<a href="./README.md">English</a>

## 如何使用它

非常的简单，就看以下代码，我不信你不会用

```js
const { readText, writeText, FORMAT_FILE_URL } = require('../index.js')
console.log(readText(), 'result')
console.log(readText(FORMAT_FILE_URL), 'file path result')

console.log(
  writeText(
    'file:///Users/ZhangXiaohua/Documents/LearningMaterials/C++FromEntryToGrave.pdf',
    FORMAT_FILE_URL
  ),
  'writeText result'
)
```

## API

```ts
// 清空你的剪贴板
export function clear(): void

// 从剪贴板读或者写入 buffer
// format 的默认值是 FORMAT_PLAIN_TEXT 文本类型
export function readBuffer(format?: string): Buffer
export function writeBuffer(data: Buffer, format?: string): boolean

// 从剪贴板读或者写入 字符串
// format 的默认值是 FORMAT_PLAIN_TEXT 文本类型
export function readText(format?: string): string
export function writeText(text: string, format?: string): boolean

// 剪贴板的数据格式类型枚举
export const FORMAT_PLAIN_TEXT: string
export const FORMAT_FILE_URL: string
```

## TODO

- Window
- Linux
- ......

## 支持的平台

- MacOS
