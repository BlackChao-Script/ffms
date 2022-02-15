import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import ElementPlus from 'unplugin-element-plus/vite'
import { resolve } from 'path'

export default defineConfig({
  base: './',
  css: {
    preprocessorOptions: {
      less: {
        javascriptEnabled: true,
        additionalData: `@import "${resolve(
          __dirname,
          'src/style/mixin.less'
        )}";`,
      },
    },
  },
  plugins: [vue(), ElementPlus({ useSource: true })],
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:9090/',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
    extensions: ['.js', '.ts'],
  },
})
