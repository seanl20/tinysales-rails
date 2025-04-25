// https://cdn.skypack.dev/-/axios@v1.9.0-xXVbkXf0shxDVskkAq6q/dist=es2019,mode=raw/lib/platform/node/index.js downloaded from https://cdn.skypack.dev/-/axios@v1.9.0-xXVbkXf0shxDVskkAq6q/dist=es2019,mode=raw/lib/platform/browser/index.js

import URLSearchParams from './classes/URLSearchParams.js'
import FormData from './classes/FormData.js'
import Blob from './classes/Blob.js'

export default {
  isBrowser: true,
  classes: {
    URLSearchParams,
    FormData,
    Blob
  },
  protocols: ['http', 'https', 'file', 'blob', 'url', 'data']
};
