# universal-clipboard-js

Ready to be a universal clipboard library for all platforms.

<a href="./README-CN.md">中文</a>｜English

## How to use

very simple

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
// clear your clipboard
export function clear(): void

// read or write buffer to clipboard
// The default value of format is FORMAT_PLAIN_TEXT
export function readBuffer(format?: string): Buffer
export function writeBuffer(data: Buffer, format?: string): boolean

// read or write text to clipboard
// The default value of format is FORMAT_PLAIN_TEXT
export function readText(format?: string): string
export function writeText(text: string, format?: string): boolean

// clipboard content fromat, text or file path
export const FORMAT_PLAIN_TEXT: string
export const FORMAT_FILE_URL: string
```

## TODO

- Window
- Linux
- ......

## Support

- MacOS