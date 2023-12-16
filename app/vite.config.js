import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import Icons from 'unplugin-icons/vite'

export default defineConfig({
  plugins: [
    sveltekit(),
    Icons({
      compiler: 'svelte',
    })
  ],
  build: {
    minify: 'esbuild',
    target: 'es2017'
  },
  test: {
    include: ['src/**/*.{test,spec}.{js,ts}']
  },
  server: {
    host: true
  }
});
