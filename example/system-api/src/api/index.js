const SYSTEM_EVENT = 'system::event'

export const execute = (key, data) => {
  return window.webkit.messageHandlers[SYSTEM_EVENT].postMessage({ key, data })
}


export const FORMAT_PLAIN_TEXT = 'public.utf8-plain-text'
export const FORMAT_FILE_URL = 'public.file-url'

export const Clipboard = {
  clear: () => execute("clipboard::clear"),
  read: (format = FORMAT_PLAIN_TEXT) => execute("clipboard::read", { format }),
  write: (data, format = FORMAT_PLAIN_TEXT) => execute("clipboard::write", { format, data }),
}


export default {
  FORMAT_PLAIN_TEXT,
  FORMAT_FILE_URL,
  Clipboard,
  execute
}