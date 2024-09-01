import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from '@sveltejs/kit/vite';
import * as path from 'path';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  preprocess: vitePreprocess(),

  kit: {
    adapter: adapter(),
    paths: {
      relative:false
    },
    alias: {
      src: path.resolve('./src'),
      $components: path.resolve('src/lib/components')
    }    
  }
};

export default config;
